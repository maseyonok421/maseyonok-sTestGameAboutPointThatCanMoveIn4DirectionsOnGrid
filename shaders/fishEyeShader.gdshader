shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float effect_amount : hint_range(0, 2.5, 0.1) = 1.0;

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

	COLOR = vec4(col, 1.0);

}
