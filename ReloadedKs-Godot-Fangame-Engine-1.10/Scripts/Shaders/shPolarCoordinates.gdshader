shader_type canvas_item;
//render_mode unshaded;

uniform sampler2D texture_sampler;
uniform vec2 center = vec2(0.5);
uniform float tex_scale = 1.0;
uniform float tex_repeat = 2.0;
uniform float scroll_speed = 1.0;
uniform vec4 color_tint : source_color = vec4(1.0);

vec2 coordinates(vec2 uv, vec2 center_tex, float texture_scale, float texture_repeat) {
	vec2 dir = uv - center_tex;
	float radius = length(dir) * 2.0;
	float angle = atan(dir.x, dir.y) / (PI * 2.0) + 0.5;
	return vec2(angle * texture_repeat, radius * texture_scale);
}

void fragment() {
	vec2 uv = coordinates(UV, center, tex_scale, tex_repeat);
	vec4 image_tex = texture(texture_sampler, uv + TIME * scroll_speed);
	COLOR = image_tex * color_tint;
}