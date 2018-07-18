shader_type canvas_item;
uniform bool rewind;

void fragment() {
	if (rewind){
		COLOR =  vec4(0.5, 0.5, 0.5, 0.6);
	}
	else {
		COLOR = vec4(0, 0, 0, 0.15);
	}
}