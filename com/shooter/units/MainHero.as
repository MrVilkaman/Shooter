package com.shooter.units{
	import  flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import com.shooter.World;
	import com.shooter.Game;
	import com.framework.Amath;
	import com.shooter.bullet.*;
	import com.shooter.obstacles.CrossMapInfo;
	import com.shooter.Main;
	import com.shooter.weapon.*;
	import flash.utils.*;
	
	public class MainHero extends MovieClip /*implements IEventDispatcher*/{
		
		
		private static var _world:World = World.getInstance();
		private static var _game:Game = Game.getInstance();
		private  var _sprite:MovieClip = new Hero_mc();  
		var _body:Sprite = new Sprite();  
		var _spriteEffect:Sprite = new Sprite();  

		//private var _speed:Point = new Point();
		var _worldPoint:Point;
		private var  _barrelMachinePos:Point = new Point();
		private var _barrelMachineAngle:Number = 0;
		private var _pos:Point = new Point();
		private var bull:GunBullet;
		private var _activeWeapon:WeaponBase;
	
		private var _shootDelay:int = 0;
		
		public var isShot:Boolean  = false;
		public var alive:Boolean  = true;
		
		
		protected var _weapons:Array = [];
		// характеристики
		private const maxHealth:int = 500;
		
		
		private const speedBase:int = 150;
		private var speed:int;
		private var _attackInterval:int;
		private var _grenades:int;
		
		
		//----------------------
		var stanTimer:Timer = new Timer(2000);
		
		private var health:int;

		private var x0:int = 0;
		private var x9:int = _world.MAP_SIZE_X;
		private var y0:int = 0;
		private var y9:int = _world.MAP_SIZE_Y;
		private var _border:int  = 90;
		
		
	public function MainHero():void{
				addChild(_sprite);
				_sprite.gotoAndStop(1);
				_spriteEffect = new WebEffect_mc();
	}
	
	public function init(X:int = 600, Y:int = 20):void{
		x = X;
		y = Y;
		
		_weapons = [new Shotgan(), new AK_47()];
		trace(_weapons.toString());
		 _activeWeapon = _weapons[0];
		// характеристики
		speed = speedBase;
		 _grenades = 3;
		health = maxHealth;
		//addChild(_body);
		addChild(_sprite);
		_sprite.gotoAndStop(1);
		
		if(alive){
			_world.addChildAt(this, 4);
		}
		
		alive = true;
		
		_game.changeHealth(health);
		_game.changeAmmoInfo(_activeWeapon.ammo,_activeWeapon.totalAmmo);
		_game.changeGrenadeInfo(_grenades);
		
		_worldPoint = new Point(-(x - Main.SCR_WDIV),-(y - Main.SCR_HDIV)); 
		
		// это что бы при появлении не было выхода камеры за границы фона
		
		if (x - Main.SCR_WDIV  < x0){
			_worldPoint.x = -x0;
		} else if (x + Main.SCR_WDIV  > x9){
			_worldPoint.x = -(x9 - Main.SCR_W );
		}
		
		if (y - Main.SCR_HDIV < y0){
			_worldPoint.y = -y0;
		} else	if (y + Main.SCR_HDIV > y9){
			_worldPoint.y = -(y9 - Main.SCR_H);
		}
		
		_world.x = _worldPoint.x;
		_world.y = _worldPoint.y;

	}

	public function update(delta:Number):void{

			_pos.x = x;
			_pos.y = y;
			
			if (_game.heroLeft){
			_pos.x -= speed*delta;
			}
			if (_game.heroRight){
			_pos.x += speed*delta;
			}
			if (_game.heroDown){
			_pos.y += speed*delta;
			}
			if (_game.heroUp){
			_pos.y -= speed*delta;
			} 
			
			if (_pos.x != x || _pos.y != y){
			
				
				if (CrossMapInfo.canGo(_pos.x,_pos.y)){
					x = _pos.x;
					y = _pos.y;
				}
				
				if (x -_body.width/2 < x0){
					x = _body.width/2;
				} else if (x + _body.width/2 > x9){
					x = x9 -_body.width/2;
				}
				
				if (y -_body.height/2 < y0){
					y = _body.height/2;
				} else if (y + _body.height/2 > y9){
					y = y9 -_body.height/2;
				}

				
				// СКРОЛИНГ КАМЕРЫ
				
				var _eX:Number = _worldPoint.x + (x - Main.SCR_WDIV);
				var _eY:Number = _worldPoint.y + (y - Main.SCR_HDIV);
				_worldPoint.x =  (_eX> _border) ? -(x - Main.SCR_WDIV - _border) : (_eX < -_border)? -(x - Main.SCR_WDIV + _border) :  _worldPoint.x;
				
				/// два варианта как сделать прокрутку по Y;
				//_worldPoint.y =  (_eY> _border) ? -(y - Main.SCR_HDIV - _border) : (_eY < -_border)? -(y - Main.SCR_HDIV + _border) :  _worldPoint.y;
				
				_worldPoint.y = -(y - Main.SCR_HDIV);
				
				
				if (x - Main.SCR_WDIV + _border < x0){
				_worldPoint.x = -x0;
				} else if (x + Main.SCR_WDIV - _border > x9){
				_worldPoint.x = -(x9 - Main.SCR_W );
				}
				
				if (y - Main.SCR_HDIV < y0){
				_worldPoint.y = -y0;
				} else			if (y + Main.SCR_HDIV > y9){
				_worldPoint.y = -(y9 - Main.SCR_H);
				}
			
				_world.x = _worldPoint.x;
				_world.y = _worldPoint.y;
				
			}
			_shootDelay--;
			
			rotation = Amath.getAngleDeg(x,y,_world.mouseX,_world.mouseY);
			
			
			if (isShot){
				if (_shootDelay<= 0){
						if (_activeWeapon.ammo>0){
							_activeWeapon.ammo--;
							_game.changeAmmoInfo(_activeWeapon.ammo,_activeWeapon.totalAmmo);
							shoot();
							_shootDelay =  _activeWeapon.ATTACK_INTERVAL;
						} else {
							if (_activeWeapon.totalAmmo>0)
							reloadWeapon();
						}
				}
			}
	}
	
	public function supplementAmmunition(kind:int, value:int ):void{
	switch (kind){
			case 2:
				_grenades += value;
				_game.changeGrenadeInfo(_grenades);
			break;
			case 3:
				_weapons[0].totalAmmo += value;
			break;
			case 4:
				_weapons[1].totalAmmo += value;
			break;
		}
		_game.changeAmmoInfo(_activeWeapon.ammo,_activeWeapon.totalAmmo);
	}
	
	
	public function throwGrenade():void{ 
		if ( _grenades){
			_grenades--;
			var _angle:Number;
			var granade:Grenade1 = new Grenade1();
			if (_game.heroLeft || _game.heroDown || _game.heroUp ||  _game.heroRight){
				_angle = attackAngleWithMisfires(8);
			} else {
				_angle = attackAngleWithMisfires(2);
			}
			
			granade.init(x,y,_angle,_world.mouseX,_world.mouseY);
			_game.changeGrenadeInfo(_grenades);
		}
	}

	public function reloadWeapon():void{ 
		_shootDelay =   _activeWeapon.RELOADING_TIME;
		
		var dAmmo:int = _activeWeapon.totalAmmo + _activeWeapon.ammo - _activeWeapon.MAX_AMMO;
		_activeWeapon.totalAmmo = (dAmmo  > 0)? dAmmo: 0 ;
		_activeWeapon.ammo = (dAmmo > 0)? _activeWeapon.MAX_AMMO :  dAmmo +  _activeWeapon.MAX_AMMO ;
		_game.changeAmmoInfo(_activeWeapon.ammo,_activeWeapon.totalAmmo);	
	}
	
	private function attackAngleWithMisfires(angle:int):Number{ 
		_barrelMachinePos.x = x-15*Math.sin(Amath.toRadians(rotation));
		_barrelMachinePos.y = y+13*Math.cos(Amath.toRadians(rotation));
		_barrelMachineAngle = Amath.getAngleDeg(_barrelMachinePos.x,_barrelMachinePos.y,_world.mouseX,_world.mouseY);
		return Amath.toRadians(_barrelMachineAngle + Amath.random(-angle,angle))
	}
	
	public function shoot():void{ 
		_sprite.gotoAndStop("Fire");
		_activeWeapon.shoot();
		
	}
	
	public  function addDamage(damage:int):void{
		health -=damage;
		if (health>= maxHealth){
			health = maxHealth;
		}
		_game.changeHealth(health);
		if (health <= 0)
		died();
	}
	
	
	public function needAmmunition():int{
		if( health <= maxHealth * .25 ){
			return 1;
		}
		if( _weapons[1].totalAmmo <= 30 ){
			return 4;
		}
		if( _weapons[0].totalAmmo <= 8 ){
			return 3;
		}
		if( _grenades == 0){
			return 2;
		}
		return 0;
	}
	
	public function changeWeapon(value:int):void{
		switch(value){
			case 1:
				 _game.changeWeapon(1);
				 _activeWeapon = _weapons[0];
			break;
			case 2:
				 _activeWeapon = _weapons[1];
				 _game.changeWeapon(2);
			break;
		}
		_game.changeAmmoInfo(_activeWeapon.ammo,_activeWeapon.totalAmmo);	
	}
	
	public function applyEffect():void{
		speed = 0;
		stanTimer.start();
		stanTimer.addEventListener(TimerEvent.TIMER, stanTimerListener);
		addChild(_spriteEffect);
	}
	
	private function stanTimerListener(event:TimerEvent):void {
			stanTimer.stop();
			speed = speedBase;
			removeChild(_spriteEffect);
	}
	
	private function died():void{
		_sprite.gotoAndStop("Dead");
		alive = false;
		_game.dispatchEvent(new Event(Game.GAME_OVER));
		
	}
	
	}
}

