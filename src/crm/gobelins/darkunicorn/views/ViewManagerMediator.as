package crm.gobelins.darkunicorn.views
{
	import crm.gobelins.darkunicorn.vo.ChangeViewVo;
	import crm.gobelins.darkunicorn.services.UserVo;
	import crm.gobelins.darkunicorn.signals.ChangeViewSignal;
	import crm.gobelins.darkunicorn.signals.GotoEndSignal;
	import crm.gobelins.darkunicorn.signals.GotoFbSignal;
	import crm.gobelins.darkunicorn.signals.GotoGameSignal;
	import crm.gobelins.darkunicorn.signals.GotoHomeSignal;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.View;
	import spark.preloaders.SplashScreenImageSource;
	
	public class ViewManagerMediator extends Mediator
	{
		[Inject]
		public var view : ViewManager;
		[Inject]
		public var change_view_sig : ChangeViewSignal;
		[Inject]
		public var view_ready : GotoSplashSignal;
		
		override public function onRegister():void{
			trace("ViewManagerMediator.onRegister()");
			change_view_sig.add(_onChangeView);
			view_ready.dispatch();
		}
		
		protected function _onChangeView( vo : ChangeViewVo ) : void {
			view.replaceView(vo.viewClass, vo.data );
		}
	}
}