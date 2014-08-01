package com.shooter.obstacles{
	import com.shooter.obstacles.BlockBase;
	import flash.display.*;
	import com.framework.Amath;
		
	public class Equipment extends ObjectBase{
		

		private const MEDICATION:int = 120;
		private const GRENADE_CONTER:int = 2;
		private const AMMO_CONTER:int = 120;
		private const AMMO_CONTER_SHOTGUN:int = 32;
		
		
		
		private var _liveTime:int = 0;
		public function Equipment(kind:int = 0):void{
				
			_sprite = new Equipment_mc();
			addChild(_sprite);
			if (!kind){
				_sprite.gotoAndStop( Amath.random(1,_sprite.totalFrames));
			} else {
				_sprite.gotoAndStop(kind);
			}
		}
		
		override public function init(ax:int, ay:int):void{
			_liveTime = 30*60;
			switch (_sprite.currentFrame){
				case 1:
					medNum++;
				break;
				case 2:
					grenadeNum++;
				break;
				case 3:
				case 4:
					ammoNum++;
				break;
			}
			
			
			super.init(ax,ay);
		}

		override public function update(delta:Number):void{
			
			if( !_liveTime--){
				free();
			}
			super.update(delta);
		}
		
		
		override protected function applyEffect():void{
			switch (_sprite.currentFrame){
				case 1:
					_instance.mainHero.addDamage(-MEDICATION);
				break;
				case 2:
					_instance.mainHero.supplementAmmunition(2,GRENADE_CONTER);
				break;
				case 3:
					_instance.mainHero.supplementAmmunition(3,AMMO_CONTER_SHOTGUN);
				break;
				case 4:
					_instance.mainHero.supplementAmmunition(4,AMMO_CONTER);
				break;
			}
		
		}
		
		override public function free():void{
			switch (_sprite.currentFrame){
				case 1:
					medNum--;
				break;
				case 2:
					grenadeNum--;
				break;
				case 3:
				case 4:
					ammoNum--;
				break;
			}
			super.free();
		}
		
	}
}