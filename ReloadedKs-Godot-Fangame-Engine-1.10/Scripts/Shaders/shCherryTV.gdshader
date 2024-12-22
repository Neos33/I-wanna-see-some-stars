shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform vec2 speed = vec2(0.2, 0.2);

void vertex() {

}

void fragment() {
	COLOR.rgb = texture(noise, UV + speed * TIME).rgb;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
