package crm.gobelins.darkunicorn.views
{
	import org.robotlegs.mvcs.Mediator;
	
	public class ScoreMediator extends Mediator
	{
		[Inject]
		public var view : ScoreView;
		
		override public function onRegister():void{
			
		}
	}
}