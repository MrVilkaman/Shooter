package com.shooter.obstacles {
	import com.shooter.World;
		public class CrossMapInfo extends BlockBase{

		
		public static const COLOR_BUSY_MOVE:Number = 0xFF0000;
		public static const COLOR_BUSY_BULLET:Number = 0xFFFF00;
		
			
		
		private static var _instance:World = World.getInstance();
		
		
		public static function canGo(ax:int, ay:int):Boolean{
			//trace("Begin!")
			var buff:Number = _instance._crossMap.bitmapData.getPixel(ax,ay);
			if(buff == COLOR_BUSY_MOVE || buff == COLOR_BUSY_BULLET ){
				//trace("Нельзя!!")
				return false;
			}
				//trace("False!")
			return true;
		}
		
		public static function canBuild(ax:int, ay:int):Boolean{
			//trace("Begin!")
			var buff:Number = _instance._crossMap.bitmapData.getPixel(ax,ay);
			if(buff == COLOR_BUSY_MOVE || buff == COLOR_BUSY_BULLET ){
				//trace("Нельзя!!")
				return false;
			}
				//trace("False!")
			return true;
		}
		
		public static function canShoot(ax:int, ay:int):Boolean{
			
			if(_instance._crossMap.bitmapData.getPixel(ax,ay) == COLOR_BUSY_BULLET ){
				//trace("Нельзя!!")
				return false;
			}
				//trace("False!")
			return true;;
		}
		
		
		
		}
}