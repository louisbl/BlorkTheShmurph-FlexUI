package crm.gobelins.darkunicorn
{
	import crm.gobelins.darkunicorn.commands.FbLoginCommand;
	import crm.gobelins.darkunicorn.commands.StartupCommand;
	import crm.gobelins.darkunicorn.models.LangModel;
	import crm.gobelins.darkunicorn.services.FacebookService;
	import crm.gobelins.darkunicorn.signals.FbLoginSignal;
	import crm.gobelins.darkunicorn.signals.StartClickedSignal;
	import crm.gobelins.darkunicorn.views.AView;
	import crm.gobelins.darkunicorn.views.HomeMediator;
	import crm.gobelins.darkunicorn.views.HomeView;
	import crm.gobelins.darkunicorn.views.LoginMediator;
	import crm.gobelins.darkunicorn.views.LoginView;
	import crm.gobelins.darkunicorn.views.SplashMediator;
	import crm.gobelins.darkunicorn.views.SplashView;
	import crm.gobelins.darkunicorn.views.ViewManager;
	import crm.gobelins.darkunicorn.views.ViewManagerMediator;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.base.SignalCommandMap;
	import org.robotlegs.mvcs.Context;
	import org.robotlegs.mvcs.SignalContext;
	
	import spark.components.Application;
	
	public class DarkUnicornContext extends SignalContext
	{
		public function DarkUnicornContext()
		{
			super();
		}
		
		override public function startup() : void {
			injector.mapSingleton(FacebookService);
			injector.mapSingleton(LangModel);
			
			injector.mapSingleton(StartClickedSignal);
			
			signalCommandMap.mapSignal(FbLoginSignal,FbLoginCommand);
			
			mediatorMap.mapView(ViewManager,ViewManagerMediator);
			mediatorMap.mapView(SplashView,SplashMediator);
			mediatorMap.mapView(HomeView,HomeMediator);
			mediatorMap.mapView(LoginView,LoginMediator);
			commandMap.execute(StartupCommand);
			super.startup();
		}
	}
}