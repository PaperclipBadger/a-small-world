package;

import Luxe;
import luxe.Component;

import Actor;

typedef SlapEvent = {
    var source:Actor;
}

class PlayerSlap extends Component {
    var actor:Actor;
    var listener_id:String;

    override function onadded() {
        // called when the component is added to the entity
        actor = cast entity;
        listener_id = actor.events.listen('player.animation.slap_finished', on_slap_finish);
    }

    override function onremoved() {
        actor.events.unlisten(listener_id);
    }

    override function update(dt:Float) {
        // called every frame. dt is the time delta in seconds since the last frame.
        if (Luxe.input.inputpressed('interact')) {
            actor.anim.animation = 'slap';
            Luxe.events.fire('player.slap', {source: actor});
        }
    }

    function on_slap_finish(_) {
        trace('pork');
        actor.set_idle();
    }
}
