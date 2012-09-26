package crm.gobelins.darkunicorn.signals
{
	import crm.gobelins.darkunicorn.services.FbUserVo;
	
	import org.osflash.signals.Signal;
	
	public class GotoEndSignal extends Signal
	{
		public function GotoEndSignal()
		{
			super(FbUserVo);
		}
	}
}