package webglExample;
import js.html.webgl.RenderingContext;
import js.lib.Float32Array;//haxe.io.Float32Array;
import js.html.webgl.Buffer;
import webglExample.geometry.GeometryParser;
class Vbo{
    var gl: RenderingContext;
    var size: Int; 
    var count: Int;
    var buffer: Buffer;// may need changing.
    public function new( gl: RenderingContext, data: Array<Float>, count: Int ){
        // Creates buffer object in GPU RAM where we can store anything
        var bufferObject = gl.createBuffer();
        buffer = bufferObject;
        // Tell which buffer object we want to operate on as a VBO
        gl.bindBuffer( RenderingContext.ARRAY_BUFFER, bufferObject );
        // Write the data, and set the flag to optimize
        // for rare changes to the data we're writing
        gl.bufferData( RenderingContext.ARRAY_BUFFER
                     , new Float32Array( cast data ) // likely needs thought.
                     , RenderingContext.STATIC_DRAW );
        this.gl = gl;
        size = Std.int( data.length / count );
        this.count = count;
    }
    public inline
    function destroy(){
        // Free memory that is occupied by our buffer object
        gl.deleteBuffer( buffer );
    }
    public //inline
    function bindToAttribute( attribute: Int ){
        // Tell which buffer object we want to operate on as a VBO
        gl.bindBuffer( RenderingContext.ARRAY_BUFFER, buffer );
        // Enable this attribute in the shader
        gl.enableVertexAttribArray( attribute );
        // Define format of the attribute array. Must match parameters in shader
        gl.vertexAttribPointer( attribute, size, RenderingContext.FLOAT, false, 0, 0 );
    }
}