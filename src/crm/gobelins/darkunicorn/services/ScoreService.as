package crm.gobelins.darkunicorn.services
{
	import crm.gobelins.darkunicorn.signals.GotoScoreSignal;
	import crm.gobelins.darkunicorn.signals.LocalLoggedInSignal;
	
	import flash.net.SharedObject;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;

	public class ScoreService
	{
		[Inject]
		public var fb_serv : FbService;
		[Inject]
		public var score_sig : GotoScoreSignal;
		[Inject]
		public var local_logged_in_signal : LocalLoggedInSignal;
		
		protected var _so : SharedObject;
		protected var _users: Array;
		protected var _user_current : String;
		protected var _best_score : int;
		protected var _score_current : int;
		protected var _user_vo : UserVo;
		
		public function ScoreService()
		{
			_so = SharedObject.getLocal("score_darkunicorn");
			_users = _so.data.users;
		}
		
		public function setUser( user_name : String ) : void {
			_user_current = user_name;
			if(_users && _users.length > 0 ){
				for each (var user : Object in _users ) 
				{
					if( user.user_name == _user_current ){
						_best_score = user.score;
						break;
					}
				}
			}
			_user_vo = new UserVo();
			_user_vo.score = _best_score;
			_user_vo.user_name = user_name;
			local_logged_in_signal.dispatch(_user_vo);
		}
		
		public function setScore(score:int):void
		{
			_score_current = score;
			if( score > _score_current )
				_best_score = _score_current;
			fb_serv.sendScore(_score_current);
		}
		
		public function getAllScores():void
		{
			if( fb_serv.isEnabled() )
				fb_serv.getLeaderBoard();
			else {
				var data : ArrayCollection = new ArrayCollection();
				score_sig.dispatch( data );
			}
		}
	}
}
