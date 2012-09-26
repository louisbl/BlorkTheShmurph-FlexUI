package crm.gobelins.darkunicorn.signals
{
	import org.osflash.signals.Signal;
	
	public class ErrorSignal extends Signal
	{
		public function ErrorSignal()
		{
			super(String);
		}
	}
}