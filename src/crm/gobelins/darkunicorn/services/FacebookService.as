package crm.gobelins.darkunicorn.services
{
	import com.facebook.graph.FacebookMobile;
	import com.facebook.graph.data.FacebookSession;
	
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.robotlegs.mvcs.Actor;

	public class FacebookService extends Actor
	{
		public var fb_session : FacebookSession;
		
		protected var getFacebook : HTTPService;
		protected var _permissions : Array;
		protected var _app_id : String;
		
		public function FacebookService()
		{
			getFacebook = new HTTPService();
			getFacebook.url = "assets/facebook.xml";
			getFacebook.addEventListener(ResultEvent.RESULT, _onResult);
		}
		
		protected function _onResult(event:ResultEvent):void
		{
			getFacebook.removeEventListener(ResultEvent.RESULT, _onResult);
			_app_id = getFacebook.lastResult.data.app_id;
			_permissions = [];
			_initFacebook();
		}
		
		protected function _initFacebook( ) : void {
			FacebookMobile.init(_app_id, _loginHandler);
		}
		
		protected function _loginHandler( session : FacebookSession, fail : Object ) : void {
			fb_session = session;
		}
	}
}