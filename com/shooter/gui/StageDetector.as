package com.shooter.gui{
	import flash.events.*;
	import flash.display.*;
	
	public class StageDetector extends EventDispatcher {
		
		public static const ADDED_TO_STAGE:String = "ADDED_TO_STAGE"; 
		public static const REMOVED_FROM_STAGE:String = "REMOVED_FROM_STAGE";
		private var WatchedObject:DisplayObject = null;
		private var watchedRoot:DisplayObject = null;
		private var onStage:Boolean = false;
		
		
	public function StageDetector(objectToWatch:DisplayObject ):void{
		setWatchedObjeck(objectToWatch);
		}
	
	public function setWatchedObjeck(objectToWatch:DisplayObject ):void{
		WatchedObject = objectToWatch;
		
		if (WatchedObject.stage  !=null){
			onStage = true;
			}
		
		setWatchedRoot(findWatchedObjectRoot());
		}
		
	public function	 getWatchedObjeck():DisplayObject {
		return WatchedObject;
		}
		
	public function	dispose():void{
		WatchedObject = null;
		}
		
	private function addedListener(e:Event ):void{
		if (e.eventPhase == EventPhase.AT_TARGET ){
			onStage = true;
			dispatchEvent(new Event(StageDetector.ADDED_TO_STAGE));
		}
			setWatchedRoot(findWatchedObjectRoot());
			}
		
	
	private function removedListener(e:Event ):void{
		if (onStage){
			var wasRemoved:Boolean = false;
			var ancestor:DisplayObject = WatchedObject;
			var target:DisplayObject =  DisplayObject(e.target);
		while(ancestor != null){
			if (target == ancestor){ 
			wasRemoved = true;
			break;
			}
			ancestor = ancestor.parent;
			}
		if (wasRemoved){
			setWatchedRoot(target);
			onStage = false;
			dispatchEvent(new Event(StageDetector.REMOVED_FROM_STAGE));
			}
			}
		}
	private function findWatchedObjectRoot():DisplayObject{
		var watchedObjectRoot:DisplayObject = WatchedObject;
		while(watchedObjectRoot.parent !=null){
			watchedObjectRoot = watchedObjectRoot.parent;
			}
		return watchedObjectRoot;
		} 
	private function setWatchedRoot(newWatchedRoot:DisplayObject):void{
	clearWatchRoot( );
	watchedRoot = newWatchedRoot;
	registerListeners(watchedRoot);
	}
	
	private function clearWatchRoot( ):void{
	if (watchedRoot != null){
		unregisterListeners(watchedRoot);
		watchedRoot = null;
		}
	}
	
	private function registerListeners(target:DisplayObject):void{
		target.addEventListener(Event.ADDED, addedListener);
		target.addEventListener(Event.REMOVED, removedListener);
		}
		
	private function unregisterListeners(target:DisplayObject):void{
		target.removeEventListener(Event.ADDED, addedListener);
		target.removeEventListener(Event.REMOVED, removedListener);
		}	
			
	}	
}