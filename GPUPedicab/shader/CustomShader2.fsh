varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
uniform highp float exposure;
//uniform highp float red;
//uniform highp float green;
//uniform highp float blue;

void main()
{
    //textureCoordinate.x = (textureCoordinate.x/2.0);
     highp vec2 tx = textureCoordinate;
    tx.x -= .5;
     lowp vec4 textureColor = texture2D(inputImageTexture, tx);
    //lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    lowp vec4 outputColor = textureColor;
    gl_FragColor = outputColor;
}
