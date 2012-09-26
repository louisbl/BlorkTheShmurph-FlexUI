package crm.gobelins.darkunicorn.views
{
	import crm.gobelins.darkunicorn.signals.GotoGameSignal;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class HomeMediator extends Mediator
	{
		[Inject]
		public var view : HomeView;
		[Inject]
		public var play_sig : GotoGameSignal;
		
		override public function onRegister() : void {
			trace("HomeMediator.onRegister()");
			view.btn_play.addEventListener(MouseEvent.CLICK,_onPlayClicked);
		}
		
		protected function _onPlayClicked(event:MouseEvent):void
		{
			play_sig.dispatch();
		}
	}
}