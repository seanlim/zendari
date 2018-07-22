shader_type canvas_item;
uniform bool rewind;
uniform bool died;

void fragment() {
	if (died) {
		COLOR =  vec4(1.0, 1.0, 1.0, 0.6);
	}
	else if (rewind){
		COLOR =  vec4(0.1, 0.1, 0.2, 0.6);
	}
	else {
		COLOR = vec4(0, 0, 0, 0.15);
	}
}