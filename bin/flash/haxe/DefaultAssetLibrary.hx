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
		
		className.set ("background/audience - Copy.png", __ASSET__background_audience___copy_png);
		type.set ("background/audience - Copy.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/audience.png", __ASSET__background_audience_png);
		type.set ("background/audience.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/audience.pyxel", __ASSET__background_audience_pyxel);
		type.set ("background/audience.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("background/audiencerow1.png", __ASSET__background_audiencerow1_png);
		type.set ("background/audiencerow1.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/background.png", __ASSET__background_background_png);
		type.set ("background/background.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/backgroundx.png", __ASSET__background_backgroundx_png);
		type.set ("background/backgroundx.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/backtent.png", __ASSET__background_backtent_png);
		type.set ("background/backtent.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/circus.pyxel", __ASSET__background_circus_pyxel);
		type.set ("background/circus.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("background/door copy.png", __ASSET__background_door_copy_png);
		type.set ("background/door copy.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/door.png", __ASSET__background_door_png);
		type.set ("background/door.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/door.pyxel", __ASSET__background_door_pyxel);
		type.set ("background/door.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("background/gamerailing.png", __ASSET__background_gamerailing_png);
		type.set ("background/gamerailing.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/gamerailingx.png", __ASSET__background_gamerailingx_png);
		type.set ("background/gamerailingx.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/lighting.png", __ASSET__background_lighting_png);
		type.set ("background/lighting.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/lighting.psd", __ASSET__background_lighting_psd);
		type.set ("background/lighting.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("background/middlecircle.psd", __ASSET__background_middlecircle_psd);
		type.set ("background/middlecircle.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("background/preview.pyxel", __ASSET__background_preview_pyxel);
		type.set ("background/preview.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("background/railing.png", __ASSET__background_railing_png);
		type.set ("background/railing.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/railing.pyxel", __ASSET__background_railing_pyxel);
		type.set ("background/railing.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("background/railingfull.png", __ASSET__background_railingfull_png);
		type.set ("background/railingfull.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/railingfull2.png", __ASSET__background_railingfull2_png);
		type.set ("background/railingfull2.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/railingthin.pyxel", __ASSET__background_railingthin_pyxel);
		type.set ("background/railingthin.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("background/result.png", __ASSET__background_result_png);
		type.set ("background/result.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/ring.png", __ASSET__background_ring_png);
		type.set ("background/ring.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/splashscreen.png", __ASSET__background_splashscreen_png);
		type.set ("background/splashscreen.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/spotlight.png", __ASSET__background_spotlight_png);
		type.set ("background/spotlight.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("background/spotlight.psd", __ASSET__background_spotlight_psd);
		type.set ("background/spotlight.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("background/withrailing.psd", __ASSET__background_withrailing_psd);
		type.set ("background/withrailing.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
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
		className.set ("character/critical.png", __ASSET__character_critical_png);
		type.set ("character/critical.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("character/critical.pyxel", __ASSET__character_critical_pyxel);
		type.set ("character/critical.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("character/eggman.pyxel", __ASSET__character_eggman_pyxel);
		type.set ("character/eggman.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("character/eggman2.png", __ASSET__character_eggman2_png);
		type.set ("character/eggman2.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("character/eggman2.pyxel", __ASSET__character_eggman2_pyxel);
		type.set ("character/eggman2.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("character/goldbag.png", __ASSET__character_goldbag_png);
		type.set ("character/goldbag.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("character/knife.pyxel", __ASSET__character_knife_pyxel);
		type.set ("character/knife.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("character/name.pyxel", __ASSET__character_name_pyxel);
		type.set ("character/name.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("character/player - Copy.png", __ASSET__character_player___copy_png);
		type.set ("character/player - Copy.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("character/player.png", __ASSET__character_player_png);
		type.set ("character/player.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("character/player.png.pyxel", __ASSET__character_player_png_pyxel);
		type.set ("character/player.png.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("character/player.pyxel", __ASSET__character_player_pyxel);
		type.set ("character/player.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("character/playermold.png", __ASSET__character_playermold_png);
		type.set ("character/playermold.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("character/smoke.png", __ASSET__character_smoke_png);
		type.set ("character/smoke.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("character/star.png", __ASSET__character_star_png);
		type.set ("character/star.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("character/star.pyxel", __ASSET__character_star_pyxel);
		type.set ("character/star.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("shop/arrowspeed.png", __ASSET__shop_arrowspeed_png);
		type.set ("shop/arrowspeed.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("shop/backgroundbase.png", __ASSET__shop_backgroundbase_png);
		type.set ("shop/backgroundbase.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("shop/backgroundbase.psd", __ASSET__shop_backgroundbase_psd);
		type.set ("shop/backgroundbase.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("shop/backgroundRay.png", __ASSET__shop_backgroundray_png);
		type.set ("shop/backgroundRay.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("shop/button_outline.png", __ASSET__shop_button_outline_png);
		type.set ("shop/button_outline.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("shop/button_outline.pyxel", __ASSET__shop_button_outline_pyxel);
		type.set ("shop/button_outline.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("shop/result.psd", __ASSET__shop_result_psd);
		type.set ("shop/result.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("shop/shopbackground.png", __ASSET__shop_shopbackground_png);
		type.set ("shop/shopbackground.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("shop/shopbackground.psd", __ASSET__shop_shopbackground_psd);
		type.set ("shop/shopbackground.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("shop/shopcharacter.png", __ASSET__shop_shopcharacter_png);
		type.set ("shop/shopcharacter.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("shop/shopcharacter.pyxel", __ASSET__shop_shopcharacter_pyxel);
		type.set ("shop/shopcharacter.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("shop/shopchatbox.png", __ASSET__shop_shopchatbox_png);
		type.set ("shop/shopchatbox.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("shop/upgrade.png", __ASSET__shop_upgrade_png);
		type.set ("shop/upgrade.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("shop/upgrade.psd", __ASSET__shop_upgrade_psd);
		type.set ("shop/upgrade.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("shop/upgradegrid.png", __ASSET__shop_upgradegrid_png);
		type.set ("shop/upgradegrid.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("game/counter.psd", __ASSET__game_counter_psd);
		type.set ("game/counter.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("game/timecounter.png", __ASSET__game_timecounter_png);
		type.set ("game/timecounter.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("mainmenu/audience.png", __ASSET__mainmenu_audience_png);
		type.set ("mainmenu/audience.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("mainmenu/background.png", __ASSET__mainmenu_background_png);
		type.set ("mainmenu/background.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("mainmenu/background.psd", __ASSET__mainmenu_background_psd);
		type.set ("mainmenu/background.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("mainmenu/backgroundray.png", __ASSET__mainmenu_backgroundray_png);
		type.set ("mainmenu/backgroundray.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("mainmenu/backgroundray.psd", __ASSET__mainmenu_backgroundray_psd);
		type.set ("mainmenu/backgroundray.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("mainmenu/backgroundx.png", __ASSET__mainmenu_backgroundx_png);
		type.set ("mainmenu/backgroundx.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("mainmenu/border.png", __ASSET__mainmenu_border_png);
		type.set ("mainmenu/border.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("mainmenu/circus.png", __ASSET__mainmenu_circus_png);
		type.set ("mainmenu/circus.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("mainmenu/circus.pyxel", __ASSET__mainmenu_circus_pyxel);
		type.set ("mainmenu/circus.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("mainmenu/circusname.png", __ASSET__mainmenu_circusname_png);
		type.set ("mainmenu/circusname.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("mainmenu/E.png", __ASSET__mainmenu_e_png);
		type.set ("mainmenu/E.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("mainmenu/G.png", __ASSET__mainmenu_g_png);
		type.set ("mainmenu/G.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("mainmenu/gamerailing.png", __ASSET__mainmenu_gamerailing_png);
		type.set ("mainmenu/gamerailing.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("mainmenu/lighting.png", __ASSET__mainmenu_lighting_png);
		type.set ("mainmenu/lighting.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("mainmenu/M.png", __ASSET__mainmenu_m_png);
		type.set ("mainmenu/M.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("mainmenu/main.psd", __ASSET__mainmenu_main_psd);
		type.set ("mainmenu/main.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("mainmenu/N.png", __ASSET__mainmenu_n_png);
		type.set ("mainmenu/N.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("data/applechancedata.xml", __ASSET__data_applechancedata_xml);
		type.set ("data/applechancedata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("data/arrownumberdata.xml", __ASSET__data_arrownumberdata_xml);
		type.set ("data/arrownumberdata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("data/arrowspeeddata.xml", __ASSET__data_arrowspeeddata_xml);
		type.set ("data/arrowspeeddata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("data/bonusdata.xml", __ASSET__data_bonusdata_xml);
		type.set ("data/bonusdata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("data/gamedata.xml", __ASSET__data_gamedata_xml);
		type.set ("data/gamedata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("data/goldchancedata.xml", __ASSET__data_goldchancedata_xml);
		type.set ("data/goldchancedata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("data/timertimedata.xml", __ASSET__data_timertimedata_xml);
		type.set ("data/timertimedata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		
		
		#elseif html5
		
		addExternal("background/audience - Copy.png", "image", "background/audience - Copy.png");
		addExternal("background/audience.png", "image", "background/audience.png");
		addExternal("background/audience.pyxel", "binary", "background/audience.pyxel");
		addExternal("background/audiencerow1.png", "image", "background/audiencerow1.png");
		addExternal("background/background.png", "image", "background/background.png");
		addExternal("background/backgroundx.png", "image", "background/backgroundx.png");
		addExternal("background/backtent.png", "image", "background/backtent.png");
		addExternal("background/circus.pyxel", "binary", "background/circus.pyxel");
		addExternal("background/door copy.png", "image", "background/door copy.png");
		addExternal("background/door.png", "image", "background/door.png");
		addExternal("background/door.pyxel", "binary", "background/door.pyxel");
		addExternal("background/gamerailing.png", "image", "background/gamerailing.png");
		addExternal("background/gamerailingx.png", "image", "background/gamerailingx.png");
		addExternal("background/lighting.png", "image", "background/lighting.png");
		addExternal("background/lighting.psd", "binary", "background/lighting.psd");
		addExternal("background/middlecircle.psd", "binary", "background/middlecircle.psd");
		addExternal("background/preview.pyxel", "binary", "background/preview.pyxel");
		addExternal("background/railing.png", "image", "background/railing.png");
		addExternal("background/railing.pyxel", "binary", "background/railing.pyxel");
		addExternal("background/railingfull.png", "image", "background/railingfull.png");
		addExternal("background/railingfull2.png", "image", "background/railingfull2.png");
		addExternal("background/railingthin.pyxel", "binary", "background/railingthin.pyxel");
		addExternal("background/result.png", "image", "background/result.png");
		addExternal("background/ring.png", "image", "background/ring.png");
		addExternal("background/splashscreen.png", "image", "background/splashscreen.png");
		addExternal("background/spotlight.png", "image", "background/spotlight.png");
		addExternal("background/spotlight.psd", "binary", "background/spotlight.psd");
		addExternal("background/withrailing.psd", "binary", "background/withrailing.psd");
		addExternal("character/apple.png", "image", "character/apple.png");
		addExternal("character/arrow.png", "image", "character/arrow.png");
		addExternal("character/arrowXML.xml", "text", "character/arrowXML.xml");
		addExternal("character/bulleye.png", "image", "character/bulleye.png");
		addExternal("character/bulleye.pyxel", "binary", "character/bulleye.pyxel");
		addExternal("character/critical.png", "image", "character/critical.png");
		addExternal("character/critical.pyxel", "binary", "character/critical.pyxel");
		addExternal("character/eggman.pyxel", "binary", "character/eggman.pyxel");
		addExternal("character/eggman2.png", "image", "character/eggman2.png");
		addExternal("character/eggman2.pyxel", "binary", "character/eggman2.pyxel");
		addExternal("character/goldbag.png", "image", "character/goldbag.png");
		addExternal("character/knife.pyxel", "binary", "character/knife.pyxel");
		addExternal("character/name.pyxel", "binary", "character/name.pyxel");
		addExternal("character/player - Copy.png", "image", "character/player - Copy.png");
		addExternal("character/player.png", "image", "character/player.png");
		addExternal("character/player.png.pyxel", "binary", "character/player.png.pyxel");
		addExternal("character/player.pyxel", "binary", "character/player.pyxel");
		addExternal("character/playermold.png", "image", "character/playermold.png");
		addExternal("character/smoke.png", "image", "character/smoke.png");
		addExternal("character/star.png", "image", "character/star.png");
		addExternal("character/star.pyxel", "binary", "character/star.pyxel");
		addExternal("shop/arrowspeed.png", "image", "shop/arrowspeed.png");
		addExternal("shop/backgroundbase.png", "image", "shop/backgroundbase.png");
		addExternal("shop/backgroundbase.psd", "binary", "shop/backgroundbase.psd");
		addExternal("shop/backgroundRay.png", "image", "shop/backgroundRay.png");
		addExternal("shop/button_outline.png", "image", "shop/button_outline.png");
		addExternal("shop/button_outline.pyxel", "binary", "shop/button_outline.pyxel");
		addExternal("shop/result.psd", "binary", "shop/result.psd");
		addExternal("shop/shopbackground.png", "image", "shop/shopbackground.png");
		addExternal("shop/shopbackground.psd", "binary", "shop/shopbackground.psd");
		addExternal("shop/shopcharacter.png", "image", "shop/shopcharacter.png");
		addExternal("shop/shopcharacter.pyxel", "binary", "shop/shopcharacter.pyxel");
		addExternal("shop/shopchatbox.png", "image", "shop/shopchatbox.png");
		addExternal("shop/upgrade.png", "image", "shop/upgrade.png");
		addExternal("shop/upgrade.psd", "binary", "shop/upgrade.psd");
		addExternal("shop/upgradegrid.png", "image", "shop/upgradegrid.png");
		addExternal("game/counter.psd", "binary", "game/counter.psd");
		addExternal("game/timecounter.png", "image", "game/timecounter.png");
		addExternal("mainmenu/audience.png", "image", "mainmenu/audience.png");
		addExternal("mainmenu/background.png", "image", "mainmenu/background.png");
		addExternal("mainmenu/background.psd", "binary", "mainmenu/background.psd");
		addExternal("mainmenu/backgroundray.png", "image", "mainmenu/backgroundray.png");
		addExternal("mainmenu/backgroundray.psd", "binary", "mainmenu/backgroundray.psd");
		addExternal("mainmenu/backgroundx.png", "image", "mainmenu/backgroundx.png");
		addExternal("mainmenu/border.png", "image", "mainmenu/border.png");
		addExternal("mainmenu/circus.png", "image", "mainmenu/circus.png");
		addExternal("mainmenu/circus.pyxel", "binary", "mainmenu/circus.pyxel");
		addExternal("mainmenu/circusname.png", "image", "mainmenu/circusname.png");
		addExternal("mainmenu/E.png", "image", "mainmenu/E.png");
		addExternal("mainmenu/G.png", "image", "mainmenu/G.png");
		addExternal("mainmenu/gamerailing.png", "image", "mainmenu/gamerailing.png");
		addExternal("mainmenu/lighting.png", "image", "mainmenu/lighting.png");
		addExternal("mainmenu/M.png", "image", "mainmenu/M.png");
		addExternal("mainmenu/main.psd", "binary", "mainmenu/main.psd");
		addExternal("mainmenu/N.png", "image", "mainmenu/N.png");
		addExternal("data/applechancedata.xml", "text", "data/applechancedata.xml");
		addExternal("data/arrownumberdata.xml", "text", "data/arrownumberdata.xml");
		addExternal("data/arrowspeeddata.xml", "text", "data/arrowspeeddata.xml");
		addExternal("data/bonusdata.xml", "text", "data/bonusdata.xml");
		addExternal("data/gamedata.xml", "text", "data/gamedata.xml");
		addExternal("data/goldchancedata.xml", "text", "data/goldchancedata.xml");
		addExternal("data/timertimedata.xml", "text", "data/timertimedata.xml");
		
		
		#else
		
		#if (windows || mac || linux)
		
		var loadManifest = false;
		
		className.set ("background/audience - Copy.png", __ASSET__background_audience___copy_png);
		type.set ("background/audience - Copy.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/audience.png", __ASSET__background_audience_png);
		type.set ("background/audience.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/audience.pyxel", __ASSET__background_audience_pyxel);
		type.set ("background/audience.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("background/audiencerow1.png", __ASSET__background_audiencerow1_png);
		type.set ("background/audiencerow1.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/background.png", __ASSET__background_background_png);
		type.set ("background/background.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/backgroundx.png", __ASSET__background_backgroundx_png);
		type.set ("background/backgroundx.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/backtent.png", __ASSET__background_backtent_png);
		type.set ("background/backtent.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/circus.pyxel", __ASSET__background_circus_pyxel);
		type.set ("background/circus.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("background/door copy.png", __ASSET__background_door_copy_png);
		type.set ("background/door copy.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/door.png", __ASSET__background_door_png);
		type.set ("background/door.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/door.pyxel", __ASSET__background_door_pyxel);
		type.set ("background/door.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("background/gamerailing.png", __ASSET__background_gamerailing_png);
		type.set ("background/gamerailing.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/gamerailingx.png", __ASSET__background_gamerailingx_png);
		type.set ("background/gamerailingx.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/lighting.png", __ASSET__background_lighting_png);
		type.set ("background/lighting.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/lighting.psd", __ASSET__background_lighting_psd);
		type.set ("background/lighting.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("background/middlecircle.psd", __ASSET__background_middlecircle_psd);
		type.set ("background/middlecircle.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("background/preview.pyxel", __ASSET__background_preview_pyxel);
		type.set ("background/preview.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("background/railing.png", __ASSET__background_railing_png);
		type.set ("background/railing.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/railing.pyxel", __ASSET__background_railing_pyxel);
		type.set ("background/railing.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("background/railingfull.png", __ASSET__background_railingfull_png);
		type.set ("background/railingfull.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/railingfull2.png", __ASSET__background_railingfull2_png);
		type.set ("background/railingfull2.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/railingthin.pyxel", __ASSET__background_railingthin_pyxel);
		type.set ("background/railingthin.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("background/result.png", __ASSET__background_result_png);
		type.set ("background/result.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/ring.png", __ASSET__background_ring_png);
		type.set ("background/ring.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/splashscreen.png", __ASSET__background_splashscreen_png);
		type.set ("background/splashscreen.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/spotlight.png", __ASSET__background_spotlight_png);
		type.set ("background/spotlight.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("background/spotlight.psd", __ASSET__background_spotlight_psd);
		type.set ("background/spotlight.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("background/withrailing.psd", __ASSET__background_withrailing_psd);
		type.set ("background/withrailing.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		
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
		
		className.set ("character/critical.png", __ASSET__character_critical_png);
		type.set ("character/critical.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("character/critical.pyxel", __ASSET__character_critical_pyxel);
		type.set ("character/critical.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("character/eggman.pyxel", __ASSET__character_eggman_pyxel);
		type.set ("character/eggman.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("character/eggman2.png", __ASSET__character_eggman2_png);
		type.set ("character/eggman2.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("character/eggman2.pyxel", __ASSET__character_eggman2_pyxel);
		type.set ("character/eggman2.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("character/goldbag.png", __ASSET__character_goldbag_png);
		type.set ("character/goldbag.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("character/knife.pyxel", __ASSET__character_knife_pyxel);
		type.set ("character/knife.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("character/name.pyxel", __ASSET__character_name_pyxel);
		type.set ("character/name.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("character/player - Copy.png", __ASSET__character_player___copy_png);
		type.set ("character/player - Copy.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("character/player.png", __ASSET__character_player_png);
		type.set ("character/player.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("character/player.png.pyxel", __ASSET__character_player_png_pyxel);
		type.set ("character/player.png.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("character/player.pyxel", __ASSET__character_player_pyxel);
		type.set ("character/player.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("character/playermold.png", __ASSET__character_playermold_png);
		type.set ("character/playermold.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("character/smoke.png", __ASSET__character_smoke_png);
		type.set ("character/smoke.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("character/star.png", __ASSET__character_star_png);
		type.set ("character/star.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("character/star.pyxel", __ASSET__character_star_pyxel);
		type.set ("character/star.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("shop/arrowspeed.png", __ASSET__shop_arrowspeed_png);
		type.set ("shop/arrowspeed.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("shop/backgroundbase.png", __ASSET__shop_backgroundbase_png);
		type.set ("shop/backgroundbase.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("shop/backgroundbase.psd", __ASSET__shop_backgroundbase_psd);
		type.set ("shop/backgroundbase.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("shop/backgroundRay.png", __ASSET__shop_backgroundray_png);
		type.set ("shop/backgroundRay.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("shop/button_outline.png", __ASSET__shop_button_outline_png);
		type.set ("shop/button_outline.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("shop/button_outline.pyxel", __ASSET__shop_button_outline_pyxel);
		type.set ("shop/button_outline.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("shop/result.psd", __ASSET__shop_result_psd);
		type.set ("shop/result.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("shop/shopbackground.png", __ASSET__shop_shopbackground_png);
		type.set ("shop/shopbackground.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("shop/shopbackground.psd", __ASSET__shop_shopbackground_psd);
		type.set ("shop/shopbackground.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("shop/shopcharacter.png", __ASSET__shop_shopcharacter_png);
		type.set ("shop/shopcharacter.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("shop/shopcharacter.pyxel", __ASSET__shop_shopcharacter_pyxel);
		type.set ("shop/shopcharacter.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("shop/shopchatbox.png", __ASSET__shop_shopchatbox_png);
		type.set ("shop/shopchatbox.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("shop/upgrade.png", __ASSET__shop_upgrade_png);
		type.set ("shop/upgrade.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("shop/upgrade.psd", __ASSET__shop_upgrade_psd);
		type.set ("shop/upgrade.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("shop/upgradegrid.png", __ASSET__shop_upgradegrid_png);
		type.set ("shop/upgradegrid.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("game/counter.psd", __ASSET__game_counter_psd);
		type.set ("game/counter.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("game/timecounter.png", __ASSET__game_timecounter_png);
		type.set ("game/timecounter.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("mainmenu/audience.png", __ASSET__mainmenu_audience_png);
		type.set ("mainmenu/audience.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("mainmenu/background.png", __ASSET__mainmenu_background_png);
		type.set ("mainmenu/background.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("mainmenu/background.psd", __ASSET__mainmenu_background_psd);
		type.set ("mainmenu/background.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("mainmenu/backgroundray.png", __ASSET__mainmenu_backgroundray_png);
		type.set ("mainmenu/backgroundray.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("mainmenu/backgroundray.psd", __ASSET__mainmenu_backgroundray_psd);
		type.set ("mainmenu/backgroundray.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("mainmenu/backgroundx.png", __ASSET__mainmenu_backgroundx_png);
		type.set ("mainmenu/backgroundx.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("mainmenu/border.png", __ASSET__mainmenu_border_png);
		type.set ("mainmenu/border.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("mainmenu/circus.png", __ASSET__mainmenu_circus_png);
		type.set ("mainmenu/circus.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("mainmenu/circus.pyxel", __ASSET__mainmenu_circus_pyxel);
		type.set ("mainmenu/circus.pyxel", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("mainmenu/circusname.png", __ASSET__mainmenu_circusname_png);
		type.set ("mainmenu/circusname.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("mainmenu/E.png", __ASSET__mainmenu_e_png);
		type.set ("mainmenu/E.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("mainmenu/G.png", __ASSET__mainmenu_g_png);
		type.set ("mainmenu/G.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("mainmenu/gamerailing.png", __ASSET__mainmenu_gamerailing_png);
		type.set ("mainmenu/gamerailing.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("mainmenu/lighting.png", __ASSET__mainmenu_lighting_png);
		type.set ("mainmenu/lighting.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("mainmenu/M.png", __ASSET__mainmenu_m_png);
		type.set ("mainmenu/M.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("mainmenu/main.psd", __ASSET__mainmenu_main_psd);
		type.set ("mainmenu/main.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
		
		className.set ("mainmenu/N.png", __ASSET__mainmenu_n_png);
		type.set ("mainmenu/N.png", Reflect.field (AssetType, "image".toUpperCase ()));
		
		className.set ("data/applechancedata.xml", __ASSET__data_applechancedata_xml);
		type.set ("data/applechancedata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		
		className.set ("data/arrownumberdata.xml", __ASSET__data_arrownumberdata_xml);
		type.set ("data/arrownumberdata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		
		className.set ("data/arrowspeeddata.xml", __ASSET__data_arrowspeeddata_xml);
		type.set ("data/arrowspeeddata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		
		className.set ("data/bonusdata.xml", __ASSET__data_bonusdata_xml);
		type.set ("data/bonusdata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		
		className.set ("data/gamedata.xml", __ASSET__data_gamedata_xml);
		type.set ("data/gamedata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		
		className.set ("data/goldchancedata.xml", __ASSET__data_goldchancedata_xml);
		type.set ("data/goldchancedata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		
		className.set ("data/timertimedata.xml", __ASSET__data_timertimedata_xml);
		type.set ("data/timertimedata.xml", Reflect.field (AssetType, "text".toUpperCase ()));
		
		
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

@:keep class __ASSET__background_audience___copy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_audience_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_audience_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__background_audiencerow1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_background_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_backgroundx_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_backtent_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_circus_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__background_door_copy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_door_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_door_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__background_gamerailing_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_gamerailingx_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_lighting_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_lighting_psd extends flash.utils.ByteArray { }
@:keep class __ASSET__background_middlecircle_psd extends flash.utils.ByteArray { }
@:keep class __ASSET__background_preview_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__background_railing_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_railing_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__background_railingfull_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_railingfull2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_railingthin_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__background_result_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_ring_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_splashscreen_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_spotlight_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__background_spotlight_psd extends flash.utils.ByteArray { }
@:keep class __ASSET__background_withrailing_psd extends flash.utils.ByteArray { }
@:keep class __ASSET__character_apple_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__character_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__character_arrowxml_xml extends flash.utils.ByteArray { }
@:keep class __ASSET__character_bulleye_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__character_bulleye_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__character_critical_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__character_critical_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__character_eggman_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__character_eggman2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__character_eggman2_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__character_goldbag_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__character_knife_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__character_name_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__character_player___copy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__character_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__character_player_png_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__character_player_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__character_playermold_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__character_smoke_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__character_star_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__character_star_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__shop_arrowspeed_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__shop_backgroundbase_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__shop_backgroundbase_psd extends flash.utils.ByteArray { }
@:keep class __ASSET__shop_backgroundray_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__shop_button_outline_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__shop_button_outline_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__shop_result_psd extends flash.utils.ByteArray { }
@:keep class __ASSET__shop_shopbackground_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__shop_shopbackground_psd extends flash.utils.ByteArray { }
@:keep class __ASSET__shop_shopcharacter_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__shop_shopcharacter_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__shop_shopchatbox_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__shop_upgrade_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__shop_upgrade_psd extends flash.utils.ByteArray { }
@:keep class __ASSET__shop_upgradegrid_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__game_counter_psd extends flash.utils.ByteArray { }
@:keep class __ASSET__game_timecounter_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__mainmenu_audience_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__mainmenu_background_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__mainmenu_background_psd extends flash.utils.ByteArray { }
@:keep class __ASSET__mainmenu_backgroundray_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__mainmenu_backgroundray_psd extends flash.utils.ByteArray { }
@:keep class __ASSET__mainmenu_backgroundx_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__mainmenu_border_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__mainmenu_circus_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__mainmenu_circus_pyxel extends flash.utils.ByteArray { }
@:keep class __ASSET__mainmenu_circusname_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__mainmenu_e_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__mainmenu_g_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__mainmenu_gamerailing_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__mainmenu_lighting_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__mainmenu_m_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__mainmenu_main_psd extends flash.utils.ByteArray { }
@:keep class __ASSET__mainmenu_n_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__data_applechancedata_xml extends flash.utils.ByteArray { }
@:keep class __ASSET__data_arrownumberdata_xml extends flash.utils.ByteArray { }
@:keep class __ASSET__data_arrowspeeddata_xml extends flash.utils.ByteArray { }
@:keep class __ASSET__data_bonusdata_xml extends flash.utils.ByteArray { }
@:keep class __ASSET__data_gamedata_xml extends flash.utils.ByteArray { }
@:keep class __ASSET__data_goldchancedata_xml extends flash.utils.ByteArray { }
@:keep class __ASSET__data_timertimedata_xml extends flash.utils.ByteArray { }


#elseif html5





























































































#elseif (windows || mac || linux)


@:bitmap("assets/texture/background/audience - Copy.png") class __ASSET__background_audience___copy_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/background/audience.png") class __ASSET__background_audience_png extends flash.display.BitmapData {}
@:file("assets/texture/background/audience.pyxel") class __ASSET__background_audience_pyxel extends flash.utils.ByteArray {}
@:bitmap("assets/texture/background/audiencerow1.png") class __ASSET__background_audiencerow1_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/background/background.png") class __ASSET__background_background_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/background/backgroundx.png") class __ASSET__background_backgroundx_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/background/backtent.png") class __ASSET__background_backtent_png extends flash.display.BitmapData {}
@:file("assets/texture/background/circus.pyxel") class __ASSET__background_circus_pyxel extends flash.utils.ByteArray {}
@:bitmap("assets/texture/background/door copy.png") class __ASSET__background_door_copy_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/background/door.png") class __ASSET__background_door_png extends flash.display.BitmapData {}
@:file("assets/texture/background/door.pyxel") class __ASSET__background_door_pyxel extends flash.utils.ByteArray {}
@:bitmap("assets/texture/background/gamerailing.png") class __ASSET__background_gamerailing_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/background/gamerailingx.png") class __ASSET__background_gamerailingx_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/background/lighting.png") class __ASSET__background_lighting_png extends flash.display.BitmapData {}
@:file("assets/texture/background/lighting.psd") class __ASSET__background_lighting_psd extends flash.utils.ByteArray {}
@:file("assets/texture/background/middlecircle.psd") class __ASSET__background_middlecircle_psd extends flash.utils.ByteArray {}
@:file("assets/texture/background/preview.pyxel") class __ASSET__background_preview_pyxel extends flash.utils.ByteArray {}
@:bitmap("assets/texture/background/railing.png") class __ASSET__background_railing_png extends flash.display.BitmapData {}
@:file("assets/texture/background/railing.pyxel") class __ASSET__background_railing_pyxel extends flash.utils.ByteArray {}
@:bitmap("assets/texture/background/railingfull.png") class __ASSET__background_railingfull_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/background/railingfull2.png") class __ASSET__background_railingfull2_png extends flash.display.BitmapData {}
@:file("assets/texture/background/railingthin.pyxel") class __ASSET__background_railingthin_pyxel extends flash.utils.ByteArray {}
@:bitmap("assets/texture/background/result.png") class __ASSET__background_result_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/background/ring.png") class __ASSET__background_ring_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/background/splashscreen.png") class __ASSET__background_splashscreen_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/background/spotlight.png") class __ASSET__background_spotlight_png extends flash.display.BitmapData {}
@:file("assets/texture/background/spotlight.psd") class __ASSET__background_spotlight_psd extends flash.utils.ByteArray {}
@:file("assets/texture/background/withrailing.psd") class __ASSET__background_withrailing_psd extends flash.utils.ByteArray {}
@:bitmap("assets/texture/character/apple.png") class __ASSET__character_apple_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/character/arrow.png") class __ASSET__character_arrow_png extends flash.display.BitmapData {}
@:file("assets/texture/character/arrowXML.xml") class __ASSET__character_arrowxml_xml extends flash.utils.ByteArray {}
@:bitmap("assets/texture/character/bulleye.png") class __ASSET__character_bulleye_png extends flash.display.BitmapData {}
@:file("assets/texture/character/bulleye.pyxel") class __ASSET__character_bulleye_pyxel extends flash.utils.ByteArray {}
@:bitmap("assets/texture/character/critical.png") class __ASSET__character_critical_png extends flash.display.BitmapData {}
@:file("assets/texture/character/critical.pyxel") class __ASSET__character_critical_pyxel extends flash.utils.ByteArray {}
@:file("assets/texture/character/eggman.pyxel") class __ASSET__character_eggman_pyxel extends flash.utils.ByteArray {}
@:bitmap("assets/texture/character/eggman2.png") class __ASSET__character_eggman2_png extends flash.display.BitmapData {}
@:file("assets/texture/character/eggman2.pyxel") class __ASSET__character_eggman2_pyxel extends flash.utils.ByteArray {}
@:bitmap("assets/texture/character/goldbag.png") class __ASSET__character_goldbag_png extends flash.display.BitmapData {}
@:file("assets/texture/character/knife.pyxel") class __ASSET__character_knife_pyxel extends flash.utils.ByteArray {}
@:file("assets/texture/character/name.pyxel") class __ASSET__character_name_pyxel extends flash.utils.ByteArray {}
@:bitmap("assets/texture/character/player - Copy.png") class __ASSET__character_player___copy_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/character/player.png") class __ASSET__character_player_png extends flash.display.BitmapData {}
@:file("assets/texture/character/player.png.pyxel") class __ASSET__character_player_png_pyxel extends flash.utils.ByteArray {}
@:file("assets/texture/character/player.pyxel") class __ASSET__character_player_pyxel extends flash.utils.ByteArray {}
@:bitmap("assets/texture/character/playermold.png") class __ASSET__character_playermold_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/character/smoke.png") class __ASSET__character_smoke_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/character/star.png") class __ASSET__character_star_png extends flash.display.BitmapData {}
@:file("assets/texture/character/star.pyxel") class __ASSET__character_star_pyxel extends flash.utils.ByteArray {}
@:bitmap("assets/texture/shop/arrowspeed.png") class __ASSET__shop_arrowspeed_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/shop/backgroundbase.png") class __ASSET__shop_backgroundbase_png extends flash.display.BitmapData {}
@:file("assets/texture/shop/backgroundbase.psd") class __ASSET__shop_backgroundbase_psd extends flash.utils.ByteArray {}
@:bitmap("assets/texture/shop/backgroundRay.png") class __ASSET__shop_backgroundray_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/shop/button_outline.png") class __ASSET__shop_button_outline_png extends flash.display.BitmapData {}
@:file("assets/texture/shop/button_outline.pyxel") class __ASSET__shop_button_outline_pyxel extends flash.utils.ByteArray {}
@:file("assets/texture/shop/result.psd") class __ASSET__shop_result_psd extends flash.utils.ByteArray {}
@:bitmap("assets/texture/shop/shopbackground.png") class __ASSET__shop_shopbackground_png extends flash.display.BitmapData {}
@:file("assets/texture/shop/shopbackground.psd") class __ASSET__shop_shopbackground_psd extends flash.utils.ByteArray {}
@:bitmap("assets/texture/shop/shopcharacter.png") class __ASSET__shop_shopcharacter_png extends flash.display.BitmapData {}
@:file("assets/texture/shop/shopcharacter.pyxel") class __ASSET__shop_shopcharacter_pyxel extends flash.utils.ByteArray {}
@:bitmap("assets/texture/shop/shopchatbox.png") class __ASSET__shop_shopchatbox_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/shop/upgrade.png") class __ASSET__shop_upgrade_png extends flash.display.BitmapData {}
@:file("assets/texture/shop/upgrade.psd") class __ASSET__shop_upgrade_psd extends flash.utils.ByteArray {}
@:bitmap("assets/texture/shop/upgradegrid.png") class __ASSET__shop_upgradegrid_png extends flash.display.BitmapData {}
@:file("assets/texture/game/counter.psd") class __ASSET__game_counter_psd extends flash.utils.ByteArray {}
@:bitmap("assets/texture/game/timecounter.png") class __ASSET__game_timecounter_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/mainmenu/audience.png") class __ASSET__mainmenu_audience_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/mainmenu/background.png") class __ASSET__mainmenu_background_png extends flash.display.BitmapData {}
@:file("assets/texture/mainmenu/background.psd") class __ASSET__mainmenu_background_psd extends flash.utils.ByteArray {}
@:bitmap("assets/texture/mainmenu/backgroundray.png") class __ASSET__mainmenu_backgroundray_png extends flash.display.BitmapData {}
@:file("assets/texture/mainmenu/backgroundray.psd") class __ASSET__mainmenu_backgroundray_psd extends flash.utils.ByteArray {}
@:bitmap("assets/texture/mainmenu/backgroundx.png") class __ASSET__mainmenu_backgroundx_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/mainmenu/border.png") class __ASSET__mainmenu_border_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/mainmenu/circus.png") class __ASSET__mainmenu_circus_png extends flash.display.BitmapData {}
@:file("assets/texture/mainmenu/circus.pyxel") class __ASSET__mainmenu_circus_pyxel extends flash.utils.ByteArray {}
@:bitmap("assets/texture/mainmenu/circusname.png") class __ASSET__mainmenu_circusname_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/mainmenu/E.png") class __ASSET__mainmenu_e_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/mainmenu/G.png") class __ASSET__mainmenu_g_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/mainmenu/gamerailing.png") class __ASSET__mainmenu_gamerailing_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/mainmenu/lighting.png") class __ASSET__mainmenu_lighting_png extends flash.display.BitmapData {}
@:bitmap("assets/texture/mainmenu/M.png") class __ASSET__mainmenu_m_png extends flash.display.BitmapData {}
@:file("assets/texture/mainmenu/main.psd") class __ASSET__mainmenu_main_psd extends flash.utils.ByteArray {}
@:bitmap("assets/texture/mainmenu/N.png") class __ASSET__mainmenu_n_png extends flash.display.BitmapData {}
@:file("assets/data/applechancedata.xml") class __ASSET__data_applechancedata_xml extends flash.utils.ByteArray {}
@:file("assets/data/arrownumberdata.xml") class __ASSET__data_arrownumberdata_xml extends flash.utils.ByteArray {}
@:file("assets/data/arrowspeeddata.xml") class __ASSET__data_arrowspeeddata_xml extends flash.utils.ByteArray {}
@:file("assets/data/bonusdata.xml") class __ASSET__data_bonusdata_xml extends flash.utils.ByteArray {}
@:file("assets/data/gamedata.xml") class __ASSET__data_gamedata_xml extends flash.utils.ByteArray {}
@:file("assets/data/goldchancedata.xml") class __ASSET__data_goldchancedata_xml extends flash.utils.ByteArray {}
@:file("assets/data/timertimedata.xml") class __ASSET__data_timertimedata_xml extends flash.utils.ByteArray {}


#end
