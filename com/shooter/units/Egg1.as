package com.shooter.units {
		import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class Egg1 extends UnitBase{
		
		private var flag:Boolean = true; 
	 public function Egg1():void{
		
		_sprite = new EGG_mc();
		//_sprite.scaleX = _sprite.scaleY = 4
		
		addChild(_sprite);
		_speed = 0;
		_attackDelay = 150;
		_healthMax = 100;
		_damage = 0;
		kind =  KIND_EGG1;
	}
		
	
	override public function init(X:int,Y:int):void{
		super.init(X,Y);
		
	}
	
	override public function update(delta:Number):void{
		//super.update(delta)
		
		if (_attackDelay--<= 0 && flag){
			// атака главного героя
			_sprite.gotoAndStop("BOOM");
			_sprite.addEventListener("BOOM",BOOM);
			flag = false;
		} 
	}
	
	
	private function BOOM(e:Event):void{
		_sprite.removeEventListener("BOOM",BOOM);
		
		
		var Enemy:Spider1;
		Enemy = _instance.cacheSpider1.get() as  Spider1;
		Enemy.init(x+10,y+10);
		Enemy = _instance.cacheSpider1.get() as  Spider1;
		Enemy.init(x-10,y-10);
		enemiesOnMap--;
			_instance.unitController.remove(this);
			_isFree = true;
			_game.changeTotalKill(++totalKill);
		makeCorpse();
		
	}
	
	override public function free():void{
		
		super.free();	
	}
	
	}	
}