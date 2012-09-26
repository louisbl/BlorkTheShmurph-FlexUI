package crm.gobelins.darkunicorn.commands
{
	import crm.gobelins.darkunicorn.services.FbService;
	
	import org.robotlegs.mvcs.Command;
	
	public class FbLogoutCommand extends Command
	{
		[Inject]
		public var fb_serv : FbService;

		override public function execute():void {
			fb_serv.logoutFacebook();
		}
	}
}