package com.shooter.obstacles {
	import flash.display.*;
	import com.shooter.World;
	import flash.geom.*;
	import com.framework.Amath;
	import com.shooter.interfaces.IStaticObject;
	import com.shooter.obstacles.CrossMapInfo;
	
		public class BlockBase extends Sprite implements IStaticObject{
		

			
			
		protected static var _instance:World = World.getInstance();
		protected  var _sprite:MovieClip;
		protected var _angel:Number = 0;
		protected var kind:int;

		
	public function BlockBase( ):void{
		
	}
	
	public function init(ax:int, ay:int, deep:int = 0):void{
		x = ax;
		y = ay;
		
		//_instance.blocksController.add(this);
		
		var matrix:Matrix = new Matrix();
			matrix.rotate(Amath.toRadians(rotation));
			matrix.tx = x;
			matrix.ty = y;
		var bmpData:BitmapData;
		if(!deep){
		

			bmpData = _instance.decorMap.bitmapData;
			bmpData.draw( _sprite,matrix);
			_instance.decorMap.bitmapData = bmpData;
		} else {
			
			bmpData = _instance.decorMap2.bitmapData;
			bmpData.draw( _sprite,matrix);
			_instance.decorMap2.bitmapData = bmpData;
			
		}
		//_instance.addChild(this);
	}
	
	public function free():void{
		_instance.blocksController.remove(this);
		//_instance.removeChild(this);
	}

	public function createCrossMap():void{
		var zamenaCveta:ColorTransform = new ColorTransform();		
		zamenaCveta.color = CrossMapInfo.COLOR_BUSY_MOVE;
		var bmpData:BitmapData = _instance._crossMap.bitmapData;
		var matrix:Matrix = new Matrix();
		var matrix2:Matrix = new Matrix();
		matrix.scale(1.21,1.21);
		matrix2.rotate(Amath.toRadians(_angel));
		matrix.rotate(Amath.toRadians(_angel));
		matrix2.tx = matrix.tx = x;
		matrix2.ty = matrix.ty = y;
		bmpData.draw( _sprite,matrix, zamenaCveta);
		zamenaCveta.color = CrossMapInfo.COLOR_BUSY_BULLET;
		bmpData.draw( _sprite,matrix2, zamenaCveta);
		_instance._crossMap.bitmapData = bmpData;
	}
	
	}	
}