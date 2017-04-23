package;

import Luxe;
import luxe.Component;

import Actor;

typedef InteractEvent = {
    var source:Actor;
}

class PlayerInteract extends Component {
    var actor:Actor;
    override function onadded() {
        // called when the component is added to the entity
        actor = cast entity;
    }
    override function update(dt:Float) {
        // called every frame. dt is the time delta in seconds since the last frame.
        if (Luxe.input.inputpressed('interact')) {
            Luxe.events.fire('player.interact', {source: actor});
        }
    }
}
