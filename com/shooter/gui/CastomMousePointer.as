package com.shooter.gui {
		import flash.display.*;
		import flash.geom.*;
		import flash.ui.*;
		import flash.events.*;
	
	public class CastomMousePointer extends Sprite{
		
		private var _sprite:Sprite = new Pointer_mc();
		private var pointInParent:Point = new Point();
		private var newParent:Point = new Point();
		
		
		public function CastomMousePointer( ):void{
		mouseEnabled = false;
		addChild(_sprite);
		
		var stageDetector:StageDetector = new StageDetector(this); 
		stageDetector.addEventListener(StageDetector.ADDED_TO_STAGE, addedToStageListener);
		stageDetector.addEventListener(StageDetector.REMOVED_FROM_STAGE, removedFromStageListener);
		}
		
		private function addedToStageListener(e:Event):void{
			Mouse.hide();
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveListener);
			stage.addEventListener(Event.MOUSE_LEAVE, mouseLeaveListener);
			}
		
		
		private function removedFromStageListener(e:Event):void{
			Mouse.show();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveListener);
			stage.removeEventListener(Event.MOUSE_LEAVE, mouseLeaveListener);
			}
			
			private function mouseLeaveListener(e:Event):void{
			visible = false;
			} 
			
		
		private function mouseMoveListener(e:MouseEvent):void{
			newParent.x = e.stageX;
			newParent.y = e.stageY;
			pointInParent = parent.globalToLocal(newParent);
			x = pointInParent.x;
			y = pointInParent.y;
			e.updateAfterEvent();
			if (!visible){
				visible = true;
			}
			
		} 
		
		
		
		
		} 
	}