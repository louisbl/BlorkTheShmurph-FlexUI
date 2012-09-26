package crm.gobelins.darkunicorn.signals
{
	import crm.gobelins.darkunicorn.services.FbUserVo;
	
	import org.osflash.signals.Signal;
	
	public class FbLoggedInSignal extends Signal
	{
		public function FbLoggedInSignal()
		{
			super(FbUserVo);
		}
	}
}