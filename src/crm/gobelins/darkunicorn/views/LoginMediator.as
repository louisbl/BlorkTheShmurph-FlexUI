package crm.gobelins.darkunicorn.views
{
	import com.facebook.graph.data.FacebookSession;
	
	import crm.gobelins.darkunicorn.services.FbLoginVo;
	import crm.gobelins.darkunicorn.services.FbService;
	import crm.gobelins.darkunicorn.services.ScoreService;
	import crm.gobelins.darkunicorn.services.UserVo;
	import crm.gobelins.darkunicorn.signals.FbLoggedInSignal;
	import crm.gobelins.darkunicorn.signals.FbLoggedOutSignal;
	import crm.gobelins.darkunicorn.signals.GotoGameSignal;
	import crm.gobelins.darkunicorn.signals.GotoHomeSignal;
	import crm.gobelins.darkunicorn.signals.LocalLoggedInSignal;
	
	import flash.events.MouseEvent;
	import flash.media.StageWebView;
	
	import mx.events.StateChangeEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class LoginMediator extends Mediator
	{
		[Inject]
		public var view : LoginView;
		[Inject]
		public var fb_serv : FbService;
		[Inject]
		public var score_serv : ScoreService;
		[Inject]
		public var home_sig : GotoHomeSignal;
		
		override public function onRegister():void{
			view.addEventListener(StateChangeEvent.CURRENT_STATE_CHANGE,_onStateChanged);

			fb_serv.logged_out_signal.add(_onLoggedOut);
			score_serv.logged_in_signal.add(_onLoggedIn);
			
			fb_serv.testThenInit();
		}
		
		protected function _onLoggedIn( user : UserVo ):void
		{
			view.data = user;
			view.onLoggedIn();
			view.btn_play.addEventListener(MouseEvent.CLICK, _onHomeClicked );
			view.btn_logout.addEventListener(MouseEvent.CLICK, _onLogoutClicked );
		}
		
		protected function _onStateChanged(event:StateChangeEvent):void
		{
			if( event.newState == "local" )
				view.btn_nickname.addEventListener( MouseEvent.CLICK,_onNicknameClicked);
		}
		
		protected function _onNicknameClicked(event:MouseEvent):void
		{
			view.btn_nickname.removeEventListener( MouseEvent.CLICK,_onNicknameClicked);
			score_serv.setUser( view.nickname.text );
		}
		
		override public function onRemove():void{
			fb_serv.logged_out_signal.remove(_onLoggedOut);
		}
		
		protected function _onLoggedOut():void
		{
			trace("LoginMediator._onFbLoggedOut()");
			view.onLoggedOut();
			view.btn_login.addEventListener(MouseEvent.CLICK,_onLoginClicked);
		}
		
		protected function _onHomeClicked(event:MouseEvent):void
		{
			view.btn_play.removeEventListener(MouseEvent.CLICK, _onHomeClicked );
			home_sig.dispatch();	
		}
		
		protected function _onLogoutClicked(event:MouseEvent):void
		{
			view.btn_logout.removeEventListener(MouseEvent.CLICK, _onLogoutClicked );
			fb_serv.logoutFacebook();
		}
		
		protected function _onLoginClicked(event:MouseEvent):void
		{
			view.btn_cancel.addEventListener(MouseEvent.CLICK,_onCancelClicked);
			view.btn_login.removeEventListener(MouseEvent.CLICK,_onLoginClicked);
			fb_serv.loginFacebook(view.login_vo);
		}
		
		protected function _onCancelClicked(event:MouseEvent):void
		{
			view.btn_cancel.removeEventListener(MouseEvent.CLICK,_onCancelClicked);
			view.btn_login.addEventListener(MouseEvent.CLICK,_onLoginClicked);	
		}
		
	}
}