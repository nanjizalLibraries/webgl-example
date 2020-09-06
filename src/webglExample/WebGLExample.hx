package webglExample;
import js.Browser;
import js.html.webgl.ContextAttributes;
import js.html.Element;
import js.html.CanvasElement;
import js.html.webgl.RenderingContext;
import webglExample.Renderer;
import webglExample.Camera;
import webglExample.Light;

function main(){
    new WebGLExample();
}

class WebGLExample {
    public var canvasGL:       CanvasElement;
    public var gl:             RenderingContext;
    public var renderer:       Renderer;
    public var camera          = new Camera();
    public var light           = new Light();
    public var objects         = [];
    public function new(){
        trace('create WebGLExample');
        createCanvas();
        renderer = new Renderer( canvasGL );
        renderer.setClearColor( 100, 149, 237 );
        var gl = renderer.getContext();
        Mesh.load( gl, '/assets/sphere.obj', '/assets/diffuse.png' ).then( function (mesh) {
                objects.push( mesh );
                trace('mesh set');
        });
        ShaderProgram.load( gl, '/shaders/basic.vert', '/shaders/basic.frag' )
             .then(function ( shader ) {
               renderer.setShader(shader);
               trace('shader setup');
             });
        camera.setOrthographic( 16, 10, 10 );
        loop( 60 );
    }
    public inline
    function createCanvas(){
        canvasGL            = Browser.document.createCanvasElement();
        canvasGL.width      = 800;
        canvasGL.height     = 600;
        var domGL               = cast canvasGL;
        Browser.document.body.appendChild( cast canvasGL );
        styleZero( domGL );
    }
    public inline
    function styleZero( domGL: Element ){
        var style         = domGL.style;
        style.paddingLeft = px( 0 );
        style.paddingTop  = px( 0 );
        style.left        = px( 0 );
        style.top         = px( 0 );
        style.position    = "absolute";
    }
    inline
    function px( v: Int ): String {
        return Std.string( v + 'px' );
    }
    function loop ( v: Float ): Void {
        renderer.render( camera, light, objects );
        camera.position = camera.position.rotateY( Math.PI / 120 );
        Browser.window.requestAnimationFrame( loop );
    }
}
