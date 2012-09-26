package crm.gobelins.darkunicorn.commands
{
	import crm.gobelins.darkunicorn.services.FacebookService;
	
	import org.robotlegs.mvcs.Command;
	
	public class FbLoginCommand extends Command
	{
		[Inject]
		public var fb_serv : FacebookService;
		
		override public function execute() : void {
			fb_serv.loginFacebook();
		}
	}
}