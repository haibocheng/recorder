package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Microphone;
	
	import flash.external.ExternalInterface;
	
	import org.as3wavsound.WavSound;
	import org.bytearray.micrecorder.MicRecorder;
	import org.bytearray.micrecorder.encoder.WaveEncoder;
	import org.bytearray.micrecorder.events.RecordingEvent;

	[SWF(width="230", height="150", frameRate="31", backgroundColor="#FFFFFF")]
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
			// Setting up the external interface callbacks
			ExternalInterface.addCallback('startRecording', this.startRecording);
			ExternalInterface.addCallback('stopRecording', this.stopRecording);
			ExternalInterface.addCallback('play', this.play);
		}
		
		/**
		 * External interface function. 
		 * This can be called from the page level JavaScript to start a new recording session.
		 */
		private function startRecording():void
		{
			recorder.record();
		}
		
		/**
		 * External interface function. 
		 * This can be called from the page level JavaScript to stop the current recording session.
		 */
		private function stopRecording():void
		{
			recorder.stop();
		}
		
		/**
		 * External interface function. 
		 * This can be called from the page level JavaScript to listen the last recording.
		 */
		private function play():void
		{
			player = new WavSound(recorder.output);
			player.play();
		}
	}
}