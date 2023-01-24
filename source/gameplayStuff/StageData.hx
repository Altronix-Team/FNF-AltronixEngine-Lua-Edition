package gameplayStuff;


import openfl.utils.Assets;
import haxe.Json;


typedef StageFile = {
	var defaultZoom:Float;
	var isPixelStage:Bool;
	var hideGF:Bool;

	var boyfriend:Array<Float>;
	var gf:Array<Float>;
	var dad:Array<Float>;

	var camera_boyfriend:Array<Float>;
	var camera_opponent:Array<Float>;
	var camera_girlfriend:Array<Float>;
	var camera_speed:Null<Float>;
}

class StageData {
	public static function getStageFile(stage:String):StageFile {
		var rawJson:String = null;
		var path:String = Paths.json('stages/$stage');
		
		if (Assets.exists(path)){
			rawJson = Assets.getText(path);
		}
		else
		{
			return null;
		}
		return cast Json.parse(rawJson);
	}
}