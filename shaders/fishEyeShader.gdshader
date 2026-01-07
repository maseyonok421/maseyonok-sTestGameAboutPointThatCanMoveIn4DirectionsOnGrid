shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float effect_amount : hint_range(0, 2.5, 0.1) = 1.0;

// for Grain
uniform float amount : hint_range(0.0, 5.3, 0.01) = 0.22;
uniform float speed  : hint_range(0.0, 0.5, 0.001)= 0.016 ;

float random(vec2 st){
	return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void fragment() {

	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec4 fragCoord = FRAGCOORD;
	vec2 p = fragCoord.xy / iResolution.x;

	float prop = iResolution.x / iResolution.y;
	vec2 m = vec2(0.5, 0.5 / prop);
	vec2 d = p - m;
	float r = sqrt(dot(d, d));

	float bind = sqrt(dot(m, m));
	vec2 uv = m + normalize(d) * tan(r*effect_amount) * bind / tan(bind*effect_amount);
	uv.y *= prop;

	vec3 col = texture(SCREEN_TEXTURE, uv).rgb;

	float time = TIME*speed;
	float grain = random(UV + time) - 0.5;

	col.rgb += grain*amount;

	COLOR = vec4(col, 1.0);

}
