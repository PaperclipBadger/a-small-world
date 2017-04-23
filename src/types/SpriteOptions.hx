package types;

typedef SpriteOptions = {
    var name:String;
    var texture_id:String;
    @:optional var animation_id:String;
    @:optional var size:SimpleVector;
    @:optional var position:SimpleVector;
    var depth:Float;
    @:optional var centered:Bool;
}
