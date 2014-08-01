package com.shooter.bullet {
	
	import com.shooter.units.*;
	import com.framework.Amath;
	import com.shooter.obstacles.CrossMapInfo;
	
	public class GunBullet extends BulletBase{
		
			
		public function GunBullet():void{
			_sprite = new GunBullet_mc();
			_sprite.gotoAndStop(1);
			addChild(_sprite);
		}
		
		override public function init(ax:int, ay:int,  angel:Number,targetX:int = 0, targetY:int = 0,kind:int = 1):void{
			
			switch (kind) {
				case 1:
					_damage = 12; 
				break;
				case 2:
					_damage = 27;
				break;
			}
			
			super.init(ax, ay, angel,0,0,kind);		
		}

		override public function update(delta:Number):void{
			
			x += _speed.x * delta;
			y += _speed.y * delta;
			
			var enemies:Array = _instance.unitController.objects;
			
			var n:int = enemies.length-1;
			var ememy:UnitBase;
			
			for (var i:int = n;i>=0 ;i--){
				ememy = enemies[i];
				if (Amath.distance(x,y,ememy.x,ememy.y) < ememy.width * .25){
					var _localDamage:int = Amath.random(_damage*.8,_damage*1.2); 
					ememy.addDamage(_localDamage); // Наносим урон врагу
					free(); // Удаляем пулю
					break;
				}
				
			}
			if (!CrossMapInfo.canShoot(x,y)){
				free();
				timeLife = startTimeLife;
			}
			timeLife--;
				if (timeLife <= 0){
					free();
					timeLife = startTimeLife;
				}
			super.update(delta);
		}
		
		override public function free():void{
			_instance.cacheGunBullet.set(this);
			super.free();	
		}	
	}
}