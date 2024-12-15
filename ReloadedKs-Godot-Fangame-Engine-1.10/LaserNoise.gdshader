shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform sampler2D gradient;
uniform vec2 speed_texture = vec2(1, 1);

uniform vec2 texture_size; // Tamaño de la textura (ancho y alto)
uniform vec2 screen_size;  // Tamaño de la pantalla o del área de dibujo

uniform vec4 texture_color : source_color;
uniform vec4 replacement_color : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV;
	// Proporción de la pantalla
	float screen_ratio = screen_size.x / screen_size.y;

	// Proporción de la textura
	float texture_ratio = texture_size.x / texture_size.y;

	// Ajustar las UV para mantener el aspecto de la textura
	if (screen_ratio > texture_ratio) {
	uv.x = uv.x * (texture_ratio / screen_ratio);
	} else {
	uv.y = uv.y * (screen_ratio / texture_ratio);
	}
	//vec4 uv = texture(noise, UV + speed_texture * TIME);
	//COLOR = uv;
	vec4 uv_final = texture(noise, uv + speed_texture * TIME);
	if (uv_final.rgb == vec3(0.0)) {
        uv_final.rgb = replacement_color.rgb;
    }
	COLOR = uv_final * texture_color * replacement_color;
	COLOR.a = texture(gradient, vec2(UV.y, UV.x)).r;
	//COLOR.rgba *= texture_color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
