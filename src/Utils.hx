import Luxe;
import luxe.Vector;

import Main;

class Utils {
    public static var pixdims = new Vector(160, 120);
    public static function pix2screen(pixvec:Vector):Vector {
        pixvec.x *= Luxe.screen.w / pixdims.x;
        pixvec.y *= Luxe.screen.height / pixdims.y;
        return pixvec;
    }
    public static function screen2pix(screenvec:Vector):Vector {
        screenvec.x /= Luxe.screen.w / pixdims.x;
        screenvec.y /= Luxe.screen.height / pixdims.y;
        return screenvec;
    }
}
