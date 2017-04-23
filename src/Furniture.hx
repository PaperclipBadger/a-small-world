
import luxe.Vector;
import luxe.Sprite;
import luxe.components.sprite.SpriteAnimation;

import phoenix.Texture;

import types.SimpleVector;
import types.SpriteOptions;

typedef FurnitureOptions = SpriteOptions;

class Furniture extends Sprite {
    var anim:SpriteAnimation;

    override public function new(options:FurnitureOptions) {
        var texture = Luxe.resources.texture(options.texture_id);
        texture.filter_min = texture.filter_mag = FilterType.nearest;

        var size = if (options.size != null) {
            new Vector(options.size.x, options.size.y);
        } else {
            new Vector(texture.width, texture.height);
        }

        var position = if (options.position != null) {
            new Vector(options.position.x, options.position.y);
        } else {
            new Vector(texture.width, texture.height);
        }

        super({
            name: options.name,
            texture: texture,
            size: Utils.pix2screen(size),
            pos: Utils.pix2screen(position),
            depth: options.depth,
            centered: options.centered,
        });

        if (options.animation_id != null) {
            anim = add(new SpriteAnimation({ name: 'anim' }));
            var anim_data = Luxe.resources.json(options.animation_id);
            anim.add_from_json_object(anim_data.asset.json);
            anim.animation = 'idle';
            anim.play();
        }
    }
}
