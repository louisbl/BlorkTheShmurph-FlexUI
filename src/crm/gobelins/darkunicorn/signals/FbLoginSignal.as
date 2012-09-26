package crm.gobelins.darkunicorn.signals
{
	import crm.gobelins.darkunicorn.services.FbLoginVo;
	
	import org.osflash.signals.Signal;
	
	public class FbLoginSignal extends Signal
	{
		public function FbLoginSignal() : void {
			super(FbLoginVo);	
		}
	}
}