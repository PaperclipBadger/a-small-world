
import Luxe;
import luxe.Component;

import Main;

class PlayerMovement extends Component {
    var actor:Actor;
    var move_speed:Float = 0;
    var max_left:Float = 0;
    var max_right:Float = 0;

    override function onadded() {
        // called when the component is added to the entity
        actor = cast entity;
        max_left = (actor.size.x / 2);
        max_right = Luxe.screen.w - max_left;
        move_speed = actor.size.x * 1.5;
    }

    override function update(dt:Float) {
        // called every frame. dt is the time delta in seconds since the last frame.
        if (actor == null) return;

        var moving = if (Luxe.input.inputdown('left')) {
            actor.pos.x -= move_speed * dt;
            actor.flipx = true;
            true;
        } else if (Luxe.input.inputdown('right')) {
            actor.pos.x += move_speed * dt;
            actor.flipx = false;
            true;
        } else false;

        //limit to the screen edges
        if(actor.pos.x >= max_right) {
            actor.pos.x = max_right;
            moving = false;
        }
        if(actor.pos.x <= max_left) {
            actor.pos.x = max_left;
            moving = false;
        }

        if (moving) {
            /*
            if (anim.animation != 'walk') {
                anim.animation = 'walk';
            }
            */
        } else {
            if (actor.anim.animation != 'idle') {
                actor.anim.animation = 'idle';
            }
        }

    }

    override function onreset() {
        // called when the scene starts or restarts

    }
}
