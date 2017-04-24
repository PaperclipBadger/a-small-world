package;

import Luxe;
import luxe.Sprite;
import luxe.Rectangle;
import luxe.Visual;
import luxe.Vector;
import phoenix.geometry.TextGeometry;
import phoenix.BitmapFont;

class StatusScreen extends Sprite {
    override public function new(_name:String, score:Int, scoredelta: Int) {
        super({ name: _name, centered: false, pos: new Vector(0, 0) });

        var timing:String = switch (scoredelta) {
            case 10: 'SPOT ON';
            case 5: 'CLOSE CALL';
            case 2: 'IRREGULAR';
            case 1: 'BAD';
            default: 'WAY OFF';
        }

        var bounds = new Rectangle(0, 0, Luxe.screen.w, Luxe.screen.h);
        (new luxe.Visual({
            name: '$name/text',
            depth: 1.01,
            color: new luxe.Color(1, 1, 1, 1),
            geometry: Luxe.draw.text({
                bounds: bounds,
                bounds_wrap: true,
                align: TextAlign.center,
                align_vertical: TextAlign.center,
                text: 'score is: $score\ncomedic timing: $timing',
                point_size: 30
            })
        })).parent = this;

        (new luxe.Visual({
            name: '$name/bounds',
            depth: 1.0,
            color: new luxe.Color(0, 0, 0, 1),
            geometry: Luxe.draw.box({
                x: bounds.x,
                y: bounds.y,
                h: bounds.h,
                w: bounds.w
            })
        })).parent = this;
    }
}
