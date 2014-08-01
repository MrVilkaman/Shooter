package com.shooter.gui {
	
	import com.framework.Amath;
	import flash.display.MovieClip;
	public class HealthBar extends MovieClip{
		
		private var _fullHealth:Number;
		
		
		public function HealthBar():void{
			this.stop();
		}
		
		public function reset(fullHealth:Number):void{
			_fullHealth = fullHealth;
			this.gotoAndStop(this.totalFrames);
		}
		
		public function update(health:Number):void{
			var percent:Number = Amath.toPercent(health, _fullHealth);
			this.gotoAndStop(Math.round(Amath.fromPercent(percent, this.totalFrames)));
		}
		
	
	}
}