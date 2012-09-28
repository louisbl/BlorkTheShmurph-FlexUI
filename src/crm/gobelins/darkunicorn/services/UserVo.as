package crm.gobelins.darkunicorn.services
{
	[Bindable]
	public class UserVo
	{
		public var user_uid : String;
		public var user_name : String;
		public var user_picture : String;
		public var score : int;
		
		public function UserVo() 
		{
			score = 0;
			user_picture = "assets/default_picture.png";
		}
	}
}