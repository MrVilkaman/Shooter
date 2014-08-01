package com.shooter.units{
	
	import com.shooter.World;
		
	public class UnitWave {
	
	public var startDelay:Number = 0;
	
	private var _instance:World;
	private var _enemies:Array = [];
	private var _enemyIndex:int = 0;
	private var _enemy:Object = null;
	private var _isStarted:Boolean = false;
	private var _interval:Number = 0;
	
	
	
	public function UnitWave():void{
		_instance = World.getInstance();
		
	}
	
	public function addEnemy(kind:uint, count:int, respawnInterval:Number):void{
	
	_enemies[_enemies.length] = { kind:kind, 
	    count:count,
	    respawn:respawnInterval };
	}
	
	public function addDelay( respawnInterval:Number):void{
	
	addEnemy(0,0,respawnInterval);
	}
	
	
	public function startWave():void{
	
		if (!_isStarted){
			_enemyIndex = 0;
			_interval = startDelay;
			_isStarted = true;
		}
	}
	
	public function update(delta:Number):void{
		if (_isStarted){
			if ((_interval -= delta)<=0){
				if (!nextEnemy()){
					_isStarted = false;
				}
			}
		}
	}
	
	public function nextEnemy():Boolean{
		if(_enemyIndex < _enemies.length){
			if(_enemy == null){
				var o:Object = _enemies[_enemyIndex];
				_enemy = {kind:o.kind,
				count:o.count,
				respawn:o.respawn};
			}		
			_instance.addEnemy(_enemy.kind);
			 _interval = _enemy.respawn;
			 
			if(--_enemy.count<= 0){
				_enemyIndex++;
				_enemy = null;
			}
			return true;
		}
		return false;
	}
	
	public function get isFinished():Boolean{
		return !_isStarted;
	}
	
	}
}