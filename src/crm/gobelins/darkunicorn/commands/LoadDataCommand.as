package crm.gobelins.darkunicorn.commands
{
	import crm.gobelins.darkunicorn.models.LangModel;
	import crm.gobelins.darkunicorn.services.FacebookService;
	
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.robotlegs.utilities.macrobot.AsyncCommand;
	
	public class LoadDataCommand extends AsyncCommand
	{
		[Inject]
		public var langModel : LangModel;
		[Inject]
		public var fbService : FacebookService;
		
		protected var _get_service : HTTPService;
		
		override public function execute():void {
			_get_service = new HTTPService();
			_get_service.url = "assets/languages.xml";
			_get_service.addEventListener(ResultEvent.RESULT, _onLangResult );
			_get_service.send();
		}
		
		protected function _onLangResult(event:ResultEvent):void
		{
			_get_service.removeEventListener(ResultEvent.RESULT, _onLangResult );
			langModel.all_languages = _get_service.lastResult.data.language;
			langModel.base_language = _get_service.lastResult.data.base_language;
			langModel.setLang( langModel.base_language );
			
			_get_service = new HTTPService;
			_get_service.url = "assets/facebook.xml";
			_get_service.addEventListener(ResultEvent.RESULT, _onFbResult );
			_get_service.send();
		}
		
		protected function _onFbResult(event:ResultEvent):void
		{
			fbService.app_id = _get_service.lastResult.data.app_id;
			fbService.permissions = _get_service.lastResult.data.permissions;
			dispatchComplete( true );
		}
	}
}