package crm.gobelins.darkunicorn.services
{
	import com.facebook.graph.FacebookMobile;
	import com.facebook.graph.data.FacebookSession;
	
	import crm.gobelins.darkunicorn.signals.ErrorSignal;
	import crm.gobelins.darkunicorn.signals.FbLoggedInSignal;
	import crm.gobelins.darkunicorn.signals.FbLoggedOutSignal;
	import crm.gobelins.darkunicorn.signals.GotoEndSignal;
	import crm.gobelins.darkunicorn.signals.GotoScoreSignal;
	
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
		
		protected var _user_data : FbUserVo;
		protected var _app_id : String;
		protected var _permissions : Array;
		
		public function FbService() {
			_app_id = ResourceManager.getInstance().getString("facebook","app_id");
			_permissions = ResourceManager.getInstance().getStringArray("facebook","permissions");			
		}
		
		public function initFacebook( ) : void {
			_user_data = new FbUserVo();
			FacebookMobile.init(_app_id, _loginHandler);
		}
		
		public function loginFacebook( vo : FbLoginVo ) : void {
			FacebookMobile.login(_loginHandler, vo.stage, _permissions, vo.view );
		}
		
		public function sendScore(score:int):void
		{
			_user_data.score = score;
			var params : Object = {};
			params.access_token = FacebookMobile.getSession().accessToken;
			params.score = _user_data.score;
			FacebookMobile.api("/"+_user_data.user_uid+"/scores",_sendScoreHandler,params,"POST");
		}
		
		public function getLeaderBoard() : void{
			var params : Object = {};
			params.access_token = FacebookMobile.getSession().accessToken;
			FacebookMobile.api("/"+_app_id+"/scores",_leaderBoardHandler,params);
		}
		
		private function _leaderBoardHandler( data : Object, success : Boolean ) : void {
			trace("FbService._leaderBoardHandler(data, success)");
			score_sig.dispatch(data);
		}
		
		public function logoutFacebook() : void {
			FacebookMobile.logout( _logoutHandler );
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
			_user_data.user_picture = FacebookMobile.getImageUrl( session.uid, "large" );
			logged_in_sig.dispatch( _user_data );
		}
		
		protected function _sendScoreHandler( data : Object, success : Boolean ):void
		{
			if( success )
				end_sig.dispatch(_user_data);
			else {
				error_sig.dispatch("send score error");				
				end_sig.dispatch(_user_data);
			}
		}
	}
}