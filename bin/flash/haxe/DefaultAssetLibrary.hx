package;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.text.Font;
import flash.media.Sound;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import haxe.Unserializer;
import openfl.Assets;

#if (flash || js)
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLLoader;
#end

#if ios
import openfl.utils.SystemPath;
#end


@:access(flash.media.Sound)
class DefaultAssetLibrary extends AssetLibrary {
	
	
	public static var className (default, null) = new Map <String, Dynamic> ();
	public static var path (default, null) = new Map <String, String> ();
	public static var type (default, null) = new Map <String, AssetType> ();
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("background/background.png", __ASSET__background_background_png);
		type.set ("background/background.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/splashscreen.png", __ASSET__background_splashscreen_png);
		type.set ("background/splashscreen.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("character/apple.png", __ASSET__character_apple_png);
		type.set ("character/apple.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("character/arrow.png", __ASSET__character_arrow_png);
		type.set ("character/arrow.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("character/arrowXML.xml", __ASSET__character_arrowxml_xml);
		type.set ("character/arrowXML.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("character/bulleye.png", __ASSET__character_bulleye_png);
		type.set ("character/bulleye.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("character/bulleye.pyxel", __ASSET__character_bulleye_pyxel);
		type.set ("character/bulleye.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("character/goldbag.png", __ASSET__character_goldbag_png);
		type.set ("character/goldbag.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("character/player.png", __ASSET__character_player_png);
		type.set ("character/player.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("character/player.pyxel", __ASSET__character_player_pyxel);
		type.set ("character/player.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("shop/arrowspeed.png", __ASSET__shop_arrowspeed_png);
		type.set ("shop/arrowspeed.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("shop/button_outline.png", __ASSET__shop_button_outline_png);
		type.set ("shop/button_outline.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("shop/button_outline.pyxel", __ASSET__shop_button_outline_pyxel);
		type.set ("shop/button_outline.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("shop/upgrade.png", __ASSET__shop_upgrade_png);
		type.set ("shop/upgrade.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("data/applechancedata.xml", __ASSET__data_applechancedata_xml);
		type.set ("data/applechancedata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("data/arrownumberdata.xml", __ASSET__data_arrownumberdata_xml);
		type.set ("data/arrownumberdata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("data/arrowspeeddata.xml", __ASSET__data_arrowspeeddata_xml);
		type.set ("data/arrowspeeddata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("data/gamedata.xml", __ASSET__data_gamedata_xml);
		type.set ("data/gamedata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("data/goldchancedata.xml", __ASSET__data_goldchancedata_xml);
		type.set ("data/goldchancedata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		
		
		#elseif html5
		
		addExternal("background/background.png", "image", "background/background.png");
		addExternal("background/splashscreen.png", "image", "background/splashscreen.png");
		addExternal("character/apple.png", "image", "character/apple.png");
		addExternal("character/arrow.png", "image", "character/arrow.png");
		addExternal("character/arrowXML.xml", "text", "character/arrowXML.xml");
		addExternal("character/bulleye.png", "image", "character/bulleye.png");
		addExternal("character/bulleye.pyxel", "binary", "character/bulleye.pyxel");
		addExternal("character/goldbag.png", "image", "character/goldbag.png");
		addExternal("character/player.png", "image", "character/player.png");
		addExternal("character/player.pyxel", "binary", "character/player.pyxel");
		addExternal("shop/arrowspeed.png", "image", "shop/arrowspeed.png");
		addExternal("shop/button_outline.png", "image", "shop/button_outline.png");
		addExternal("shop/button_outline.pyxel", "binary", "shop/button_outline.pyxel");
		addExternal("shop/upgrade.png", "image", "shop/upgrade.png");
		addExternal("data/applechancedata.xml", "text", "data/applechancedata.xml");
		addExternal("data/arrownumberdata.xml", "text", "data/arrownumberdata.xml");
		addExternal("data/arrowspeeddata.xml", "text", "data/arrowspeeddata.xml");
		addExternal("data/gamedata.xml", "text", "data/gamedata.xml");
		addExternal("data/goldchancedata.xml", "text", "data/goldchancedata.xml");
		
		
		#else
		
		#if (windows || mac || linux)
		
		var loadManifest = false;
		
		className.set ("background/background.png", __ASSET__background_background_png);
		type.set ("background/background.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/splashscreen.png", __ASSET__background_splashscreen_png);
		type.set ("background/splashscreen.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("character/apple.png", __ASSET__character_apple_png);
		type.set ("character/apple.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("character/arrow.png", __ASSET__character_arrow_png);
		type.set ("character/arrow.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("character/arrowXML.xml", __ASSET__character_arrowxml_xml);
		type.set ("character/arrowXML.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		
		className.set ("character/bulleye.png", __ASSET__character_bulleye_png);
		type.set ("character/bulleye.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("character/bulleye.pyxel", __ASSET__character_bulleye_pyxel);
		type.set ("character/bulleye.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("character/goldbag.png", __ASSET__character_goldbag_png);
		type.set ("character/goldbag.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("character/player.png", __ASSET__character_player_png);
		type.set ("character/player.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("character/player.pyxel", __ASSET__character_player_pyxel);
		type.set ("character/player.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("shop/arrowspeed.png", __ASSET__shop_arrowspeed_png);
		type.set ("shop/arrowspeed.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("shop/button_outline.png", __ASSET__shop_button_outline_png);
		type.set ("shop/button_outline.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("shop/button_outline.pyxel", __ASSET__shop_button_outline_pyxel);
		type.set ("shop/button_outline.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("shop/upgrade.png", __ASSET__shop_upgrade_png);
		type.set ("shop/upgrade.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("data/applechancedata.xml", __ASSET__data_applechancedata_xml);
		type.set ("data/applechancedata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		
		className.set ("data/arrownumberdata.xml", __ASSET__data_arrownumberdata_xml);
		type.set ("data/arrownumberdata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		
		className.set ("data/arrowspeeddata.xml", __ASSET__data_arrowspeeddata_xml);
		type.set ("data/arrowspeeddata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		
		className.set ("data/gamedata.xml", __ASSET__data_gamedata_xml);
		type.set ("data/gamedata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		
		className.set ("data/goldchancedata.xml", __ASSET__data_goldchancedata_xml);
		type.set ("data/goldchancedata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		
		
		#else
		
		var loadManifest = true;
		
		#end
		
		if (loadManifest) {
			try {
				
				#if blackberry
				var bytes = ByteArray.readFile ("app/native/manifest");
				#elseif tizen
				var bytes = ByteArray.readFile ("../res/manifest");
				#elseif emscripten
				var bytes = ByteArray.readFile ("assets/manifest");
				#else
				var bytes = ByteArray.readFile ("manifest");
				#end
				
				if (bytes != null) {
					
					bytes.position = 0;
					
					if (bytes.length > 0) {
						
						var data = bytes.readUTFBytes (bytes.length);
						
						if (data != null && data.length > 0) {
							
							var manifest:Array<AssetData> = Unserializer.run (data);
							
							for (asset in manifest) {
								
								if (!className.exists(asset.id)) {
									
									path.set (asset.id, asset.path);
									type.set (asset.id, asset.type);
									
								}
							}
						
						}
					
					}
				
				} else {
				
					trace ("Warning: Could not load asset manifest");
				
				}
			
			} catch (e:Dynamic) {
			
				trace ("Warning: Could not load asset manifest");
			
			}
		
		}
		
		#end
		
	}
	
	
	#if html5
	private function addEmbed(id:String, kind:String, value:Dynamic):Void {
		className.set(id, value);
		type.set(id, Reflect.field(AssetType, kind.toUpperCase()));
	}
	
	
	private function addExternal(id:String, kind:String, value:String):Void {
		path.set(id, value);
		type.set(id, Reflect.field(AssetType, kind.toUpperCase()));
	}
	#end
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = DefaultAssetLibrary.type.get (id);
		
		#if pixi
		
		if (assetType == IMAGE) {
			
			return true;
			
		} else {
			
			return false;
			
		}
		
		#end
		
		if (assetType != null) {
			
			if (assetType == type || ((type == SOUND || type == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && type == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (type == BINARY || type == null) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getBitmapData (id:String):BitmapData {
		
		#if pixi
		
		return BitmapData.fromImage (path.get (id));
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), BitmapData);
		
		#elseif openfl_html5
		
		return BitmapData.fromImage (ApplicationMain.images.get (path.get (id)));
		
		#elseif js
		
		return cast (ApplicationMain.loaders.get (path.get (id)).contentLoaderInfo.content, Bitmap).bitmapData;
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), BitmapData);
		else return BitmapData.load (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif openfl_html5
		
		return null;
		
		#elseif js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}

		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if pixi
		
		return null;
		
		#elseif (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists(id)) {
			var fontClass = className.get(id);
			Font.registerFont(fontClass);
			return cast (Type.createInstance (fontClass, []), Font);
		} else return new Font (path.get (id));
		
		#end
		
	}
	
	
	public override function getMusic (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		var sound = new Sound ();
		sound.__buffer = true;
		sound.load (new URLRequest (path.get (id)));
		return sound; 
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}
	
	
	public override function getPath (id:String):String {
		
		#if ios
		
		return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		#else
		
		return path.get (id);
		
		#end
		
	}
	
	
	public override function getSound (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:AssetType):Bool {
		
		#if flash
		
		if (type != AssetType.MUSIC && type != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function loadBitmapData (id:String, handler:BitmapData -> Void):Void {
		
		#if pixi
		
		handler (getBitmapData (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBitmapData (id));
			
		}
		
		#else
		
		handler (getBitmapData (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if pixi
		
		handler (getBytes (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadFont (id:String, handler:Font -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getFont (id));
			
		//}
		
		#else
		
		handler (getFont (id));
		
		#end
		
	}
	
	
	public override function loadMusic (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}
	
	
	public override function loadSound (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getSound (id));
			
		//}
		
		#else
		
		handler (getSound (id));
		
		#end
		
	}
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		#if js
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}
		
		#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		#end
		
	}
	
	
}


#if pixi
#elseif flash

@:keep class __ASSET__background_background_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_splashscreen_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__character_apple_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__character_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__character_arrowxml_xml extends flash.utils.ByteArray { }
@:keep class __ASSET__character_bulleye_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__character_bulleye_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__character_goldbag_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__character_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__character_player_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__shop_arrowspeed_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__shop_button_outline_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__shop_button_outline_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__shop_upgrade_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__data_applechancedata_xml extends flash.utils.ByteArray { }
@:keep class __ASSET__data_arrownumberdata_xml extends flash.utils.ByteArray { }
@:keep class __ASSET__data_arrowspeeddata_xml extends flash.utils.ByteArray { }
@:keep class __ASSET__data_gamedata_xml extends flash.utils.ByteArray { }
@:keep class __ASSET__data_goldchancedata_xml extends flash.utils.ByteArray { }


#elseif html5






















#elseif (windows || mac || linux)


@:bitmap("assets/texture/background/background.png") class __ASSET__background_background_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/background/splashscreen.png") class __ASSET__background_splashscreen_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/character/apple.png") class __ASSET__character_apple_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/character/arrow.png") class __ASSET__character_arrow_png extends flash.display.BitmapData {}
@:file("assets/texture/character/arrowXML.xml") class __ASSET__character_arrowxml_xml extends flash.utils.ByteArray {}
@:bitmap("assets/texture/character/bulleye.png") class __ASSET__character_bulleye_png extends flash.display.BitmapData {}
@:file("assets/texture/character/bulleye.pyxel") class __ASSET__character_bulleye_pyxel extends flash.utils.ByteArray {}
@:bitmap("assets/texture/character/goldbag.png") class __ASSET__character_goldbag_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/character/player.png") class __ASSET__character_player_png extends flash.display.BitmapData {}
@:file("assets/texture/character/player.pyxel") class __ASSET__character_player_pyxel extends flash.utils.ByteArray {}
@:bitmap("assets/texture/shop/arrowspeed.png") class __ASSET__shop_arrowspeed_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/shop/button_outline.png") class __ASSET__shop_button_outline_png extends flash.display.BitmapData {}
@:file("assets/texture/shop/button_outline.pyxel") class __ASSET__shop_button_outline_pyxel extends flash.utils.ByteArray {}
@:bitmap("assets/texture/shop/upgrade.png") class __ASSET__shop_upgrade_png extends flash.display.BitmapData {}
@:file("assets/data/applechancedata.xml") class __ASSET__data_applechancedata_xml extends flash.utils.ByteArray {}
@:file("assets/data/arrownumberdata.xml") class __ASSET__data_arrownumberdata_xml extends flash.utils.ByteArray {}
@:file("assets/data/arrowspeeddata.xml") class __ASSET__data_arrowspeeddata_xml extends flash.utils.ByteArray {}
@:file("assets/data/gamedata.xml") class __ASSET__data_gamedata_xml extends flash.utils.ByteArray {}
@:file("assets/data/goldchancedata.xml") class __ASSET__data_goldchancedata_xml extends flash.utils.ByteArray {}


#end
