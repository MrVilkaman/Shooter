package com.shooter{
	
	//import com.shooter.Main;
	import flash.display.*;
	import flash.events.*;
	import com.framework.Key;
	import com.shooter.gui.CastomMousePointer;
	import flash.text.*;
		//import com.shooter.obstacles.CrossMapInfo;
	
	
	public class Game extends Sprite{
	
	private static var _instance:Game;
	private static var _world:World;
	
		public static const GAME_OVER:String = "gameOver"; 
		public static const GAME_WIN:String = "gameWin"; 
	
	
		public var heroUp:Boolean = false;
		public var heroDown:Boolean = false;
		public var heroLeft:Boolean = false;
		public var heroRight:Boolean = false;	
		
		private var textReset:MovieClip;
		private var textGameOver:MovieClip;
		
		private var _medPic:Sprite = new Med_Pic();
		private var _ammoPic:MovieClip = new Ammo_Pic();
		private var _skullPic:Sprite = new skull_Pic();
		private var _grenadePic:Sprite = new Grenade_Pic();
		private var _weaponPic:MovieClip = new Weapon_Pic();
		private var _fon1:Sprite = new Sprite();
		private var _fon2:Sprite = new Sprite();
		private var _fon3:Sprite = new Sprite();
		private var _fon4:Sprite = new Sprite();
	
		private var _HeroHealth:TextField = new TextField();
		private var _killCounter:TextField = new TextField();
		private var _gameName:TextField = new TextField();
		private var _ammoInfo:TextField = new TextField();
		private var _grenadeInfo:TextField = new TextField();
		private var _waveInfo:TextField = new TextField();
		
		// Текстовые поля для уведомленийs
		
		//private var _Info:TextField = new TextField();
		
		private var _isGameOver:Boolean = false;
		
		
		var myFormat:TextFormat = new TextFormat("Arial", 20, 0x000000, true);
		public function Game():void{
		
			if (_instance != null){
				throw("Error: Мир уже существует. Используйте Game.getInstance();")}
			_instance = this;
			
			if (stage){
			init()
		} else {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
			
		}
			
		public function init(e:Event = null):void{
			
			_world = new World();
			addChild(_world);
			addEventListener(GAME_OVER, gameOverListener);
			addEventListener(GAME_WIN, gameWinListener);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpListener);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpListener);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
		 	_fon1.graphics.beginFill(0Xa8a8a8,0.5);
			_fon1.graphics.lineTo(80,0);
			_fon1.graphics.lineTo(80,35);
			_fon1.graphics.lineTo(0,35);
			_fon1.graphics.lineTo(0,0);
			_fon1.graphics.endFill();
			_fon1.y = Main.SCR_H - 35;	
			
			_fon2.graphics.beginFill(0Xa8a8a8,0.5);
			_fon2.graphics.lineTo(100,0);
			_fon2.graphics.lineTo(100,50);
			_fon2.graphics.lineTo(0,50);
			_fon2.graphics.lineTo(0,0);
			_fon2.graphics.endFill();
			_fon2.x = Main.SCR_W - 100;
			_fon2.y = Main.SCR_H - 50;	
			
			_fon3.graphics.beginFill(0Xa8a8a8,0.5);
			_fon3.graphics.lineTo(70,0);
			_fon3.graphics.lineTo(70,70);
			_fon3.graphics.lineTo(0,70);
			_fon3.graphics.lineTo(0,0);
			_fon3.graphics.endFill();
			_fon3.x = Main.SCR_W - 70;
			
			_fon4.graphics.beginFill(0Xa8a8a8,0.5);
			_fon4.graphics.lineTo(120, 0);
			_fon4.graphics.lineTo(120, 55);
			_fon4.graphics.lineTo(0,55);
			_fon4.graphics.lineTo(0,0);
			_fon4.graphics.endFill();
			
		
			_HeroHealth.defaultTextFormat = myFormat;	
			
			_HeroHealth.x = 25;
			_HeroHealth.y = Main.SCR_H - 30;	
			//_ammoInfo.text = "Здоровье "
			_ammoInfo.x = Main.SCR_W - 60;
			_ammoInfo.y = Main.SCR_H - 30;
			
			_ammoPic.x = Main.SCR_W - 80
			_ammoPic.y = Main.SCR_H - 17;
			
			_medPic.x = 15;
			_medPic.y = Main.SCR_H - 15;	
			
			_grenadePic.x = Main.SCR_W - 80;
			_grenadePic.y = Main.SCR_H - 37;
			
			_grenadeInfo.x = Main.SCR_W - 60;
			_grenadeInfo.y = Main.SCR_H - 50;
			
			_skullPic.x = Main.SCR_W - 50;
			_skullPic.y = 20;
			
			_killCounter.x = Main.SCR_W - 30;
			_killCounter.y = 10;
			_killCounter.defaultTextFormat = myFormat;	
			_killCounter.text = "0";
			
			_waveInfo.x = Main.SCR_W - 35;
			_waveInfo.y = 40;
						
			addChild(_fon1);
			addChild(_fon2);
			addChild(_fon3);
			addChild(_fon4);
			addChild(_ammoInfo);
			addChild(_grenadeInfo);
			addChild(_HeroHealth);
			addChild(_killCounter);
			addChild(_skullPic);
			addChild(_medPic);
			addChild(_ammoPic);
			addChild(_grenadePic);
			addChild(_waveInfo);
			addChild(_weaponPic);
			
			
			var pointer:CastomMousePointer = new CastomMousePointer(); 
			addChild(pointer);
		}
		
		public  function changeHealth(health:int):void{
			_HeroHealth.defaultTextFormat = myFormat;	
			_HeroHealth.text = health.toString();
		}
		
		public  function changeTotalKill(kill:int):void{
			_killCounter.defaultTextFormat = myFormat;	
			_killCounter.text = kill.toString();
		}

		public function changeWaveInfo(wave:int,waveMax:int):void{
			_waveInfo.defaultTextFormat = myFormat;	
			var buff:int = wave+1;
			_waveInfo.text = buff.toString() +"/" + waveMax.toString();
		}
		
		public  function changeAmmoInfo(ammo:int,ammoMax:int):void{
			_ammoInfo.defaultTextFormat = myFormat;	
			_ammoInfo.text = ammo.toString() +"/" + ammoMax.toString();
		}
		
		public  function changeWeapon(kind:int):void{
			_weaponPic.gotoAndStop(kind);
			_ammoPic.gotoAndStop(kind);
		}
		
		
		public  function changeGrenadeInfo(ammo:int):void{
			_grenadeInfo.defaultTextFormat = myFormat;	
			_grenadeInfo.text = ammo.toString();
		}
		
		
		private function mouseUpListener(e:MouseEvent):void{
			_world.mainHero.isShot = false;
			
		}
		private function mouseDownListener(e:MouseEvent):void{
			_world.mainHero.isShot = true;
			
		}
		

		
		private function gameWinListener(e:Event):void{
			
			textGameOver = new Text_WIN();
			
			textReset = new Text_Reset_TXT();
			textGameOver.x = textReset.x = Main.SCR_WDIV;
			textGameOver.y = Main.SCR_HDIV;
			textReset.y = Main.SCR_H - 20;
			_world.mainHero.isShot = false;
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpListener);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
			_isGameOver = true;
			addChild(textReset);
			addChild(textGameOver);
			
		}
		
		
		private function gameOverListener(e:Event):void{
			
			textGameOver = new Text_GameOver();
			
			textReset = new Text_Reset_TXT();
			textGameOver.x = textReset.x = Main.SCR_WDIV;
			textGameOver.y = Main.SCR_HDIV;
			textReset.y = Main.SCR_H - 20;
			_world.mainHero.isShot = false;
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpListener);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
			_isGameOver = true;
			addChild(textReset);
			addChild(textGameOver);
			
		}
		
		
		private function keyDownListener(e:KeyboardEvent):void{
		switch (e.keyCode ){
			
			case Key.A:
			case( Key.LEFT):
				heroLeft = true;
			break;
			case Key.D:
			case( Key.RIGHT):
				heroRight = true;
			break;
			case Key.W:
			case( Key.UP):
				heroUp = true;
			break;
			case Key.S:
			case( Key.DOWN):
				heroDown = true;		
			break;
			case( Key.R):
				_world.mainHero.reloadWeapon();
			break;
			case( Key.F):
				_world.mainHero.throwGrenade();
			break;
			case( Key.SPACE):
			
				if (!_isGameOver){
					_world.addEnemy(0)
				} else {
					_isGameOver = false;							
					removeChild(textReset);
					removeChild(textGameOver);
					textReset = null;
					textGameOver = null;
					stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpListener);
					stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
					_world.restartGame();
				}
			break;
			case( Key.Z):
				_world.visibleMap();
			break;
			case( Key.X):
				_world.QWE();
			break;
			case( Key.DIGIT_1):
				_world.mainHero.changeWeapon(1);
			break;
			case( Key.DIGIT_2):
				_world.mainHero.changeWeapon(2);
			break;
			
			
		}
						
			
		}
		
		private  function	keyUpListener(e:KeyboardEvent):void{
			
			switch (e.keyCode){
				case Key.A:
				case( Key.LEFT):
					heroLeft = false;
				break;
				case Key.D:
				case( Key.RIGHT):
					heroRight = false;
				break;
				case Key.W:
				case( Key.UP):
					heroUp = false;
				break;
				case Key.S:
				case( Key.DOWN):
					heroDown = false;		
				break;
				
			}
			
		}
		public static function getInstance():Game{		
			
			return (_instance == null) ? new Game() : _instance;
		
		}
				
	}
}