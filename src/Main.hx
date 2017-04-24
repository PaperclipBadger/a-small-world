
import luxe.GameConfig;
import luxe.Input;
import luxe.Color;
import luxe.Vector;

import luxe.Parcel;
import luxe.ParcelProgress;

import luxe.Sprite;
import phoenix.Texture;
import luxe.components.sprite.SpriteAnimation;

import StatusScreen;
import Sketch;
import Utils;

class Main extends luxe.Game {
    public static var ALL_SKETCHES:Array<String> = ["studio0", "studio1"];

    var splash:Sprite;
    var credits:Sprite;
    var status:StatusScreen;

    var sketches:Iterator<String>;
    var sketch:Sketch;

    var time:Float = 0;
    var target:Float = 0;
    var score:Int = 0;

    override function config(config:GameConfig) {

        config.window.title = 'A Small World';
        config.window.width = 800;
        config.window.height = 600;
        config.window.fullscreen = false;

        // load cheeky textures for splash and credits
        config.preload.textures.push({ id: 'assets/splash.png' });
        config.preload.textures.push({ id: 'assets/credits.png' });

        return config;

    } //config

    override function ready() {
        connect_input();
        Luxe.events.listen('sketch.end', on_sketch_end);
        Luxe.events.listen('sketch.start', on_sketch_start);
        sketches = ALL_SKETCHES.iterator();
        splash = splash_sprite('splash', 'assets/splash.png');

    } //ready

    function splash_sprite(name:String, texture_id:String):Sprite {
        var texture = Luxe.resources.texture(texture_id);
        texture.filter_min = texture.filter_mag = FilterType.nearest;

        var size = new Vector(texture.width, texture.height);

        return new Sprite({
            name: name,
            texture: texture,
            size: Utils.pix2screen(size),
            depth: 2.0,
            centered: false,
        });
    }

    function connect_input() {
        Luxe.input.bind_key('left', Key.left);
        Luxe.input.bind_key('left', Key.key_a);
        Luxe.input.bind_key('right', Key.right);
        Luxe.input.bind_key('right', Key.key_d);
        Luxe.input.bind_key('up', Key.up);
        Luxe.input.bind_key('up', Key.key_w);
        Luxe.input.bind_key('down', Key.down);
        Luxe.input.bind_key('down', Key.key_s);
        Luxe.input.bind_key('interact', Key.space);
        Luxe.input.bind_key('interact', Key.key_e);
    }

    override function onkeyup(event:KeyEvent) {

        if(event.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(delta:Float) {

        if(splash != null && Luxe.input.inputpressed('interact')) {
            splash.destroy();
            splash = null;
            sketch = new Sketch(sketches.next());
        }
        if(status != null && Luxe.input.inputpressed('interact')) {
            status.destroy();
            status = null;
            if (sketches.hasNext()) {
                sketch = new Sketch(sketches.next());
            } else {
                credits = splash_sprite('credits', 'assets/credits.png');
            }
        }
    } //update

    function on_sketch_start(event:StartEvent) {
        time = Date.now().getTime() / 1000;
        target = event.target_time;
    }

    function on_sketch_end(_) {
        sketch.destroy();
        sketch = null;
        trace('$time, $target');
        var timedelta:Int = Math.floor((Date.now().getTime() / 1000) - time - target);
        var scoredelta:Int = switch (timedelta) {
            case 0: 10;
            case 1: 5;
            case 2: 2;
            case 3: 1;
            default: 0;
        }
        score += scoredelta;
        status = new StatusScreen('status', score, scoredelta);
    }

} //Main
