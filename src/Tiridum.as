package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Microphone;
	
	import org.as3wavsound.WavSound;
	import org.bytearray.micrecorder.MicRecorder;
	import org.bytearray.micrecorder.encoder.WaveEncoder;
	import org.bytearray.micrecorder.events.RecordingEvent;

	public class Tiridum extends Sprite
	{
		private var recorder:MicRecorder = new MicRecorder(new WaveEncoder());
		private var recording:Boolean;
		private var player:WavSound;
		
		public function Tiridum()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			recorder.addEventListener(Event.COMPLETE, onRecordComplete);
			stage.addEventListener(MouseEvent.CLICK, onClick);	
		}
		
		private function onRecordComplete(event:Event):void
		{
			player = new WavSound(recorder.output);
			player.play();
		}
		
		private function onClick(event:MouseEvent):void
		{
			recording ? recorder.stop() : recorder.record();
			
			recording = !recording;
		}
	}
}