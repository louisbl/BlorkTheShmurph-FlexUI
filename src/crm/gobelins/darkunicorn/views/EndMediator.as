package crm.gobelins.darkunicorn.views
{
	import crm.gobelins.darkunicorn.services.ScoreService;
	import crm.gobelins.darkunicorn.signals.GotoGameSignal;
	import crm.gobelins.darkunicorn.signals.GotoHomeSignal;
	import crm.gobelins.darkunicorn.signals.GotoScoreSignal;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class EndMediator extends Mediator
	{
		[Inject]
		public var view : EndView;
		[Inject]
		public var game_sig : GotoGameSignal;
		[Inject]
		public var score_serv : ScoreService;
		[Inject]
		public var home_sig : GotoHomeSignal;
		
		override public function onRegister():void{
			view.btn_home_signal.add(_onHomeClicked);
			view.btn_hof_signal.add(_onScoreClicked);
			view.btn_play_signal.add(_onPlayClicked);
		}
		
		override public function onRemove():void{
			view.btn_hof_signal.removeAll();
			view.btn_home_signal.removeAll();
			view.btn_play_signal.removeAll();
		}
		
		protected function _onHomeClicked():void
		{
			home_sig.dispatch();
		}
		
		protected function _onScoreClicked():void
		{
			score_serv.getAllScores();
		}
		
		protected function _onPlayClicked():void
		{
			game_sig.dispatch();	
		}
	}
}