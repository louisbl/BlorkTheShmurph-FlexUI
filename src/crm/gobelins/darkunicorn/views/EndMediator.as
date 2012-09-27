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
			view.btn_play.addEventListener(MouseEvent.CLICK,_onPlayClicked);
			view.btn_halloffame.addEventListener(MouseEvent.CLICK,_onScoreClicked);
			view.btn_home.addEventListener(MouseEvent.CLICK, _onHomeClicked);
		}
		
		override public function onRemove():void{
			view.btn_play.removeEventListener(MouseEvent.CLICK,_onPlayClicked);
			view.btn_halloffame.removeEventListener(MouseEvent.CLICK,_onScoreClicked);
			view.btn_home.removeEventListener(MouseEvent.CLICK, _onHomeClicked);			
		}
		
		protected function _onHomeClicked(event:MouseEvent):void
		{
			view.btn_home.removeEventListener(MouseEvent.CLICK, _onHomeClicked);
			home_sig.dispatch();
		}
		
		protected function _onScoreClicked(event:MouseEvent):void
		{
			view.btn_halloffame.removeEventListener(MouseEvent.CLICK,_onScoreClicked);
			score_serv.getAllScores();
		}
		
		protected function _onPlayClicked(event:MouseEvent):void
		{
			view.btn_play.removeEventListener(MouseEvent.CLICK,_onPlayClicked);
			game_sig.dispatch();	
		}
	}
}