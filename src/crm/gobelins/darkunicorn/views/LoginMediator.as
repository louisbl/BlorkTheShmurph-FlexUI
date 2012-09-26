package crm.gobelins.darkunicorn.views
{
	import crm.gobelins.darkunicorn.models.LangModel;
	import crm.gobelins.darkunicorn.signals.FbLoginSignal;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class LoginMediator extends Mediator
	{
		[Inject]
		public var view : LoginView;
		[Inject]
		public var langModel : LangModel;
		[Inject]
		public var fb_login_signal : FbLoginSignal;
		
		override public function onRegister():void{
			view.btn_login.addEventListener(MouseEvent.CLICK,_onLoginClicked);
			view.data = langModel.current_language.login;
		}
		
		protected function _onLoginClicked(event:MouseEvent):void
		{
			fb_login_signal.dispatch();
		}
		
	}
}