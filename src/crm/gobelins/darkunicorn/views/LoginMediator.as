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
			fb_serv.logged_out_signal.add(_onLoggedOut);
			score_serv.logged_in_signal.add(_onLoggedIn);
			
			view.btn_fb_login_signal.add(_onFbLoginClicked );
			view.btn_nick_signal.add( _onNicknameClicked );
			view.btn_logout_signal.add( _onLogoutClicked );
			view.btn_play_signal.add(_onPlayClicked);
			
			fb_serv.testThenInit();
		}
		
		override public function onRemove():void{
			fb_serv.logged_out_signal.remove(_onLoggedOut);
			view.btn_fb_login_signal.removeAll();
			view.btn_nick_signal.removeAll();
			view.btn_logout_signal.removeAll();
		}
		
		protected function _onLoggedIn( user : UserVo ):void
		{
			view.data = user;
			view.onLoggedIn();
		}
		
		protected function _onNicknameClicked(nickname : String):void
		{
			score_serv.setUser( nickname );
		}
		
		protected function _onLoggedOut():void
		{
			view.onLoggedOut();
		}
		
		protected function _onLogoutClicked():void
		{
			fb_serv.logoutFacebook();
		}
		
		protected function _onFbLoginClicked():void
		{
			fb_serv.loginFacebook(view.login_vo);
		}
		
		protected function _onPlayClicked():void
		{
			home_sig.dispatch();				
		}
		
	}
}