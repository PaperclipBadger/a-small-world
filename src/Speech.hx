package;

import luxe.Color;
import luxe.Component;
import luxe.Sprite;
import luxe.Vector;
import luxe.Visual;
import luxe.Rectangle;
import Luxe;

class SpeechBubble extends Sprite {
    override public function new(_name:String, text:String, depth:Float) {
        super({ name: _name });

        var bounds = new Rectangle(0, 0, 200, 20);
        (new luxe.Visual({
            name: '$name/text',
            depth: depth + 0.01,
            color: new luxe.Color(0, 0, 0, 1),
            geometry: Luxe.draw.text({
               bounds: bounds,
               bounds_wrap: true,
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

    public function say(string:String) {
        if (sprite == null) return;

        bubble = new SpeechBubble('$name/bubble', string, sprite.depth);
    }

    override function update(dt:Float) {
        // called every frame. dt is the time delta in seconds since the last frame.
        var position = new Vector(sprite.pos.x, sprite.pos.y - (sprite.size.y / 2) + 10);
        bubble.pos = position;
    }

    override function onreset() {
        // called when the scene starts or restarts

    }
}
