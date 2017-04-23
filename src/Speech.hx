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
    override public function new(_name:String, text:String, position:Vector, depth:Float) {
        super({ name: _name });

        var size = Utils.pix2screen(new Vector(40, 30));
        var bounds = new Rectangle(position.x, position.y, size.x, size.y);
        (new luxe.Visual({
            name: '$name/text',
            depth: depth + 0.01,
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
            depth: depth,
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

        var position = Utils.pix2screen(new Vector(26, -24));
        bubble = new SpeechBubble('$name/bubble', text, position, sprite.depth);
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
