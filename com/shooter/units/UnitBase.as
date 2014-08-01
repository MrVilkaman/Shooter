package com.shooter.units {
	import flash.display.* ;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.*;
	import com.shooter.World;
	import com.shooter.Game;
	import com.shooter.interfaces.IGameObject;
	import com.framework.Amath;
	import com.shooter.obstacles.CrossMapInfo;
	import com.shooter.units.*;
	
		public class UnitBase extends MovieClip implements IGameObject{
		public static const ENEMY_DEAD:String = "enemyDead";
		public static const ANIMATION_OVER:String = "animationOver";
			
		protected static var _instance:World = World.getInstance();
		protected static var _game:Game = Game.getInstance();
		
		public static var totalKill:int = 0 ;
		public static const ENEMIES_ON_MAP_MAX:int = 20;
		public static var enemiesOnMap:int = 0;
		
		public var kind:int = -1;
		public static const KIND_ZOMBIE1:int = 0; 
		public static const KIND_SPIDER1:int = 1;
		public static const KIND_BOSS1:int = 101;
		public static const KIND_EGG1:int = 1011;

		protected var _sprite:MovieClip;

		protected var _speed:Number = 80;
		protected var _speedX:Number;
		protected var _speedY:Number;
		protected var _target:Point = new Point();
		protected var _angel:Number;
		
		protected var startTimeScan:int = 5;
		protected var timeScan:int = 0;
		
		protected var _attackDelay:int = 0;
		protected var _attackInterval:int = 30;

		protected var _visionDistance:int = 600;
		protected var _attackDistance:int = 20;
		
		protected var _healthMax:int = 120;
		protected var _health:int;
		protected var _damage:Number = 50;
		protected var _pos:Object = new Object(); 

		protected var _speedNew:Object = new Object(); 
		protected var _isFree:Boolean = true;

		
		private var dist:int;
		var bmpData:BitmapData;
		var matrix:Matrix;
		
	public function UnitBase():void{

	}
	
	public function init(X:int,Y:int):void{
		 
		x = X;
		y = Y;
		_health = _healthMax;
		_isFree = false; // Юнит используется
		_sprite.gotoAndStop("Stay");
		_instance.unitController.add(this);
		_instance.addChildAt(this, 5);
		enemiesOnMap++;
		
	}
	
	public function update(delta:Number):void{
		_target.x = _instance.mainHero.x;
		_target.y = _instance.mainHero.y;

		// Список действий/управление анимацией
		dist = Amath.distance(_target.x,_target.y,x,y);
		if (dist < _attackDistance || dist > _visionDistance) {
			
				if ( dist >  _visionDistance || !_instance.mainHero.alive){
					if (_sprite.currentFrame != 1) {
						_sprite.gotoAndStop("Stay");
						_attackDelay = -1;
					}
				} else {
					if (_sprite.currentFrame != 3){ 
						_sprite.rotation = Amath.toDegrees(Amath.getAngle(x,y, _target.x,_target.y));
						_sprite.gotoAndStop("Attack");
					};
						_attackDelay--;
						if (_attackDelay<= 0){
							// атака главного героя
							_instance.mainHero.addDamage(Amath.random(_damage*.8,_damage*1.2));
							_attackDelay = _attackInterval;
						} 
					}
					return;
		} else {
			if ( _sprite.currentFrame != 2 && _sprite.currentFrame != 5 && _instance.mainHero.alive){
				_sprite.gotoAndStop("Move");
			}
		}
		//  движение, поиск пути
			_angel = Amath.getAngle(x,y, _target.x,_target.y)
		
			_speedX = _speed*Math.cos(Amath.toRadians(_sprite.rotation));
			_speedY = _speed*Math.sin(Amath.toRadians(_sprite.rotation));
			
			_pos.x = x + _speedX * delta;
			_pos.y = y + _speedY * delta;
			
			{
			if (!CrossMapInfo.canGo(_pos.x,_pos.y)){
				_pos = findWay(delta);
			}
			if (timeScan--){
				_sprite.rotation += Amath.dAngleDegree(Amath.toDegrees(_angel),_sprite.rotation)*.3;
				timeScan = startTimeScan;
			}
		
					
			x = _pos.x;
			y = _pos.y;

		}
	}
	
	
	// поиск пути в обход препятствий
	public function findWay(delta:Number):Object{
		var _posNew:Object = new Object(); 
		for(var i:int = 10; i < 360; i += 15) {
			for(var j:int = -1; j <= 1; j += 2) {
				var _ang:Number = Amath.toRadians(_sprite.rotation + i*j);
				_posNew.x = x + _speed*Math.cos(_ang) * delta;
				_posNew.y = y + _speed*Math.sin(_ang) * delta;
				
				if (CrossMapInfo.canGo(_posNew.x,_posNew.y)){
						
					_angel =  _ang;
					return _posNew;
				}
			}
		};
		return _posNew;
	}
	
	public function addDamage(damage:int):void{
		trace(damage);
		_health -=damage;
		if (_health <= 0){
			death();
		}
	}
	private function death():void{
		_sprite.addEventListener(ENEMY_DEAD, enemyDeadListener);
		_sprite.gotoAndStop("Die");
		free();
		_instance.addChild(this);
	}
	
	
	
	/*
		// в последнем кадре для анимации смерти
		
	stop();
	parent.dispatchEvent(new Event("enemyDead"));
	
	*/

	private function enemyDeadListener(e:Event):void{
		_sprite.removeEventListener(ENEMY_DEAD, enemyDeadListener);
		 makeCorpse();
		 
		
	}
	
	protected function makeCorpse():void{
		bmpData = _instance.dieMap.bitmapData;
		matrix = new Matrix();
		matrix.rotate(Amath.toRadians(_sprite.rotation));
		matrix.tx = x;
		matrix.ty = y;
		bmpData.draw( _sprite,matrix);
		_instance.dieMap.bitmapData = bmpData;
		_instance.removeChild(this);
		_sprite.gotoAndStop("Stay");

	}
	
		
	
	public function free():void{
		if (!_isFree){
			
			enemiesOnMap--;
			_instance.unitController.remove(this);
			//_instance.removeChild(this);
			_isFree = true;
			_game.changeTotalKill(++totalKill);
			_instance.removeChild(this);
			
		}
	}
	
	}	
}