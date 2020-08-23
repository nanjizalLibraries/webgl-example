package webglExample.geometry;

@:structInit
class Vector3 {
    public var x: Float;
    public var y: Float;
    public var z: Float;
    public function new( x: Float, y: Float, z: Float ){
        this.x = x;
        this.y = y;
        this.z = z;
    }
}