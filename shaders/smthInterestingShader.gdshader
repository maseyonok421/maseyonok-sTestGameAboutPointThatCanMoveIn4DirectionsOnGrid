shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float displacement : hint_range(0.0, 10.0, 1.0) = 3.0;
uniform float height : hint_range(0.0, 1.0, 0.1) = 0.7;
uniform float width  : hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float fade   : hint_range(0.0, 1.0, 0.1) = 0.7;

void fragment(){

	float shrink_width  = 2.0/width ;
	float shrink_height = 2.0/height;
	float dist = distance(vec2(UV.x*shrink_width, UV.y*shrink_height), vec2(0.5*shrink_width, 0.5*shrink_height));
	
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
	color.r += (sqrt(dot(SCREEN_PIXEL_SIZE, SCREEN_PIXEL_SIZE))*displacement);
	color.b -= (sqrt(dot(SCREEN_PIXEL_SIZE, SCREEN_PIXEL_SIZE))*displacement);
	color.a = dist-fade;
	
	COLOR = color;
}
