package crm.gobelins.darkunicorn.signals
{
	import crm.gobelins.darkunicorn.services.UserVo;
	
	import org.osflash.signals.Signal;
	
	public class GotoEndSignal extends Signal
	{
		public function GotoEndSignal()
		{
			super(UserVo);
		}
	}
}