
import luxe.GameConfig;
import luxe.Input;
import luxe.Color;
import luxe.Vector;

import luxe.Parcel;
import luxe.ParcelProgress;

import luxe.Sprite;
import phoenix.Texture;
import luxe.components.sprite.SpriteAnimation;

class Main extends luxe.Game {
    var scenes:Iterator<String>;

    override function config(config:GameConfig) {

        config.window.title = 'A Small World';
        config.window.width = 800;
        config.window.height = 600;
        config.window.fullscreen = false;

        return config;

    } //config

    override function ready() {
        connect_input();
        scenes = ["studio", "office"].iterator();
        var sketch = new Sketch("studio");
    } //ready

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

    } //update

} //Main
