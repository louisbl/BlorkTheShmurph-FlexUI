package crm.gobelins.darkunicorn.commands
{
	import crm.gobelins.darkunicorn.views.AView;
	import crm.gobelins.darkunicorn.views.ViewManager;
	
	import org.robotlegs.utilities.macrobot.SequenceCommand;
	
	import spark.components.Application;
	
	public class StartupCommand extends SequenceCommand
	{
		override public function execute():void{
			addCommand(LoadLangCommand);
			addCompletionListener(_onComplete);
			super.execute();
		}
		
		private function _onComplete( success : Boolean ):void
		{
			var vm : ViewManager = new ViewManager();
			vm.firstView = AView;
			(contextView as Application).addElement( vm );
		}
	}
}