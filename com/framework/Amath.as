﻿package com.framework
{
	
	public class Amath extends Object
	{
		private static var dx:Number;
		private static var dy:Number;
		private static var angle:Number
		
		//---------------------------------------
		// PUBLIC METHODS
		//---------------------------------------
		
		/**
		 * Возвращает случайное число в диапазоне от lower до upper.
		 * 
		 * @param lower - наименьшее число диапазона.
		 * @param upper - наибольшее число диапазона.
		 * 
		 * @return случайное целое число.
		 */
		public static function random(lower:Number, upper:Number):Number
		{
			return Math.round(Math.random() * (upper - lower)) + lower;
		}
		
		/**
		 * Сравнивает два значения с заданной погрешностью.
		 * 
		 * @param a, b - сравниваемые значения.
		 * @param diff - допустимая погрешность.
		 * 
		 * @return возвращает true если значения равны, или false если не равны.
		 */
		public static function equal(a:Number, b:Number, diff:Number = 0.00001):Boolean
		{
			return (Math.abs(a - b) <= diff);
		}
		
		/**
		 * Возвращает угол между двумя точками радианах.
		 * 
		 * @param x1, y1 - координаты первой точки.
		 * @param x2, y2 - координаты второй точки.
		 * 
		 * @return угол между двумя точками в радианах.
		 */
		public static function getAngle(x1:Number, y1:Number, x2:Number, y2:Number, norm:Boolean = true):Number
		{
			dx = x2 - x1;
			dy = y2 - y1;
			angle = Math.atan2(dy, dx);
			
			if (norm)
			{
				if (angle < 0)
				{
					angle = Math.PI * 2 + angle;
				}
				else if (angle >= Math.PI * 2)
				{
					angle = angle - Math.PI * 2;
				}
			}
			
			return angle;
		}
		
		/**
		 * Возвращает угол между двумя точками в градусах.
		 * 
		 * @param x1, y1 - координаты первой точки.
		 * @param x2, y2 - координаты второй точки.
		 * 
		 * @return угол между двумя точками в градусах.
		 */
		public static function getAngleDeg(x1:Number, y1:Number, x2:Number, y2:Number, norm:Boolean = true):Number
		{
			dx = x2 - x1;
			dy = y2 - y1;
			angle = Math.atan2(dy, dx) / Math.PI * 180;
			
			if (norm)
			{
				if (angle < 0)
				{
					angle = 360 + angle;
				}
				else if (angle >= 360)
				{
					angle = angle - 360;
				}
			}
			
			return angle;
		}
		
		/**
		 * Переводит угол из радиан в градусы.
		 * 
		 * @param radians - угол в радианах.
		 * 
		 * @return угол в градусах.
		 */
		public static function toDegrees(radians:Number):Number
		{
			return radians * 180 / Math.PI;
		}
		
		/**
		* Переводит угол из градусов в радианы.
		* 
		* @param degrees - угол в градусах.
		* 
		* @return угол в радианах.
		*/
		public static function toRadians(degrees:Number):Number
		{
			return degrees * Math.PI / 180;
		}
		
		
		public static function distance(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			dx = x2 - x1;
			dy = y2 - y1;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		
		public static function dAngleRadian(a1:Number, a2:Number):Number {
			var da:Number = a1 - a2;
			if (da > Math.PI) {
				da = -Math.PI*2 + da;
			} else if (da < -Math.PI) {
				da = Math.PI*2 + da;
			}
			return da;
		}
		public static function dAngleDegree(a1:Number, a2:Number):Number {
			var da:Number = a1 - a2;
			if (da > 180) {
				da = -360 + da;
			} else if (da < -180) {
				da = 360 + da;
			}
			return da;
		}
		
		
		
		
		public static function toPercent(current:Number, total:Number):Number{
			return current/total;
		}
		
		public static function fromPercent(percent:Number, total:Number):Number{
			return percent*total;
		}
		
		
	}

}