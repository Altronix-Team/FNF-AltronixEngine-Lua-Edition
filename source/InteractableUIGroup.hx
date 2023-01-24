package;

import IRelative;
import flixel.addons.ui.FlxUIGroup;
import flixel.math.FlxPoint;
import utils.GestureUtil;

class InteractableUIGroup extends FlxUIGroup implements IInteractable implements IRelative
{
	var gestureStateData:GestureStateData = {};

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		gestureStateData = GestureUtil.handleGestureState(this, gestureStateData);
	}

	public function onJustPressed(pos:FlxPoint)
	{
		// OVERRIDE ME!
	}

	public function onJustPressedMiddle(pos:FlxPoint)
	{
		// OVERRIDE ME!
	}

	public function onJustPressedRight(pos:FlxPoint)
	{
		// OVERRIDE ME!
	}

	public function onJustReleased(pos:FlxPoint, pressDuration:Int)
	{
		// OVERRIDE ME!
	}

	public function onJustReleasedMiddle(pos:FlxPoint, pressDuration:Int)
	{
		// OVERRIDE ME!
	}

	public function onJustReleasedRight(pos:FlxPoint, pressDuration:Int)
	{
		// OVERRIDE ME!
	}

	public function onJustSwiped(start:FlxPoint, end:FlxPoint, swipeDuration:Int, swipeDirection:SwipeDirection)
	{
		// OVERRIDE ME!
	}

	public function onJustHoverEnter(pos:FlxPoint)
	{
		// OVERRIDE ME!
	}

	public function onJustHoverExit(pos:FlxPoint)
	{
		// OVERRIDE ME!
	}
}