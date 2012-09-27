package crm.gobelins.darkunicorn.signals
{
	import crm.gobelins.darkunicorn.vo.ChangeViewVo;
	
	import org.osflash.signals.Signal;
	
	public class ChangeViewSignal extends Signal
	{
		public function ChangeViewSignal()
		{
			super(ChangeViewVo);
		}
	}
}