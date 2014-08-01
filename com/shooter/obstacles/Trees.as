package com.shooter.obstacles {
	import flash.display.*;
	import com.shooter.World;
	import flash.geom.*;
	import com.framework.Amath;
	import com.shooter.obstacles.BlockBase;
	
		public class Trees extends BlockBase{

		
		
		public function Trees( ):void{
		_sprite = new Trees_mc();
		_sprite.gotoAndStop(Amath.random(1,5));
		_sprite.scaleX = _sprite.scaleY = 1.5;
	
		_angel = 360*Math.random();
		rotation  = _angel;
		addChild(_sprite);
	}

	 override public function init(ax:int, ay:int,deep:int = 0):void{
		super.init(ax,ay,1);
	}
	
	override public function free():void{
		
		super.free();
	}
	
	}	
}