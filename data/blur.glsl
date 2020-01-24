precision highp float;

uniform sampler2D pg; //PImage上の画像
uniform vec2 resolution; //解像度

uniform float width; //ぼかしの幅

void main(){
    vec2 uv = gl_FragCoord.xy / resolution; //テクスチャサンプル用のuv

    vec4 c = texture2D(pg, uv);

	float lod = log2(max(resolution.x, resolution.y)) * width;
    vec2 off = .5 / resolution * pow(2, lod) * clamp(lod, 0, 1);
	
	c+=textureLod(pg, uv + vec2(0,0)*off, lod);
	c+=textureLod(pg, uv + vec2(1,1)*off, lod);
	c+=textureLod(pg, uv + vec2(1,-1)*off, lod);
	c+=textureLod(pg, uv + vec2(-1,-1)*off, lod);
	c+=textureLod(pg, uv + vec2(-1,1)*off, lod);

	off *= 1.86;

    c+=textureLod(pg, uv + vec2(0,1)*off, lod);
	c+=textureLod(pg, uv + vec2(0,-1)*off, lod);
	c+=textureLod(pg, uv + vec2(-1,0)*off, lod);
	c+=textureLod(pg, uv + vec2(1,0)*off, lod);

	c /= 9.0;

    gl_FragColor = c;
}