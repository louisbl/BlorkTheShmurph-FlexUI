package crm.gobelins.darkunicorn.views
{
	import crm.gobelins.darkunicorn.signals.GotoFbSignal;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class SplashMediator extends Mediator
	{
		[Inject]
		public var view : SplashView;
		[Inject]
		public var start_signal : GotoFbSignal;
		
		override public function onRegister():void {
			trace("SplashMediator.onRegister()");
			view.btn_start.addEventListener(MouseEvent.CLICK, _onStartClicked );
		}
		
		protected function _onStartClicked(event:MouseEvent):void
		{
			view.btn_start.removeEventListener(MouseEvent.CLICK, _onStartClicked );
			start_signal.dispatch();
		}
	}
}