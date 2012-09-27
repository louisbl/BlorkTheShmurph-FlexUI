package crm.gobelins.darkunicorn.commands
{
	import crm.gobelins.darkunicorn.vo.ChangeViewVo;
	import crm.gobelins.darkunicorn.services.ScoreService;
	import crm.gobelins.darkunicorn.signals.ChangeViewSignal;
	import crm.gobelins.darkunicorn.views.HomeView;
	
	import org.robotlegs.mvcs.Command;
	
	public class GotoHomeCommand extends Command
	{
		[Inject]
		public var change_view_sig : ChangeViewSignal;
		[Inject]
		public var score_serv : ScoreService;
		
		override public function execute():void {
			var vo : ChangeViewVo = new ChangeViewVo();
			vo.viewClass = HomeView;
			vo.data = score_serv.user_vo;
			change_view_sig.dispatch( vo );
		}
	}
}