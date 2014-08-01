package com.framework{
	
	
	
	public class SimpleCaсhe{
	
		protected var _targetClass:Class;
		protected var _currentIndex:int = -1;
		protected var _instances:Array;
		
		public function  SimpleCaсhe(targetClass:Class, initialCapacity:uint):void{
			_targetClass = targetClass;// базовый класс всех объектов
			_currentIndex = initialCapacity - 1; // индекс текущего свободного 
			_instances = []; // сисок всех объектов
			
			// заполняем обойму
			for (var i:int = 0; i< initialCapacity; i++){
				_instances[i] = getNewInstance(); 
			}
		}
		
		protected function getNewInstance():Object{
			
			return new _targetClass();
			
		}
		
		public function get():Object{
			
			if (_currentIndex >= 0){
				// возвращаем свободнйы оъект из кэша
				_currentIndex--;
				 
				return  _instances[_currentIndex +1];
			} else {
				// если обойма пуста
				return getNewInstance();
			}
		}
		
		public function set(instance:Object):void{
			_currentIndex++;
			// помещаем в свободную ячейку
				_instances[_currentIndex] = instance;
			
		}
	}	
}