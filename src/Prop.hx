
import luxe.Sprite;
import luxe.options.SpriteOptions;
import luxe.resource.JSONResource;

class Prop extends Sprite {
    var anim:SpriteAnimation;
    override function new(sprite:SpriteOptions, ?anim_data:JSONResource) {
        super.new(sprite);
        if (data.anim != null) {
            anim = add(new SpriteAnimation({ name: 'anim' }));
            anim.add_from_json_object(anim_data.asset.json);
            anim.animation = 'idle';
            anim.play();
        }
    }
}
