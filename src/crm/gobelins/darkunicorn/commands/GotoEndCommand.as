package crm.gobelins.darkunicorn.commands
{
	import crm.gobelins.darkunicorn.models.ChangeViewVo;
	import crm.gobelins.darkunicorn.services.FbUserVo;
	import crm.gobelins.darkunicorn.signals.ChangeViewSignal;
	import crm.gobelins.darkunicorn.views.EndView;
	
	import org.robotlegs.mvcs.Command;
	
	public class GotoEndCommand extends Command
	{
		[Inject]
		public var data : FbUserVo;
		[Inject]
		public var change_view_sig : ChangeViewSignal;
		
		override public function execute():void {
			var vo : ChangeViewVo = new ChangeViewVo();
			vo.viewClass = EndView;
			vo.data = data;
			change_view_sig.dispatch( vo );
		}
	}
}