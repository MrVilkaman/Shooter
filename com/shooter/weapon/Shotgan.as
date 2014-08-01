package com.shooter.weapon {

	import com.shooter.bullet.GunBullet;
	import com.framework.Amath;

		
		public class Shotgan  extends WeaponBase{
		
		public function Shotgan():void{
			RELOADING_TIME = 45;
			ATTACK_INTERVAL = 20;
			MAX_AMMO = 8;
			totalAmmo = 32 - MAX_AMMO;
			ammo = MAX_AMMO;
			
		}
			
		override public function shoot():void{
			
		
			for(var i:int = 0 ; i<10;i++){
				bull = _world.cacheGunBullet.get() as GunBullet;
				if (_game.heroLeft || _game.heroDown || _game.heroUp ||  _game.heroRight){
					_angle = attackAngleWithMisfires(7.);
				} else {
					_angle = attackAngleWithMisfires(3.);
				}
				bull.init(_barrelMachinePos.x,_barrelMachinePos.y,_angle);
				
			}
		
		}	
		
	}	
}