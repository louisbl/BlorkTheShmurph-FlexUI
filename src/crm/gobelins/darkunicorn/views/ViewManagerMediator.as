package crm.gobelins.darkunicorn.views
{
	import crm.gobelins.darkunicorn.signals.StartClickedSignal;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.preloaders.SplashScreenImageSource;
	
	public class ViewManagerMediator extends Mediator
	{
		[Inject]
		public var view : ViewManager;
		[Inject]
		public var start_signal : StartClickedSignal;
		
		override public function onRegister():void{
			trace("ViewManagerMediator.onRegister()");
			start_signal.add(_onStartClicked);
			view.pushView(SplashView);
		}
		
		private function _onStartClicked():void
		{
			view.pushView(LoginView);
		}
	}
}