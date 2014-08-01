package com.shooter.units {
	import com.shooter.gui.*;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.framework.Amath;
	import com.shooter.bullet.WebBall;
	
	public class BOSS1 extends UnitBase{
		
	private var _healthBar:HealthBar;
	 private var ovipositInt:int = 180;
	 private var oviposit:int = ovipositInt;
	 
	 
	 public function BOSS1():void{
		
		_sprite = new BOSS1_mc();
		//_sprite.scaleX = _sprite.scaleY = 4
		
		addChild(_sprite);
		_attackDistance = 60;
		_speed = 105;
		_attackInterval = 50;
		_healthMax = 5000;
		_damage = 150;
		kind =  KIND_BOSS1;
		
		if (_healthBar == null) {
		_healthBar = new UnitHealthBar_mc();
		_healthBar.y = -50;
			addChild(_healthBar);
		}
		_healthBar.reset(_healthMax);
	}
		
	
	override public function init(X:int,Y:int):void{
		super.init(X,Y);
		
	}
	
	override public function update(delta:Number):void{
		super.update(delta)
				
		if (oviposit--<0){
			if (Amath.random(0,1)){
				var EGG1Create:Egg1 = new Egg1();
				EGG1Create.init(x,y);
				EGG1Create = null;
			} else {
				_sprite.gotoAndStop("Web");
				_sprite.addEventListener(ANIMATION_OVER, animationOverListener);
				var bull:WebBall = new WebBall(); 
				bull.init(x,y,Amath.toRadians(_sprite.rotation));
				bull = null;
			}
		oviposit = ovipositInt;
		}
		
		
	}
	
	private function animationOverListener(e:Event):void{
		_sprite.removeEventListener(ANIMATION_OVER, animationOverListener);
		_sprite.gotoAndStop("Move");
	
	}
	
	
	
	override public function addDamage(damage:int):void{
		super.addDamage(damage);
		_healthBar.update(_health);
		
	}
	
	override public function free():void{
		super.free();	
		removeChild(_healthBar);
	}
	
	}	
}