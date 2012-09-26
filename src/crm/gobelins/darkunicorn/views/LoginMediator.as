package crm.gobelins.darkunicorn.views
{
	import com.facebook.graph.data.FacebookSession;
	
	import crm.gobelins.darkunicorn.services.FbLoginVo;
	import crm.gobelins.darkunicorn.services.FbUserVo;
	import crm.gobelins.darkunicorn.signals.FbInitSignal;
	import crm.gobelins.darkunicorn.signals.FbLoggedInSignal;
	import crm.gobelins.darkunicorn.signals.FbLoggedOutSignal;
	import crm.gobelins.darkunicorn.signals.FbLoginSignal;
	import crm.gobelins.darkunicorn.signals.FbLogoutSignal;
	import crm.gobelins.darkunicorn.signals.GotoGameSignal;
	import crm.gobelins.darkunicorn.signals.GotoHomeSignal;
	
	import flash.events.MouseEvent;
	import flash.media.StageWebView;
	
	import mx.events.StateChangeEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class LoginMediator extends Mediator
	{
		[Inject]
		public var view : LoginView;
		[Inject]
		public var fb_login_signal : FbLoginSignal;
		[Inject]
		public var fb_init_signal : FbInitSignal;
		[Inject]
		public var fb_logout_signal : FbLogoutSignal;
		[Inject]
		public var fb_logged_in_signal : FbLoggedInSignal;
		[Inject]
		public var fb_logged_out_signal : FbLoggedOutSignal;
		[Inject]
		public var home_sig : GotoHomeSignal;
		
		override public function onRegister():void{
			fb_logged_in_signal.add(_onFbLoggedIn);
			fb_logged_out_signal.add(_onFbLoggedOut);
			
			fb_init_signal.dispatch();
		}
		
		override public function onRemove():void{
			fb_logged_in_signal.remove(_onFbLoggedIn);
			fb_logged_out_signal.remove(_onFbLoggedOut);
		}
		
		protected function _onFbLoggedOut():void
		{
			trace("LoginMediator._onFbLoggedOut()");
			view.onFbLoggedOut();
			view.btn_login.addEventListener(MouseEvent.CLICK,_onLoginClicked);
		}
		
		protected function _onFbLoggedIn( data : FbUserVo ):void
		{
			view.data = data;
			view.onFbLoggedIn();
			view.btn_logout.addEventListener(MouseEvent.CLICK, _onLogoutClicked );
			view.btn_play.addEventListener(MouseEvent.CLICK, _onHomeClicked );
			trace("LoginMediator._onFbLoggedIn(session)");
		}
		
		protected function _onHomeClicked(event:MouseEvent):void
		{
			view.btn_play.removeEventListener(MouseEvent.CLICK, _onHomeClicked );
			home_sig.dispatch();	
		}
		
		protected function _onLogoutClicked(event:MouseEvent):void
		{
			view.btn_logout.removeEventListener(MouseEvent.CLICK, _onLogoutClicked );
			fb_logout_signal.dispatch();
		}
		
		protected function _onLoginClicked(event:MouseEvent):void
		{
			view.btn_login.removeEventListener(MouseEvent.CLICK,_onLoginClicked);
			fb_login_signal.dispatch( view.login_vo);
		}
		
	}
}