package crm.gobelins.darkunicorn.signals
{
	import crm.gobelins.darkunicorn.models.ChangeViewVo;
	
	import org.osflash.signals.Signal;
	
	public class ChangeViewSignal extends Signal
	{
		public function ChangeViewSignal(...parameters)
		{
			super(ChangeViewVo);
		}
	}
}