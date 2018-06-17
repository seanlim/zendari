shader_type canvas_item;
uniform bool rewind;

void fragment() {
	if (rewind){
		COLOR = vec4(0.2, 0.2, 0.2, 0.4);
	}
	else {
		COLOR = vec4(0, 0, 0, 0);
	}
}