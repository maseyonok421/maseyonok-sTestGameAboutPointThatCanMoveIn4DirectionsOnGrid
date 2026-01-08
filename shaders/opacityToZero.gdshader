shader_type canvas_item;

uniform float spawnTime = 0;
uniform float amount : hint_range(1.0, 10.0, 0.1) = 2;

void fragment() {
	float time = TIME-spawnTime;
	COLOR = vec4(texture(TEXTURE, UV).rgb, max(0.7-time, 0.0)/amount);
}
