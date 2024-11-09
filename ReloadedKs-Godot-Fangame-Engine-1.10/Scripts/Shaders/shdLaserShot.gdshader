shader_type canvas_item;

uniform vec2 scrolling_speed = vec2(1.0, 1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 uv = texture(TEXTURE, UV + scrolling_speed * TIME);
	COLOR = uv;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
