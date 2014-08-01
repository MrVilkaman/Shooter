package com.shooter.bullet {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import com.shooter.World;
	import com.shooter.interfaces.IGameObject;
	//import com.shooter.units.*;
	import com.framework.Amath;

	
		public class BulletBase extends MovieClip implements IGameObject{
		protected var _damage:Number = 12; //25ss
		
		
		protected static var _instance:World = World.getInstance();
		protected var _sprite:MovieClip;
		protected var speed:int = 500;
		protected var _speed:Point = new Point();
		protected var _angel:Number;
		
		protected var timeLife:int;
		protected var startTimeLife:int;
		
		protected var _isFree:Boolean = true;
		
		
	public function BulletBase():void{

		
	}
	
	public function init(ax:int, ay:int,  angel:Number,targetX:int = 0, targetY:int = 0,kind:int = 1):void{
		if (_isFree ){
			_isFree = false;
			_sprite.gotoAndStop(kind);
			
			x = ax;
			y = ay;
			rotation = Amath.toDegrees(angel);
			_speed.x = speed*Math.cos(angel);
			_speed.y = speed*Math.sin(angel);
			
			
			
			startTimeLife  = 640/speed*45;
			timeLife = startTimeLife;
			_instance.bulletController.add(this);
			_instance.addChild(this);
		}
		
	}
	
	
	
	public function update(delta:Number):void{
		
		
	}
	
	public function free():void{
		
		if (!_isFree) {
		_instance.bulletController.remove(this);
		_instance.removeChild(this);
		_isFree = true;
		}
	}
	
	}	
}