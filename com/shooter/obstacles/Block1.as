package com.shooter.obstacles {
	import flash.display.*;
	import com.shooter.World;
	import flash.geom.*;
	import com.framework.Amath;
	import com.shooter.obstacles.BlockBase;
	
		public class Block1 extends BlockBase{

		
		
		public function Block1( ):void{
			
		_sprite = new Block1_mc();
		_sprite.gotoAndStop(Amath.random(1,3));
		_angel = 150*Math.random()-90;

		rotation  = _angel;
		addChild(_sprite);

	}
	
	
	 override public function init(ax:int, ay:int, deep:int = 0):void{
		
		super.init(ax,ay,0);
		createCrossMap();
	}
	
	override public function free():void{
		
		super.free();
	}
	
	}	
}