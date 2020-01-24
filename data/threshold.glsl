precision mediump float;

uniform sampler2D pg; //PImage上の画像
uniform vec2 resolution; //解像度

uniform float threshold;
uniform float wid;

uniform vec3 fillColor;

void main(){
    vec2 uv = gl_FragCoord.xy / resolution; //テクスチャサンプル用のuv

    vec4 c = texture2D(pg, uv);

    float lum = dot(c.rgb, vec3(0.2126, 0.7152, 0.0722));
    float v = smoothstep(threshold - wid, threshold + wid, lum);

    gl_FragColor = vec4(mix(vec3(0), fillColor, v), 1.0);
}