shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

uniform float amount : hint_range(0.0, 5.3, 0.01) = 0.5;
uniform float speed  : hint_range(0.0, 0.5, 0.001)= 2.05 ;

float random(vec2 st){
	return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void fragment() {
	
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	float time = TIME*speed;
	float grain = round(random(UV + time));
	
	color.rgb = vec3(grain, grain, grain);
	COLOR = color;
	
}
