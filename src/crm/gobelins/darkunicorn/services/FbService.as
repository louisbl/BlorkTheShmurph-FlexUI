package crm.gobelins.darkunicorn.services
{
	import air.net.URLMonitor;
	
	import com.facebook.graph.FacebookMobile;
	import com.facebook.graph.data.FacebookSession;
	
	import crm.gobelins.darkunicorn.signals.ErrorSignal;
	import crm.gobelins.darkunicorn.signals.FbLoggedInSignal;
	import crm.gobelins.darkunicorn.signals.FbLoggedOutSignal;
	import crm.gobelins.darkunicorn.signals.GotoEndSignal;
	import crm.gobelins.darkunicorn.signals.GotoScoreSignal;
	
	import flash.events.StatusEvent;
	import flash.net.NetworkInfo;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;
	
	public class FbService
	{
		[Inject]
		public var logged_in_sig : FbLoggedInSignal;
		[Inject]
		public var logged_out_sig : FbLoggedOutSignal;
		[Inject]
		public var error_sig : ErrorSignal;
		[Inject]
		public var end_sig : GotoEndSignal;
		[Inject]
		public var score_sig : GotoScoreSignal;
		
		protected var _user_data : UserVo;
		protected var _app_id : String;
		protected var _permissions : Array;
		protected var _connected : Boolean;
		protected var _init : Boolean;
		
		public function FbService() {
			_app_id = ResourceManager.getInstance().getString("facebook","app_id");
			_permissions = ResourceManager.getInstance().getStringArray("facebook","permissions");	
		}
		
		public function isEnabled() : Boolean {
			return _init;
		}
		
		protected function _onStatusEvent(event:StatusEvent):void
		{
			var evt : StatusEvent = event;
			trace( ">>onStatusEvent::evt.code=" + evt.code );
			if( evt.code == "Service.available" ){
				_connected = true;
				if( !_init )
					initFacebook();
			}else{
				_connected = false;
				_loginHandler(null,true);
			}
		}
		
		public function testThenInit( ) : void {
			var urlMonitor : URLMonitor;
			var urlRequest : URLRequest = new URLRequest( "http://m.facebook.com" );
			urlMonitor = new URLMonitor( urlRequest );
			urlMonitor.addEventListener( StatusEvent.STATUS, _onStatusEvent );
			urlMonitor.start();
		}
		
		public function initFacebook( ) : void {
			_user_data = new UserVo();
			if( _connected ){
				FacebookMobile.init(_app_id, _initHandler);
			}else
				_loginHandler(null,true);
		}
		
		private function _initHandler(session : FacebookSession, success : Boolean ):void
		{
			if( session || success )
				_init = true;
			logged_out_sig.dispatch();
		}
		
		public function loginFacebook( vo : FbLoginVo ) : void {
			if( !_init )
				initFacebook();
			else
				if( _connected )
					FacebookMobile.login(_loginHandler, vo.stage, _permissions, vo.view );
				else
					_loginHandler(null,true);
		}
		
		public function sendScore(score:int):void
		{
			if( _connected && FacebookMobile.getSession() ){				
				_user_data.score = score;
				var params : Object = {};
				params.access_token = FacebookMobile.getSession().accessToken;
				params.score = _user_data.score;
				FacebookMobile.api("/"+_user_data.user_uid+"/scores",_sendScoreHandler,params,"POST");
			} else {
				_sendScoreHandler(false,false);
			}
		}
		
		public function getLeaderBoard() : void{
			if( _connected && FacebookMobile.getSession() ){
				var params : Object = {};
				params.access_token = FacebookMobile.getSession().accessToken;
				FacebookMobile.api("/"+_app_id+"/scores",_leaderBoardHandler,params);
			} else {
				_leaderBoardHandler(null,false);
			}
		}
		
		private function _leaderBoardHandler( result : Array, success : Boolean ) : void {
			var data : ArrayCollection = new ArrayCollection();
			var usr_vo : UserVo;
			for each (var obj : Object in result) {
				if( obj.application.id == _app_id ) {
					usr_vo = new UserVo();
					usr_vo.score = obj.score;
					usr_vo.user_name = obj.user.name;
					usr_vo.user_uid = obj.user.id;
					usr_vo.user_picture = FacebookMobile.getImageUrl(obj.user.id,"square");
					data.addItem( usr_vo );
				}
			}
			score_sig.dispatch(data);
		}
		
		public function logoutFacebook() : void {
			if( _connected && _init )
				FacebookMobile.logout( _logoutHandler );
			else
				_logoutHandler( false );
		}
		
		protected function _logoutHandler( success : Boolean ):void
		{
			if( success )
				logged_out_sig.dispatch();
			else
				error_sig.dispatch("logout error");
		}		
		
		protected function _loginHandler( session : FacebookSession, fail : Object ) : void {
			if(session)
				prepareUserData( session );
			else
				logged_out_sig.dispatch();
		}
		
		protected function prepareUserData(session:FacebookSession):void
		{
			_user_data.user_uid = session.user.id;
			_user_data.user_name = session.user.first_name;
			_user_data.user_picture = FacebookMobile.getImageUrl( session.uid, "square" );
			logged_in_sig.dispatch( _user_data );
		}
		
		protected function _sendScoreHandler( data : Boolean, success : Boolean ):void
		{
			if( data || success )
				end_sig.dispatch(_user_data);
			else {
				error_sig.dispatch("send score error");				
				end_sig.dispatch(_user_data);
			}
		}
	}
}