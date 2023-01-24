package scriptStuff;

import scriptStuff.FunkinLua;
@:allow(states.PlayState)
class ScriptHelper
{
	public static var hscriptFiles:Array<Dynamic> = [];
	public static var luaArray:Array<FunkinLua> = [];

	public static function clearAllScripts()
	{
		hscriptFiles = [];
		luaArray = [];
		Debug.logInfo('Cleared all scripts');
	}

	public static function setOnScripts(name:String, value:Dynamic)
	{
		setOnHscript(name, value);
		setOnLuas(name, value);
	}

	public static function callOnScripts(functionToCall:String, args:Array<Dynamic>):Dynamic {
		callOnHscript(functionToCall, args);
		return callOnLuas(functionToCall, args);
	}

	public static function setOnHscript(name:String, value:Dynamic)
	{
		for (script in hscriptFiles)
		{
			script.scriptHandler.set(name, value);
		}
	}

	public static function callOnHscript(functionToCall:String, ?params:Array<Any>):Dynamic
	{
		var retVal = false;
		for (script in hscriptFiles)
		{
			var scriptHelper = script.scriptHandler;
			if (scriptHelper.exists(functionToCall))
			{
				if (scriptHelper.call(functionToCall, params) != null)
					retVal = true;
			}
		}
		return retVal;
	}

	public static function isFunctionExists(funcName:String):Bool
	{
		var retVal = false;
		for (script in hscriptFiles)
		{
			var scriptHelper = script.scriptHandler;
			if (scriptHelper.exists(funcName))
				retVal = true;
		}
		return retVal;
	}

	private static var preventLuaRemove:Bool = false;

	public static function removeLua(lua:FunkinLua)
	{
		if (luaArray != null && !preventLuaRemove)
		{
			luaArray.remove(lua);
		}
	}

	public static var closeLuas:Array<FunkinLua> = [];

	public static function callOnLuas(event:String, args:Array<Dynamic>, ignoreStops = false, ?exclusions:Array<String>):Dynamic
	{
		var returnVal:Dynamic = FunkinLua.Function_Continue;
		if (exclusions == null)
			exclusions = [];
		#if LUA_ALLOWED
		for (i in 0...luaArray.length)
		{
			if (exclusions.contains(luaArray[i].scriptName))
			{
				continue;
			}
			var ret:Dynamic = luaArray[i].call(event, args);
			if (ret == FunkinLua.Function_StopLua)
			{
				if (ignoreStops)
					ret = FunkinLua.Function_Continue;
				else
					break;
			}

			if (ret != FunkinLua.Function_Continue)
			{
				returnVal = ret;
			}
		}

		for (i in 0...closeLuas.length)
		{
			luaArray.remove(closeLuas[i]);
			closeLuas[i].stop();
		}
		#end
		return returnVal;
	}

	public static function setOnLuas(variable:String, arg:Dynamic)
	{
		#if LUA_ALLOWED
		for (i in 0...luaArray.length)
		{
			luaArray[i].set(variable, arg);
		}
		#end
	}

	public static function stepHit()
	{
		callOnScripts('onStepHit', []);
	}

	public static function beatHit()
	{
		callOnScripts('onBeatHit', []);
	}

	public static function sectionHit()
	{
		callOnScripts('onSectionHit', []);
	}
}