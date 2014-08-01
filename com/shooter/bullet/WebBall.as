package com.shooter.bullet {
		import flash.geom.Point;
	import com.shooter.units.*;
	import com.framework.Amath;
	import com.shooter.obstacles.CrossMapInfo;
	
	public class WebBall extends BulletBase{
		
	private var _target:Point = new Point();

			
		public function WebBall():void{
			_sprite = new WebBall_mc();
			addChild(_sprite);
		}
		
		override public function init(ax:int, ay:int,  angel:Number,targetX:int = 0, targetY:int = 0,kind:int = 1):void{
			_damage = 30
			speed = 420;
			super.init(ax, ay, angel);
		}
		
		override public function update(delta:Number):void{
		_target.x = _instance.mainHero.x;
		_target.y = _instance.mainHero.y;
			
			x += _speed.x * delta;
			y += _speed.y * delta;
			
			var _dAngel:Number = Amath.dAngleDegree(rotation, Amath.getAngleDeg(x,y,_target.x,_target.y))
			if (Math.abs(_dAngel) < 90){
				if (_dAngel<0 ){
					rotation +=1;
				} else {
					rotation -=1;
				}
			}
			_angel = Amath.toRadians(rotation);
			_speed.x = speed*Math.cos(_angel);
			_speed.y = speed*Math.sin(_angel);
			
			if (!CrossMapInfo.canShoot(x,y)){
				free();
				timeLife = startTimeLife;
			}
			
			if (Amath.distance(x,y,_target.x,_target.y) < 20){
				_instance.mainHero.applyEffect();
				var _localDamage:int = Amath.random(_damage*.8,_damage*1.2); 
				_instance.mainHero.addDamage(_localDamage);
				free();
			}
			
			
			timeLife--;
				if (timeLife <= 0){
					free();
					timeLife = startTimeLife;
				}
			super.update(delta);
		}
		/*
		private function applyEffect():void{
			
		
		}*/
		
		override public function free():void{
			//_instance.cacheGunBullet.set(this);
			removeChild(_sprite);
			super.free();	
		}	
	}
}