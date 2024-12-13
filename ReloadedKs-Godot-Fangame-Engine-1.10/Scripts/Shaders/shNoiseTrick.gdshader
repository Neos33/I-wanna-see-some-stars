shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform sampler2D gradient_color;
uniform vec2 scroll_speed1 = vec2(0.2, 0.2);
uniform vec2 scroll_speed2 = vec2(0.2, 0.2);
uniform vec2 scroll_speed3 = vec2(0.2, 0.2);

uniform float alpha_set = 0.4; 
uniform vec4 smoke_color : source_color;

void fragment() {
	float uv_r = texture(noise, UV + scroll_speed1 * TIME).r;
	float uv_g = texture(noise, UV + scroll_speed2 * TIME).g;
	float uv_b = texture(noise, UV + scroll_speed3 * TIME).b;
	
	float gradient = texture(gradient_color, vec2(UV.y, UV.x)).r;
	
	vec3 new_color = vec3(uv_r, uv_g, uv_b);
	float final_color = uv_r * uv_g * uv_b;
	//COLOR.rgb = vec3(uv_r, uv_g, uv_b) * color_tint;
	COLOR.rgb = smoke_color.rgb;
	COLOR.a = clamp(final_color * alpha_set * gradient * gradient, 0.0, 1.0);
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
