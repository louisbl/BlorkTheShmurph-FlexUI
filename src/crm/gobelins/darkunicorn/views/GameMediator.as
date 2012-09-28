package crm.gobelins.darkunicorn.views
{
	import com.gobelins.DarkUnicorn.api.IGameCore;
	
	import crm.gobelins.darkunicorn.services.FbService;
	import crm.gobelins.darkunicorn.services.ScoreService;
	import crm.gobelins.darkunicorn.signals.GotoEndSignal;
	import crm.gobelins.darkunicorn.signals.GotoFbSignal;
	import crm.gobelins.darkunicorn.signals.GotoHomeSignal;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mx.events.StateChangeEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class GameMediator extends Mediator
	{
		[Inject]
		public var view : GameView;
		[Inject]
		public var home_sig : GotoHomeSignal;
		[Inject]
		public var score_serv : ScoreService;
		
		override public function onRegister():void{
			view.finish_signal.add(_onFinish);
			view.btn_cancel_signal.add(_onCancelClicked);
		}
		
		override public function onRemove():void{
			view.finish_signal.removeAll();
			view.btn_cancel_signal.removeAll();
		}
		
		protected function _onScoreClicked():void
		{
			_onFinish( 3800 );
		}
		
		protected function _onFinish( score : int ) : void {
			score_serv.setScore( score );
		}
		
		protected function _onCancelClicked():void
		{
			home_sig.dispatch();
		}
	}
}