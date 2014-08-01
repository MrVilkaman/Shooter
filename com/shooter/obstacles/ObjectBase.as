package com.shooter.obstacles {
	import flash.display.*;
	import com.shooter.World;
	import flash.geom.*;
	import com.framework.Amath;
	import com.shooter.interfaces.IGameObject;
	
		public class ObjectBase extends Sprite implements IGameObject{
		// количество амуниции в игре
		public static const TOTAL_EQUIPMENT:int = 3;
		public  const MED_NUM_MAX:int = 2;
		public static  var medNum:int = 0;
		public  const  GRENADE_NUM_MAX:int = 2;
		public static  var grenadeNum:int = 0;
		public static  var ammoNum:int = 0;
	

		
		protected static var _instance:World = World.getInstance();
		protected var _sprite:MovieClip;
		protected var _angel:Number;
		protected var kind:int;
		protected var _target:Point = new Point();
		
		private const _interval:int = 5;
		private var _delay:int = _interval;
		
		private var dist:int;
		
	public function ObjectBase  ( ):void{
	
	}
	
	public function init(ax:int, ay:int):void{
		x = ax;
		y = ay;
		
		_instance.objectController.add(this);
		_instance.addChild(this);
	}
	
	public function update(delta:Number):void{
		
		if(!_delay--){
		_target.x = _instance.mainHero.x;
		_target.y = _instance.mainHero.y;
		
		dist = Amath.distance(_target.x,_target.y,x,y);
		if(dist < 20){
			free();
			applyEffect();
		}
			_delay = _interval;
		} 
	
	}
	
	
	protected function applyEffect():void{
	
	}
	
	public function free():void{
		
		_instance.objectController.remove(this);
		_instance.removeChild(this);
	
	}

		
	}	
}