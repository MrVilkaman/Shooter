	package com.shooter{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.utils.*;
	import com.shooter.units.*;
	import com.shooter.controllers.*;
	import com.shooter.obstacles.*;
	import com.shooter.bullet.*;
	import com.framework.Amath;
	import com.framework.SimpleCaсhe;
	
	import flash.net.URLRequest;
	
	
	
	public class World extends Sprite{
		public const MAP_SIZE_X:int = 1280;
		public const MAP_SIZE_Y:int = 960;
		
		
		private static var _instance:World;
		private static var _game:Game;
		public var mainHero:MainHero;
		public var Enemy:UnitBase;
		
		private var _deltaTime:Number;
		private var _lastTick :Number;
		private var _maxDeltaTime:Number = 0.4;
		
		public var bulletController:ObjectController;
		public var unitController:ObjectController;
		public var objectController:ObjectController;
		public var blocksController:StaticObjectController;
		
		public var cacheGunBullet:SimpleCaсhe;
		public var cacheZombie1:SimpleCaсhe;
		public var cacheSpider1:SimpleCaсhe;
		
		private var _waves:Array = [];
		private var _waveIndex:int = -1;
		private var _currentWave:UnitWave = null;
		
		
		public var _gameMap:Bitmap;
		public var _crossMap:Bitmap;
		public var dieMap:Bitmap= new Bitmap(); // трупы на ней будут
		public var decorMap:Bitmap = new Bitmap(); // ниже играков
		public var decorMap2:Bitmap = new Bitmap(); // Выше играков 
		
		public var bulletMass:Array = [];
		private var block:Block1;
		private var tree:Trees;
	
		private var ammoTimer:Timer = new Timer(25000);
		
		private var _isVictory:Boolean = false;
	
		var _pos:Point = new Point(); 
		public function World():void{
			if (_instance != null){
					throw("Error: Мир уже существует. Используйте World.getInstance();")}
			_instance = this;
			_game = Game.getInstance();
			trace("Мир создан");
			
			
			mainHero = new MainHero();
			
			var imageTextureMap:BitmapData = new Fon(0,0);  ;
			_gameMap = new Bitmap(imageTextureMap);
			var bmpData:BitmapData = new BitmapData(MAP_SIZE_X,MAP_SIZE_Y,true, 0x00000000);
			_crossMap = new Bitmap();
			_crossMap.bitmapData = bmpData;
			
			bmpData = new BitmapData(MAP_SIZE_X,MAP_SIZE_Y,true, 0x00000000);
			decorMap.bitmapData = bmpData;
			bmpData = new BitmapData(MAP_SIZE_X,MAP_SIZE_Y,true, 0x00000000);
			decorMap2.bitmapData = bmpData;
			
			bmpData = new BitmapData(MAP_SIZE_X,MAP_SIZE_Y,true, 0x00000000);
			dieMap.bitmapData = bmpData;
			
			
			addChild(decorMap);
			addChild(dieMap);
			addChild(decorMap2);
			addChild(_crossMap);
			addChildAt(_gameMap,0);
			setChildIndex(_crossMap,0);
			
			QWE();
			
			_crossMap.visible = false;
			// кеширование объектов

			cacheGunBullet = new SimpleCaсhe(GunBullet,10);
			cacheZombie1 = new SimpleCaсhe(Zombie1,10);
			cacheSpider1 = new SimpleCaсhe(Spider1,10);
			
			_lastTick = getTimer();
			
			bulletController = new ObjectController();
			unitController = new ObjectController();
			blocksController = new StaticObjectController();
			objectController = new ObjectController();
			
			
			//!!!!!!!!!!!!!!!!!!!!!!!!
			ammoTimer.addEventListener(TimerEvent.TIMER, ammoTimerListener);
			
			
			// тестовая карта для поиска пути
	
			/*
			
			block = new Block1();
			block.init(350,350);
			block = new Block1();
			block.init(310,350);
			block = new Block1();
			block.init(350,400);
			block = new Block1();
			block.init(270,350);
			*/
			createMap();
			
			addEventListener(Event.ENTER_FRAME, enterFrameListener);
			
		} 
		
		
		private function enterFrameListener(e:Event):void{
			// расчет delta времени
			_deltaTime = (getTimer()- _lastTick)/1000;
			_deltaTime = (_deltaTime > _maxDeltaTime)? _maxDeltaTime : _deltaTime;
			
			// обработка врагов находящихся в игровом мире
			
			if (mainHero.alive){
				mainHero.update(_deltaTime);
				bulletController.update(_deltaTime);
				objectController.update(_deltaTime);
				updateWaves(_deltaTime);			
				unitController.update(_deltaTime);			
				
			}
			
			
			_lastTick = getTimer();	

		}
		
		private function ammoTimerListener(event:TimerEvent):void {
			
			if (ObjectBase.medNum + ObjectBase.grenadeNum + ObjectBase.ammoNum   < ObjectBase.TOTAL_EQUIPMENT){	
				addAmmunition( mainHero.needAmmunition());
			}
		}
		
		
		private function createMap():void{
			
			
				for(var i:int = 0 ; i<20;i++){
						block = new Block1();
						_pos = findPos();
						block.init(_pos.x,_pos.y );
						block = null;
				}
					
				for(var i:int = 0 ; i<100;i++){
						tree = new Trees();
						_pos = findPos();
						tree.init(_pos.x,_pos.y);
				}
				
				
			_pos = findPos();
			mainHero.init(_pos.x,_pos.y);
			ammoTimer.start();
					
			var wave:UnitWave = new UnitWave();
			wave.startDelay = 5;
			wave.addEnemy(0, 15, 1);
			_waves.push(wave);
			
			wave = new UnitWave();
			wave.startDelay = 8;
			wave.addEnemy(UnitBase.KIND_ZOMBIE1, 15, .9);
			wave.addEnemy(UnitBase.KIND_SPIDER1, 10, .8);
			_waves.push(wave);
			
			wave = new UnitWave();
			wave.startDelay = 8;
			wave.addEnemy(UnitBase.KIND_SPIDER1, 15, 0.9);
			wave.addEnemy(UnitBase.KIND_ZOMBIE1, 20, 0.8);
			wave.addDelay(3);
			wave.addEnemy(UnitBase.KIND_ZOMBIE1, 5, 0.4);
			wave.addDelay(2);
			wave.addEnemy(UnitBase.KIND_SPIDER1, 5, 0.4);
			_waves.push(wave);
			
			var  wave = new UnitWave();
			wave.startDelay = 10;
			wave.addEnemy(UnitBase.KIND_BOSS1, 1, 0.4);
			_waves.push(wave);
			
			_waveIndex = 0;
			
			
			blocksController.clear();
			
		}
		
		
		
		private function updateWaves(delta:Number):void{
			if (_waveIndex != -1){
				if (_currentWave == null ){
					if ( UnitBase.enemiesOnMap < 3){
						_currentWave  = _waves[_waveIndex] as UnitWave;
						_currentWave.startWave();
						_game.changeWaveInfo(_waveIndex,_waves.length);
					}
				} else {
					_currentWave.update(delta);
					
					if (_currentWave.isFinished){
						
						_waveIndex = (_waveIndex+1  >= _waves.length) ? -1 : _waveIndex+1;
						 _currentWave = null;
					}
				}
			} else {
				if (!UnitBase.enemiesOnMap && !_isVictory ){
					_isVictory = true;
					_game.dispatchEvent(new Event(Game.GAME_WIN));
				}
			}
		} 
		
		private function findPos(mode:int = 0 ):Point{
			// режим 0 - повляется где угодно
			// другой на растоянии не менее mode от игрока
			var _pos:Point = new Point(); 
			if (mode){
				do{
					_pos.x = Amath.random(50,MAP_SIZE_X -50);
					_pos.y = Amath.random(50,MAP_SIZE_Y -50);
				}while(!CrossMapInfo.canBuild(_pos.x,_pos.y) && Amath.distance(_pos.x,_pos.y,mainHero.x,mainHero.y) > mode);
			} else {
				do{
					_pos.x = Amath.random(50,MAP_SIZE_X -50);
					_pos.y = Amath.random(50,MAP_SIZE_Y -50);
					
				}while(!CrossMapInfo.canBuild(_pos.x,_pos.y));
			}
			return _pos;
			
		}
		
		public function addAmmunition(kind:int = 0):void{
			trace(kind);
			var Med:Equipment = new Equipment(kind) ;
			var X:int;
			var Y:int;
			X = Math.random()*MAP_SIZE_X;
			Y = Math.random()*MAP_SIZE_Y;
			_pos = findPos(260);
			Med.init(_pos.x,_pos.y);
		}
		
		
		public function addEnemy(kind:int = 0):void{
			if (UnitBase.enemiesOnMap <UnitBase.ENEMIES_ON_MAP_MAX){
				switch (kind){
					case  UnitBase.KIND_SPIDER1: 
						Enemy = cacheSpider1.get() as  Spider1;
					break;
					case  UnitBase.KIND_ZOMBIE1:
						Enemy = cacheZombie1.get() as  Zombie1;
					break;
					case  UnitBase.KIND_BOSS1:
						Enemy = new BOSS1();
					break;
				}
				
				_pos = findPos()
					Enemy.init(_pos.x,_pos.y);
				
			}
		}
		
		public function visibleMap():void{
			_gameMap.visible = !_gameMap.visible;
			decorMap.visible = !decorMap.visible;
			decorMap2.visible = !decorMap2.visible;
			_crossMap.visible = !_crossMap.visible ;
			dieMap.visible = !dieMap.visible ;
		}

		public function QWE():void{
			
			for(var i:int =0 ; i<numChildren ;i++){
				trace(getChildAt(i).toString());
			
			}
			
		}

		
		
		public function restartGame	():void{
			bulletController.clear();
			unitController.clear();
			//blocksController.clear();
			//objectController.clear();
			
			mainHero.isShot = false;
			_game.changeTotalKill(UnitBase.totalKill = 0);
			_waveIndex = 0;
			_currentWave = null;
			
			mainHero.init();
		var bmpData:BitmapData = new BitmapData(MAP_SIZE_X,MAP_SIZE_Y,true, 0x00FFFFA0);
			dieMap.bitmapData = bmpData;
		}

		//Если мир еще не существует, то он автоматически будет создан, в ином случае вернется ссылка на уже существующий мир
		public static function getInstance():World{		
			
			return (_instance == null) ? new World() : _instance;
		
		}
	}
}