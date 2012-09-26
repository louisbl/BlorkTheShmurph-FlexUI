package crm.gobelins.darkunicorn.views
{
	import crm.gobelins.darkunicorn.models.LangModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class LoginMediator extends Mediator
	{
		[Inject]
		public var view : LoginView;
		[Inject]
		public var langModel : LangModel;
		
		override public function onRegister():void{
			view.data = langModel.current_language.login;
		}
			
	}
}