shader_type canvas_item;

uniform float lineThickness : hint_range(0.1, 10.0) = 2.0;
uniform float lineSpacing   : hint_range(0.1, 20.0) = 3.0;
uniform float lineBrightness: hint_range(0.0, 1.0 ) = 0.0;
uniform float screenYOffset : hint_range(-1.0, 1.0) = 0.0;

uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
	
	vec4 color= texture(screen_texture, SCREEN_UV);
	float scanline = sin((UV.y + screenYOffset - TIME/10.0) * 3.1415 * lineSpacing);
	scanline = (scanline + 1.0) * 0.5;
	scanline = floor(scanline * lineThickness) / lineThickness;
	
	color.rgb *= mix(1.0, lineBrightness, scanline);
	COLOR = color;
	
}
