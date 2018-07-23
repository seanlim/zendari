shader_type canvas_item;

uniform bool rewind;
uniform bool died;

void fragment() {
	if (died) {
		COLOR =  vec4(0, 0, 0, 0.9);
	}
	else if (rewind){
		vec4 col = texture(TEXTURE, UV);
		COLOR = vec4(col.r * 0.03, col.b * 0.07, col.g * 0.0, 0.7);
	}
	else {
		COLOR = vec4(0, 0, 0, 0.15);
	}
}