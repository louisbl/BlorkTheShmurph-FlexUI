package crm.gobelins.darkunicorn.commands
{
	import crm.gobelins.darkunicorn.models.ChangeViewVo;
	import crm.gobelins.darkunicorn.signals.ChangeViewSignal;
	import crm.gobelins.darkunicorn.views.ScoreView;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class GotoScoreCommand extends Command
	{
		[Inject]
		public var change_view_sig : ChangeViewSignal;
		[Inject]
		public var data : ArrayCollection;
		
		override public function execute():void {
			var vo : ChangeViewVo = new ChangeViewVo();
			vo.viewClass = ScoreView;
			vo.data = data;
			change_view_sig.dispatch( vo );
		}
	}
}