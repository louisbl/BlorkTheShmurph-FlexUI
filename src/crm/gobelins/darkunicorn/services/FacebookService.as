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
		public var permissions : Array;
		public var app_id : String;
		
		public function initFacebook( ) : void {
			FacebookMobile.init(app_id, _loginHandler);
		}
		
		public function loginFacebook( ) : void {
			
		}
		
		protected function _loginHandler( session : FacebookSession, fail : Object ) : void {
		}
	}
}