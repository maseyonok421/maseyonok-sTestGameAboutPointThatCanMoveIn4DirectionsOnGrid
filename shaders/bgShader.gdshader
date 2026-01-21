shader_type canvas_item;

uniform float alph = 0.87;
uniform float spd  = 1;
uniform float amnt = 13;
uniform vec3  col1 : source_color = vec3(0, 0, 0);
uniform vec3  col2 : source_color = vec3(1, 1, 1);

void fragment() {
	
	vec2 uv = UV - vec2(0.5, 0.34);
	
	float koef = abs( sin( (uv.x/uv.y) * amnt + TIME * spd ) );
	vec3 color = mix(col1, col2, koef);
	COLOR = vec4(color, alph);
	
}
