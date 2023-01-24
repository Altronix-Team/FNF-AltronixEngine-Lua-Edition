package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;
import openfl.utils.Assets;
import haxe.Json;
import haxe.format.JsonParser;

typedef MenuCharacterFile = {
	var image:String;
	var scale:Float;
	var position:Array<Int>;
	var idle_anim:String;
	var confirm_anim:String;
	var ?flipX:Bool;
}

class MenuCharacter extends FlxSprite
{
	public var character:String;
	private static var DEFAULT_CHARACTER:String = 'bf';

	public function new(x:Float, character:String = 'bf')
	{
		super(x);

		changeCharacter(character);
	}

	public function changeCharacter(?character:String = 'bf') {
		if(character == null) character = '';
		if(character == this.character) return;

		this.character = character;
		antialiasing = Main.save.data.antialiasing;
		visible = true;

		var dontPlayAnim:Bool = false;
		scale.set(1, 1);
		updateHitbox();

		switch(character) {
			case '':
				visible = false;
				dontPlayAnim = true;
			default:
				var rawJson = null;

				var path:String = Paths.json('images/menucharacters/' + character, "core");
				if(!Assets.exists(path)) {
					path = Paths.json('images/menucharacters/' + DEFAULT_CHARACTER, "core");
				}
				rawJson = Assets.getText(path);
				
				var charFile:MenuCharacterFile = cast Json.parse(rawJson);
				frames = Paths.getSparrowAtlas('menucharacters/' + charFile.image, "core");
				animation.addByPrefix('idle', charFile.idle_anim, 24);
				animation.addByPrefix('confirm', charFile.confirm_anim, 24, false);

				flipX = charFile.flipX == null ? false : charFile.flipX;

				if(charFile.scale != 1) {
					scale.set(charFile.scale, charFile.scale);
					updateHitbox();
				}
				offset.set(charFile.position[0], charFile.position[1]);
				animation.play('idle');
		}
	}
}
