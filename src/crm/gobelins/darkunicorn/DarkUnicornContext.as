package crm.gobelins.darkunicorn
{
	import crm.gobelins.darkunicorn.commands.ErrorCommand;
	import crm.gobelins.darkunicorn.commands.FbGetScoreCommand;
	import crm.gobelins.darkunicorn.commands.FbInitCommand;
	import crm.gobelins.darkunicorn.commands.FbLoginCommand;
	import crm.gobelins.darkunicorn.commands.FbLogoutCommand;
	import crm.gobelins.darkunicorn.commands.FbSendScoreCommand;
	import crm.gobelins.darkunicorn.commands.GotoEndCommand;
	import crm.gobelins.darkunicorn.commands.GotoFbCommand;
	import crm.gobelins.darkunicorn.commands.GotoGameCommand;
	import crm.gobelins.darkunicorn.commands.GotoHomeCommand;
	import crm.gobelins.darkunicorn.commands.GotoScoreCommand;
	import crm.gobelins.darkunicorn.commands.GotoSplashCommand;
	import crm.gobelins.darkunicorn.services.FbService;
	import crm.gobelins.darkunicorn.signals.ChangeViewSignal;
	import crm.gobelins.darkunicorn.signals.ErrorSignal;
	import crm.gobelins.darkunicorn.signals.FbGetScoreSignal;
	import crm.gobelins.darkunicorn.signals.FbInitSignal;
	import crm.gobelins.darkunicorn.signals.FbLoggedInSignal;
	import crm.gobelins.darkunicorn.signals.FbLoggedOutSignal;
	import crm.gobelins.darkunicorn.signals.FbLoginSignal;
	import crm.gobelins.darkunicorn.signals.FbLogoutSignal;
	import crm.gobelins.darkunicorn.signals.FbSendScoreSignal;
	import crm.gobelins.darkunicorn.signals.GotoEndSignal;
	import crm.gobelins.darkunicorn.signals.GotoFbSignal;
	import crm.gobelins.darkunicorn.signals.GotoGameSignal;
	import crm.gobelins.darkunicorn.signals.GotoHomeSignal;
	import crm.gobelins.darkunicorn.signals.GotoScoreSignal;
	import crm.gobelins.darkunicorn.views.AView;
	import crm.gobelins.darkunicorn.views.EndMediator;
	import crm.gobelins.darkunicorn.views.EndView;
	import crm.gobelins.darkunicorn.views.GameMediator;
	import crm.gobelins.darkunicorn.views.GameView;
	import crm.gobelins.darkunicorn.views.GotoSplashSignal;
	import crm.gobelins.darkunicorn.views.HomeMediator;
	import crm.gobelins.darkunicorn.views.HomeView;
	import crm.gobelins.darkunicorn.views.LoginMediator;
	import crm.gobelins.darkunicorn.views.LoginView;
	import crm.gobelins.darkunicorn.views.SplashMediator;
	import crm.gobelins.darkunicorn.views.SplashView;
	import crm.gobelins.darkunicorn.views.ViewManager;
	import crm.gobelins.darkunicorn.views.ViewManagerMediator;
	
	import org.robotlegs.mvcs.SignalContext;
	
	import spark.components.Application;
	
	public class DarkUnicornContext extends SignalContext
	{
		public function DarkUnicornContext()
		{
			super();
		}
		
		override public function startup() : void {
			injector.mapSingleton(FbService);
			
			signalCommandMap.mapSignalClass(ErrorSignal,ErrorCommand);
			signalCommandMap.mapSignalClass(GotoSplashSignal,GotoSplashCommand);
			signalCommandMap.mapSignalClass(GotoFbSignal,GotoFbCommand);
			signalCommandMap.mapSignalClass(GotoHomeSignal,GotoHomeCommand);
			signalCommandMap.mapSignalClass(GotoGameSignal,GotoGameCommand);
			signalCommandMap.mapSignalClass(GotoEndSignal,GotoEndCommand);
			signalCommandMap.mapSignalClass(GotoScoreSignal,GotoScoreCommand);
			
			injector.mapSingleton(ChangeViewSignal);
			
			
			injector.mapSingleton(FbLoggedInSignal);
			injector.mapSingleton(FbLoggedOutSignal);
			
			signalCommandMap.mapSignalClass(FbLoginSignal,FbLoginCommand);
			signalCommandMap.mapSignalClass(FbInitSignal,FbInitCommand);
			signalCommandMap.mapSignalClass(FbLogoutSignal,FbLogoutCommand);
			signalCommandMap.mapSignalClass(FbSendScoreSignal,FbSendScoreCommand);
			signalCommandMap.mapSignalClass(FbGetScoreSignal,FbGetScoreCommand);
			
			mediatorMap.mapView(GameView, GameMediator );
			mediatorMap.mapView(ViewManager,ViewManagerMediator);
			mediatorMap.mapView(SplashView,SplashMediator);
			mediatorMap.mapView(HomeView,HomeMediator);
			mediatorMap.mapView(LoginView,LoginMediator);
			mediatorMap.mapView(EndView,EndMediator);
			
			var vm : ViewManager = new ViewManager();
			vm.firstView = AView;
			(contextView as Application).addElement( vm );
			
			super.startup();
		}
	}
}