package com.shooter.units {
	
	
	public class Zombie1 extends UnitBase{
		
	 public function Zombie1():void{
		
		_sprite = new Zombie1_mc();
		addChild(_sprite);
		_speed = 80;
		_attackInterval = 30;
		_healthMax = 100;
		_damage = 50;
		
		kind = KIND_ZOMBIE1;
		
	}
		
	
	override public function init(X:int,Y:int):void{
		super.init(X,Y);
		 
	}
	
	override public function update(delta:Number):void{
		super.update(delta)
		
	}
	
	override public function free():void{
		// Вовращаем юнита в кэш
			_instance.cacheZombie1.set(this);
		super.free();	
	}
	
	}	
}