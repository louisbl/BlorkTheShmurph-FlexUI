package crm.gobelins.darkunicorn.commands
{
	import crm.gobelins.darkunicorn.services.FbService;
	
	import org.robotlegs.mvcs.Command;
	
	public class FbGetScoreCommand extends Command
	{
		[Inject]
		public var fb_service : FbService;
		
		override public function execute():void{
			fb_service.getLeaderBoard();
		}
	}
}