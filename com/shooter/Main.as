package com.shooter{

	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.*;
	
	import com.framework.SWFProfiler;

	public class Main extends MovieClip	{
		
		public static const APP_VERSION:String = "Shooter 13.01.13";
		
		//размеры документа  
		public static const SCR_W:int = 640;
		public static const SCR_H:int = 480;
		
		// середина документа
		public static const SCR_WDIV:int = 320;
		public static const SCR_HDIV:int = 240;
		
		
		private var _game:Game;

	private var _gameName:Bitmap;
		//private var _editor:Editor;
	var bmpData:BitmapData ;
	var bmpData2:BitmapData ;
	var _crossMap:Bitmap;


	
	private var _btnGame:SimpleButton;
	private var _btnHowToPlay:SimpleButton;
	private var _btnBack:SimpleButton;
		
		
		public function Main():void{
		
		trace(APP_VERSION);
		if (stage){
			init();
		} else {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		}
		
		public function init(event:Event = null):void{
			// подключаем Pfofiler
			SWFProfiler.init(stage, this);
			
			 bmpData2 = new GameName_Pic(0,0);
			 _gameName = new Bitmap( bmpData2);
			
			//_gameName.width = 200;
			//_gameName.height = 200;
			_gameName.x = SCR_WDIV -_gameName.width/2;
			_gameName.y = 80;
			
			addChild(_gameName);
			
			// кнопка "Game";
			_btnGame = new Game_btn();
			_btnGame.x = SCR_WDIV  ;
			_btnGame.y = SCR_HDIV - _btnGame.height/2;
			_btnGame.addEventListener(MouseEvent.CLICK, gameClickListener);
			addChild(_btnGame);
			
			// кнопка "Editor";
			_btnHowToPlay = new HowToPlay_btn();
			_btnHowToPlay.x = SCR_WDIV  ;
			_btnHowToPlay.y = SCR_HDIV +_btnGame.height/2 ;
			_btnHowToPlay.addEventListener(MouseEvent.CLICK, howToPlayClickListener);
			addChild(_btnHowToPlay);
		
		}
		
		
		
		private function gameClickListener(e:Event):void{
			_game = new Game();
			addChild(_game);
				
			free();
		}
		
		private function howToPlayClickListener(e:Event):void{
			
			/*var QQ:MovieClip = new Text_WIN();  
			QQ.x = SCR_WDIV;
			QQ.y = SCR_HDIV;
			
			addChild(QQ);
			free();
			*/
			 bmpData = new HowToPlay(0,0);
			 _crossMap = new Bitmap(bmpData);
			addChild(_crossMap);
			
			_btnBack = new Back_btn(); 
			_btnBack.x = SCR_WDIV;
			_btnBack.y = SCR_H - 40; 
			_btnBack.addEventListener(MouseEvent.CLICK, backClickListener);
			addChild(_btnBack);
		}
		private function backClickListener(e:Event):void{
			_btnBack.removeEventListener(MouseEvent.CLICK, backClickListener);
			removeChild(_crossMap);
			removeChild(_btnBack);
			_btnBack = null
		}
		
		
		
		private function free():void{
			removeChild(_btnGame);
			removeChild(_btnHowToPlay);
			removeChild(_gameName);
			
			_crossMap = null;
			_gameName = null;
			_btnGame.removeEventListener(MouseEvent.CLICK, gameClickListener);
			_btnGame = null;
			_btnHowToPlay.removeEventListener(MouseEvent.CLICK, howToPlayClickListener);
			_btnHowToPlay = null;
		}
	}
}