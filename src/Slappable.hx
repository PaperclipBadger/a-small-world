
package;

import Luxe;
import luxe.Component;
import luxe.Vector;

import Actor;
import PlayerSlap;

class Slappable extends Component {
    var actor:Actor;
    var slap_listener_id:String;
    var anim_listener_id:String;

    override function onadded() {
        // called when the component is added to the entity
        actor = cast entity;
        slap_listener_id = Luxe.events.listen('player.slap', on_slap);
        anim_listener_id = actor.events.listen('npc.animation.recoil_finished', on_recoil_finish);
    }

    override function onremoved() {
        Luxe.events.unlisten(slap_listener_id);
        actor.events.unlisten(anim_listener_id);
    }

    function on_slap(event:SlapEvent) {
        // called every frame. dt is the time delta in seconds since the last frame.
        if (Vector.Subtract(event.source.pos, actor.pos).length < event.source.size.length) {
            actor.anim.animation = 'recoil';
        }
    }

    function on_recoil_finish(_) {
        actor.set_idle();
    }
}
