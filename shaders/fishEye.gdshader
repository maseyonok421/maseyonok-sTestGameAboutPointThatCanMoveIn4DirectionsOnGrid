shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;

uniform float curvature : hint_range(0.0, 0.1) = 0.02;
uniform float vignette  : hint_range(0.0, 1.0) = 0.3;

void fragment() {
	
	vec2  normalUv = SCREEN_UV*2.0 - 1.0;
	float dist     = length(normalUv);
	vec2  distortedUv = normalUv * ( 1.0 + curvature * dist * dist );
	distortedUv       = distortedUv * 0.5 + 0.5;
	
	float vignetteFactor = 1.0 - dist*dist;
	COLOR = texture(screen_texture, distortedUv) * vignetteFactor;
	
}
