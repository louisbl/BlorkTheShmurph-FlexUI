package crm.gobelins.darkunicorn.commands
{
	import org.robotlegs.mvcs.Command;
	
	public class ErrorCommand extends Command
	{
		[Inject]
		public var message : String;
		
		override public function execute():void{
			trace("ErrorCommand.execute() ::: "+message);
		}
	}
}