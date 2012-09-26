package crm.gobelins.darkunicorn.views
{
	import crm.gobelins.darkunicorn.models.LangModel;
	import crm.gobelins.darkunicorn.signals.StartClickedSignal;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class SplashMediator extends Mediator
	{
		[Inject]
		public var view : SplashView;
		[Inject]
		public var lang_model : LangModel;
		[Inject]
		public var start_signal : StartClickedSignal;
		
		override public function onRegister():void {
			trace("SplashMediator.onRegister()");
			view.btn_start.addEventListener(MouseEvent.CLICK, _onStartClicked );
			view.data = lang_model.current_language.splash
		}
		
		protected function _onStartClicked(event:MouseEvent):void
		{
			start_signal.dispatch();
		}
	}
}