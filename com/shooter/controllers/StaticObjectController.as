package com.shooter.controllers{
	import com.shooter.World;
	import com.shooter.interfaces.*;
	
	public class StaticObjectController extends Object{
		
		public  var objects:Array = [];

		public function StaticObjectController():void{
				
		}
		
		// добавляет объект в контроллер
		public function add(obj:IStaticObject):void{
			objects.push(obj);
			
			
		}
		
		public function get(i:int):void{
			//return objects[i];
		}
		
		public function visibleChange():void{
			for (var i:int = 0; i < objects.length; i++){
				objects[i].visible = !objects[i].visible; 
			}
		}
		
		
		
		// удаляет объект из контроллер
		public function remove(obj:IStaticObject):void{
			
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

	}
}