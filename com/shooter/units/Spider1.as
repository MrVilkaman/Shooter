package com.shooter.units {
	
	
	public class Spider1 extends UnitBase{
		
	 public function Spider1():void{
		
		_sprite = new Spider1_mc();
		addChild(_sprite);
		_speed = 110;
		_attackInterval = 45;
		_healthMax = 210;
		_damage = 75;
		kind =  KIND_SPIDER1;
		
	}
		
	
	override public function init(X:int,Y:int):void{
		super.init(X,Y);
		
	}
	
	override public function update(delta:Number):void{
		super.update(delta)
		
	}
	
	override public function free():void{
		_instance.cacheSpider1.set(this);
		super.free();	
	}
	
	}	
}