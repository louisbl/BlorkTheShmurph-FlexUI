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
			view.btn_start_sig.addOnce(_onStartClicked);
		}
		
		override public function onRemove():void{
			view.btn_start_sig.removeAll();			
		}
		
		protected function _onStartClicked():void
		{
			start_signal.dispatch();
		}
	}
}