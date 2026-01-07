shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

//for Chromatic Abberation
uniform vec2 r_displacement = vec2(3.0, 0.0);
uniform vec2 g_displacement = vec2(0.0, 2.0);
uniform vec2 b_displacement = vec2(-4.0, 0.0);

uniform float height: hint_range(0.0, 1.0, 0.1) = 0.7;
uniform float width : hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float fade  : hint_range(0.0, 1.0, 0.1) = 0.75;

//for Fish Eye
uniform float effect_amount : hint_range(0, 2.5, 0.1) = 2.0;

//for Film Grain
uniform float amount : hint_range(0.0, 5.3, 0.01) = 0.42;
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
	
	float shrink_width = 2.0 / width;
	float shrink_height = 2.0 / height;
	float dist = distance(vec2(UV.x * shrink_width, UV.y * shrink_height), vec2(0.5 * shrink_width, 0.5 * shrink_height));
	
	float redColor = texture(SCREEN_TEXTURE, uv + vec2(SCREEN_PIXEL_SIZE*r_displacement), 0.0).r;
	float greenColor = texture(SCREEN_TEXTURE, uv + vec2(SCREEN_PIXEL_SIZE*g_displacement), 0.0).g;
	float blueColor = texture(SCREEN_TEXTURE, uv + vec2(SCREEN_PIXEL_SIZE*b_displacement), 0.0).b;
	
	float time = TIME*speed;
	float grain = random(UV + time) - 0.5;
	
	col.r = redColor; col.g = greenColor; col.b = blueColor;
	col.rgb += grain*amount;
	
	COLOR = vec4(col.rgb, dist-fade);
	
}
