package;

import luxe.Component;
import luxe.Vector;

import PlayerInteract;
import Utils;

class Fish extends Component {
    var prop:Prop;
    var listener_id:String;

    override function onadded() {
        prop = cast entity;
        listener_id = Luxe.events.listen('player.interact', on_interact);
    }

    function on_interact(event:InteractEvent) {
        if (Vector.Subtract(event.source.pos, prop.pos).length < event.source.size.length) {
            if (prop.anim != null) {
                prop.anim.animation = 'empty';
            }
            event.source.give_fish();
            Luxe.events.unlisten(listener_id);
        }
    }
}
