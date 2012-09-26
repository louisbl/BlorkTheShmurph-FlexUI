package crm.gobelins.darkunicorn.models
{
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class LangModel
	{
		public var current_language : Object;
		public var base_language : String;
		public var all_languages : ArrayCollection;
		
		public function setLang(langTarget : String) : void
		{
			var i : int = 0;
			var allLangLength : int = all_languages.length;
			
			for(i = 0; i < allLangLength; i++)
			{
				if(all_languages[i].lang == langTarget)
				{
					current_language = all_languages[i];
					return;
				}
			}
		}
	}
}