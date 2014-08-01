package com.shooter.weapon {

		import com.shooter.bullet.GunBullet;
	import com.framework.Amath;

	
		public class AK_47  extends WeaponBase{
		
			
		public function AK_47 ():void{
			RELOADING_TIME = 45;
			ATTACK_INTERVAL = 6;
			MAX_AMMO = 30;
			totalAmmo = 90 - MAX_AMMO;
			ammo = MAX_AMMO;
			
		}
		
		override public function shoot():void{
			bull = _world.cacheGunBullet.get() as GunBullet;

			if (_game.heroLeft || _game.heroDown || _game.heroUp ||  _game.heroRight){
				_angle = attackAngleWithMisfires(6);
			} else {
				_angle = attackAngleWithMisfires(2);
			}
			bull.init(_barrelMachinePos.x,_barrelMachinePos.y,_angle,0,0,2);
		
		
		}	
		
	}	
}