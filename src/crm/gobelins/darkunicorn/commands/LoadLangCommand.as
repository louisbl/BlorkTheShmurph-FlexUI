package crm.gobelins.darkunicorn.commands
{
	import crm.gobelins.darkunicorn.models.LangModel;
	
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.robotlegs.utilities.macrobot.AsyncCommand;
	
	public class LoadLangCommand extends AsyncCommand
	{
		[Inject]
		public var langModel : LangModel;
		
		protected var _get_languages : HTTPService;
		
		override public function execute():void {
			_get_languages = new HTTPService();
			_get_languages.url = "assets/languages.xml";
			_get_languages.addEventListener(ResultEvent.RESULT, _onResult );
			_get_languages.send();
		}
		
		protected function _onResult(event:ResultEvent):void
		{
			langModel.all_languages = _get_languages.lastResult.data.language;
			langModel.base_language = _get_languages.lastResult.data.base_language;
			langModel.setLang( langModel.base_language );
			dispatchComplete( true );
		}
	}
}