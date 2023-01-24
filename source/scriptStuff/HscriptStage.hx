package scriptStuff;

import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxSpriteGroup;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.group.FlxGroup.FlxTypedGroup;
import Paths;
import scriptStuff.HScriptHandler;
import states.PlayState;
import gameplayStuff.Character;
import gameplayStuff.Boyfriend;

class HscriptStage extends HScriptModchart
{
	var state:PlayState;

	public var gf:Character = null;
	public var dad:Character = null;
	public var boyfriend:Boyfriend = null;

	public var gfGroup:FlxSpriteGroup;
	public var dadGroup:FlxSpriteGroup;
	public var boyfriendGroup:FlxSpriteGroup;

	public var addedCharacters:Array<Character> = [];
	public var addedCharacterGroups:Array<FlxSpriteGroup> = [];

	public var objectsMap:Map<String, FlxBasic> = new Map<String, FlxBasic>();
	public var objectsArray:Array<FlxBasic> = [];

	public function new(path:String, state:PlayState)
	{
		super(path, state);

		gf = state.gf;
		dad = state.dad;
		boyfriend = state.boyfriend;

		gfGroup = state.gfGroup;
		dadGroup = state.gfGroup;
		boyfriendGroup = state.boyfriendGroup;
		
		#if !USE_SSCRIPT
		scriptHandler.expose.set("stage", this);
		scriptHandler.expose.set("addGf", addGf);
		scriptHandler.expose.set("addDad", addDad);
		scriptHandler.expose.set("addBoyfriend", addBoyfriend);
		scriptHandler.expose.set("addGfGroup", addGfGroup);
		scriptHandler.expose.set("addDadGroup", addDadGroup);
		scriptHandler.expose.set("addBoyfriendGroup", addBoyfriendGroup);
		scriptHandler.expose.set("addObject", addObject);
		scriptHandler.expose.set("getObject", getObject);
		scriptHandler.expose.set('BGSprite', BGSprite);
		scriptHandler.expose.set('BackgroundGirls', BackgroundGirls);
		scriptHandler.expose.set('BackgroundDancer', BackgroundDancer);
		scriptHandler.expose.set('TankmenBG', TankmenBG);
		#else
		scriptHandler.set("stage", this);
		scriptHandler.set("addGf", addGf);
		scriptHandler.set("addDad", addDad);
		scriptHandler.set("addBoyfriend", addBoyfriend);
		scriptHandler.set("addGfGroup", addGfGroup);
		scriptHandler.set("addDadGroup", addDadGroup);
		scriptHandler.set("addBoyfriendGroup", addBoyfriendGroup);
		scriptHandler.set("addObject", addObject);
		scriptHandler.set("getObject", getObject);
		#end
		this.state = state;
	}

	override public function add(object:FlxBasic):FlxBasic {
		if (object != null)
		{
			return super.add(object);
		}
		else
		{
			Debug.logError('Failed to add object to stage');
			return null;
		} 
	}

	public function addObject(object:FlxBasic, objectName:String) {
		if (object != null)
		{
			if (objectName != null)
				objectsMap.set(objectName, object);
			objectsArray.push(object);
			this.add(object);
		}
		else
		{
			Debug.logError('Failed to add object to stage');
		} 	
	}

	public function getObject(objectName:String):FlxBasic
	{
		if (objectName != null)
		{
			return objectsMap.get(objectName);
		}
		else
		{
			Debug.logError('Failed to get object from stage');
			return null;
		}
	}

	public function addGf() {
		add(gf);
		addedCharacters.push(gf);
	}

	public function addDad(){
		add(dad);
		addedCharacters.push(dad);
	}

	public function addBoyfriend(){
		add(boyfriend);
		addedCharacters.push(boyfriend);
	}

	public function addGfGroup()
	{
		add(gfGroup);
		addedCharacterGroups.push(gfGroup);
	}

	public function addDadGroup()
	{
		add(dadGroup);
		addedCharacterGroups.push(dadGroup);
	}

	public function addBoyfriendGroup()
	{
		add(boyfriendGroup);
		addedCharacterGroups.push(boyfriendGroup);
	}

	public function getCharacterByIndex(whose:Int):gameplayStuff.Character
	{
		switch (whose)
		{
			case 0:
				return state.dad;
			case 1:
				return state.boyfriend;
			case 2:
				return state.gf;
			default:
				return null;
		}
		return null;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (scriptHandler.exists('onUpdate'))
			scriptHandler.call('onUpdate', [elapsed]);
	}

}