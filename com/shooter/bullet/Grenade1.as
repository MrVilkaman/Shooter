package com.shooter.bullet {
	import com.shooter.units.*;
	import flash.geom.Point;
	import com.framework.Amath;
	import com.shooter.obstacles.CrossMapInfo;
		
	public class Grenade1 extends BulletBase{
		
		private var _target:Point = new Point();
		private var attackRange:int = 150;
		private var _boom:Boolean = false;
		
		private var detonatorTime:Number;
		private var detonatorTimeHalf:Number;
		
		public function Grenade1():void{
			_sprite = new grenade1_mc();
			_damage = 300;
			addChild(_sprite);
			
		}
		
		
		override public function init(ax:int, ay:int,  angel:Number,targetX:int = 0, targetY:int = 0,kind:int = 1):void{
			_isFree = false;
			x = ax;
			y = ay;
			 _target.x = targetX;
 			 _target.y = targetY;
			rotation = Amath.toDegrees(angel);
			_speed.x = (speed)*Math.cos(angel);
			_speed.y = (speed)*Math.sin(angel);
			
			
			
			detonatorTime = Amath.random(85,110)*Amath.distance(x,y,_target.x,_target.y)/(speed*100)
			detonatorTimeHalf = detonatorTime / 2;
			startTimeLife = 640/speed*45;
			timeLife = startTimeLife;
			_instance.bulletController.add(this);
			_instance.addChild(this);
				
		}
		
		
		override public function update(delta:Number):void{
			
			x += _speed.x * delta;
			y += _speed.y * delta;
			
			if (((detonatorTime-=delta) < 0 )  || !CrossMapInfo.canShoot(x,y)){
				_speed.x = _speed.y = 0; 
				_sprite.scaleX = _sprite.scaleY = 2*attackRange/144; 
				Boom();
			} 
			
			super.update(delta);
		}
		
		
		private function Boom():void{
			var enemies:Array = _instance.unitController.objects;
			
			var n:int = enemies.length-1;
			var ememy:UnitBase;
			//var dist:int;
			if (!_boom ){
				_sprite.gotoAndPlay(2);
	
				for (var i:int = n;i>=0 ;i--){
					ememy = enemies[i];
					var dist:int = Amath.distance(x,y,ememy.x,ememy.y);
					
					if ( dist < attackRange){
						var dam:int = _damage*(1.5 - dist/attackRange);
						var _localDamage:int =  (dam > _damage) ? _damage : dam ;
						ememy.addDamage(_localDamage); // Наносим урон врагу
					}
					
				}
			}
			_boom = true; 
			if (_sprite.currentFrame == _sprite.totalFrames){
				free();
			}
		}
		
		override public function free():void{
			super.free();	
		}	
		
		
	}	
}