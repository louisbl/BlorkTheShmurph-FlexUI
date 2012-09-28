package crm.gobelins.darkunicorn.services
{
	import crm.gobelins.darkunicorn.commands.GotoEndCommand;
	import crm.gobelins.darkunicorn.signals.GotoEndSignal;
	import crm.gobelins.darkunicorn.signals.GotoScoreSignal;
	import crm.gobelins.darkunicorn.signals.LocalLoggedInSignal;
	
	import flash.net.SharedObject;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.resources.ResourceManager;
	
	import spark.collections.SortField;
	import spark.components.TextInput;

	public class ScoreService
	{
		[Inject]
		public var score_sig : GotoScoreSignal;
		[Inject]
		public var end_sig : GotoEndSignal;
		
		public var logged_in_signal : LocalLoggedInSignal;
		public var user_vo : UserVo;

		protected var _fb_serv : FbService;
		protected var _so : SharedObject;
		protected var _users: Array;
		protected var _best_score : int;
		protected var scoreSort : Sort;
		protected var scoreSortField : SortField;
		
		
		public function ScoreService(fb_serv:FbService)
		{
			scoreSortField = new SortField();
			scoreSortField.name = "score";
			scoreSortField.numeric = true;
			scoreSortField.descending = true;
			
			scoreSort = new Sort();
			scoreSort.fields = [scoreSortField];
			
			_fb_serv = fb_serv;
			fb_serv.logged_in_signal.add(_onFbLoggedIn);
			fb_serv.score_signal.add(_onFbScore);
			_best_score = 0;
			
			logged_in_signal = new LocalLoggedInSignal();
			_so = SharedObject.getLocal("score_darkunicorn");
			_users = _so.data.users;
			if( !_users )
				_users = [];			
		}
		
		public function setUser( nickname : String ) : void {
			user_vo = new UserVo();
			user_vo.user_name = nickname;
			
			_storeNewUser(user_vo);

			user_vo.score = _findUserBestScore(user_vo);
			_best_score = user_vo.score;
			
			logged_in_signal.dispatch(user_vo);
		}
		
		public function setScore(score:int):void
		{
			if( score > _best_score ){
				_best_score = score;
			}
			if( _fb_serv.isEnabled() )
				_fb_serv.sendScore(score);
			else {
				end_sig.dispatch(user_vo);
			}
			user_vo.score = _best_score;
			_so.data.users = _users;
		}
		
		public function getAllScores():void
		{
			if( _fb_serv.isEnabled() )
				_fb_serv.getLeaderBoard();
			else {
				var data : ArrayCollection = new ArrayCollection(_users);
				data.sort = scoreSort;
				data.refresh();
				score_sig.dispatch( data );
			}
		}
		
		protected function _findUserBestScore(vo:UserVo):int
		{
			if(_users && _users.length > 0 ){
				for each (var user : Object in _users ) 
				{
					if( user.user_name == vo.user_name ){
						return user.score;
					}
				}
			}
			return 0;
		}
		
		protected function _onFbScore(result : ArrayCollection):void{
			for each (var vo:Object in _users) 
			{
				result.addItem(vo);
			}
			result.sort = scoreSort;
			result.refresh();
			score_sig.dispatch( result );
		}

		protected function _onFbLoggedIn(vo : UserVo):void
		{
			user_vo = vo;
			_best_score = user_vo.score;
			logged_in_signal.dispatch(user_vo);
		}
		
		protected function _storeNewUser(vo:UserVo) : void {
			if( !_userExists(vo) ){
				_users.push(vo);				
				_so.data.users = _users;			
			}
		}
		
		protected function _userExists( vo : UserVo ) : Boolean {
			var found : Boolean;
			if(_users && _users.length > 0 ){
				for each (var user : Object in _users ) 
				{
					if( user.user_name == user_vo.user_name ){
						found = true;
						break;
					}
				}
			}
			return found;
		}
		
		protected function _sortOnScore( a : Object, b : Object) : int{
			if( a.score > b.score )
				return 1;
			if( a.score < b.score )
				return -1;
			return 0;
		}
		
	}
}
