package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.text.Font;
	import flash.text.FontStyle;
	import flash.text.TextField;

	/**
	 * ...
	 * @author Miguel Murça
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		
		private var cam:Camera;
		private var video:Video;
		private var bd:BitmapData;

		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			cam = Camera.getCamera();
			cam.setMode(stage.stageWidth, stage.stageHeight, 30);
			cam.setQuality(0, 100);
			video = new Video(stage.stageWidth, stage.stageHeight);
			video.attachCamera(cam);
			video.scaleX = -1;
			video.x += stage.stageWidth;
			
			addChild(video);
			
			stage.addEventListener(MouseEvent.CLICK, click);
		}
		
		private function click(e:Event = null):void
		{
			var dark:Number = 0;
			var light:Number = 0;
			bd = new BitmapData(stage.stageWidth, stage.stageHeight);
			bd.draw(stage);
			
			for (var y:Number = 1; y < stage.stageHeight; y++)
			{
				for (var x:Number = 1; x < stage.stageWidth; x++)
				{
					var pxColor:uint = bd.getPixel(x, y); //Note-se que eu tenho 0 ideia do que aqui vai
					var red:int = (pxColor >> 16 & 0xff);
					var green:int = (pxColor>> 8 & 0xff);
					var blue:int = (pxColor & 0xff);
					
					if (0.2126*red + 0.7152*green + 0.0722*blue<70)
					{
						dark++;
					}else {
						light++;
					}
				}
			}
			trace(dark);
			trace(light);
			
			if (dark > light)
			{
				write("dark",0xffffff);
			}else {
				write("light",0x000000);
			}
		}
		
		private function write(text:String,color:uint):void
		{
			var txt:TextField = new TextField
			txt.textColor = color;
			txt.text = text;
			addChild(txt);
		}

	}

}