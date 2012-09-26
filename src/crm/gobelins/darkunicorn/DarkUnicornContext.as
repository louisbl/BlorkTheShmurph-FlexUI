package crm.gobelins.darkunicorn
{
	import crm.gobelins.darkunicorn.commands.StartupCommand;
	import crm.gobelins.darkunicorn.models.LangModel;
	import crm.gobelins.darkunicorn.services.FacebookService;
	import crm.gobelins.darkunicorn.signals.StartClickedSignal;
	import crm.gobelins.darkunicorn.views.AView;
	import crm.gobelins.darkunicorn.views.HomeMediator;
	import crm.gobelins.darkunicorn.views.HomeView;
	import crm.gobelins.darkunicorn.views.SplashMediator;
	import crm.gobelins.darkunicorn.views.SplashView;
	import crm.gobelins.darkunicorn.views.ViewManager;
	import crm.gobelins.darkunicorn.views.ViewManagerMediator;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	import spark.components.Application;
	
	public class DarkUnicornContext extends Context
	{
		public function DarkUnicornContext()
		{
			super();
		}
		
		override public function startup() : void {
			injector.mapSingleton(FacebookService);
			injector.mapSingleton(LangModel);
			
			injector.mapSingleton(StartClickedSignal);
			
			mediatorMap.mapView(ViewManager,ViewManagerMediator);
			mediatorMap.mapView(SplashView,SplashMediator);
			mediatorMap.mapView(HomeView,HomeMediator);
			commandMap.execute(StartupCommand);
			super.startup();
		}
	}
}