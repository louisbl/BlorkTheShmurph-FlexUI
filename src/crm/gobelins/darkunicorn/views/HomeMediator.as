package crm.gobelins.darkunicorn.views
{
	import org.robotlegs.mvcs.Mediator;
	
	public class HomeMediator extends Mediator
	{
		[Inject]
		public var view : HomeView;
		
		override public function onRegister() : void {
			trace("HomeMediator.onRegister()");
			
		}
	}
}