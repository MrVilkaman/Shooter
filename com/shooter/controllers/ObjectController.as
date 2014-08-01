package com.shooter.controllers{
	import com.shooter.World;
	import com.shooter.interfaces.*;
	
	public class ObjectController extends Object{
		private var n:int = 0;
		public var objects:Array = [];

		// из за этого было переполнение стека! и одному Ктулху известно почему!
		//private var _world:World = World.getInstance();
		
		public function ObjectController():void{
				
		}
		
		// добавляет объект в контроллер
		public function add(obj:IGameObject):void{
			objects.push(obj);
			
		}
		
		// удаляет объект из контроллер
		public function remove(obj:IGameObject):void{
			
			for (var i:int = 0; i < objects.length; i++)
				{
					if (objects[i] == obj)
					{
						objects[i] = null;
						objects.splice(i, 1);
						break;
					}
				}
		
		}
		
		// удаляет ВСЕ объектыж
		public function clear():void{
			while (objects.length > 0 ){
				objects[0].free();
			}
		}
		
		public function update(delta:Number):void{
			//trace("1");
			 n = objects.length - 1;
			//trace("2");
			for (var i:int = n; i>=0; i--){
				objects[i].update(delta);
				
			}
			//trace("3");
		}
	
	}
}