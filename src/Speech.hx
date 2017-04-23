package;

import luxe.Color;
import luxe.Rectangle;
import luxe.Visual;
import luxe.Vector;

import phoenix.BitmapFont;

import luxe.Sprite;
import luxe.Component;
import Luxe;

import Utils;

class SpeechBubble extends Sprite {
    override public function new(_name:String, text:String, position:Vector) {
        super({ name: _name });

        var size = Utils.pix2screen(new Vector(35, 20));
        var bounds = new Rectangle(position.x, position.y, size.x, size.y);
        (new luxe.Visual({
            name: '$name/text',
            depth: 1.01,
            color: new luxe.Color(0, 0, 0, 1),
            geometry: Luxe.draw.text({
               bounds: bounds,
               bounds_wrap: true,
               align: TextAlign.center,
               text: text,
               point_size: 16
            })
        })).parent = this;
        (new luxe.Visual({
            name: '$name/bounds',
            depth: 1.0,
            color: new luxe.Color(1, 1, 1, 1),
            geometry: Luxe.draw.box({
                x: bounds.x,
                y: bounds.y,
                h: bounds.h,
                w: bounds.w
            })
        })).parent = this;
    }
}

class Speech extends Component {
    var sprite:Sprite;
    var bubble:SpeechBubble;

    override function onadded() {
        // called when the component is added to the entity
        sprite = cast entity;
    }

    public function say(text:String, duration:Float) {
        if (sprite == null) return;

        var position = Utils.pix2screen(new Vector(46, -5));
        bubble = new SpeechBubble('$name/bubble', text, position);
        bubble.parent = sprite;

        var timer = Luxe.timer.schedule(duration, function() {
           bubble.destroy(true);
        });
    }

    override function update(dt:Float) {
        // called every frame. dt is the time delta in seconds since the last frame.
    }

    override function onreset() {
        // called when the scene starts or restarts

    }
}
