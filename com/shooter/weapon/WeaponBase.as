package com.shooter.weapon {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import com.shooter.World;
	import com.shooter.Game;
	import com.framework.Amath;
	import com.shooter.bullet.GunBullet;
	
		public class WeaponBase extends MovieClip{
		
		public var RELOADING_TIME:int;
		public var ATTACK_INTERVAL:int;
		public var MAX_AMMO:int;
		
		public var totalAmmo:int;
		public var ammo:int;
		
		protected var  _barrelMachinePos:Point = new Point();
		protected var _barrelMachineAngle:Number = 0;
		
		protected var bull:GunBullet = null;
		
		protected static var _world:World = World.getInstance();
		protected static var _game:Game = Game.getInstance();
		protected var speed:int = 500;
		
		private var _damage:int = 0;
		protected var _angle:Number;
		private var _rot:int; 
		
	public function WeaponBase ():void{
	
	}
	public function shoot():void{
	
	}
	
	protected function attackAngleWithMisfires(angle:Number):Number{ 
		_rot = _world.mainHero.rotation;
		_barrelMachinePos.x = _world.mainHero.x-15*Math.sin(Amath.toRadians(_rot));
		_barrelMachinePos.y = _world.mainHero.y+13*Math.cos(Amath.toRadians(_rot));
		_barrelMachineAngle = Amath.getAngleDeg(_barrelMachinePos.x,_barrelMachinePos.y,_world.mouseX,_world.mouseY);
		return Amath.toRadians(_barrelMachineAngle + Amath.random(-angle,angle))
	}
	
	}	
}