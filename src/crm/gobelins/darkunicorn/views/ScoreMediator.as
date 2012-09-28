package crm.gobelins.darkunicorn.views
{
	import crm.gobelins.darkunicorn.signals.GotoGameSignal;
	import crm.gobelins.darkunicorn.signals.GotoHomeSignal;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ScoreMediator extends Mediator
	{
		[Inject]
		public var view : ScoreView;
		[Inject]
		public var game_sig : GotoGameSignal;
		[Inject]
		public var home_sig : GotoHomeSignal;
		
		override public function onRegister():void{
			view.btn_home_signal.add(_onHomeClicked);
			view.btn_play_signal.add(_onPlayClicked);
		}
		
		override public function onRemove():void{
			view.btn_home_signal.removeAll();
			view.btn_play_signal.removeAll();
		}
		
		protected function _onHomeClicked():void
		{
			home_sig.dispatch();
		}
		
		protected function _onPlayClicked():void
		{
			game_sig.dispatch();	
		}
	}
}