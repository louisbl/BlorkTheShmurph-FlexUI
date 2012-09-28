package crm.gobelins.darkunicorn.commands
{
	import crm.gobelins.darkunicorn.vo.ChangeViewVo;
	import crm.gobelins.darkunicorn.signals.ChangeViewSignal;
	import crm.gobelins.darkunicorn.views.LoginView;
	
	import org.robotlegs.mvcs.Command;
	
	public class GotoFbCommand extends Command
	{
		[Inject]
		public var change_view_sig : ChangeViewSignal;
		
		override public function execute():void {
			var vo : ChangeViewVo = new ChangeViewVo();
			vo.viewClass = LoginView;
			change_view_sig.dispatch( vo );
		}
	}
}