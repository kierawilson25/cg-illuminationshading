#version 300 es

precision mediump float;

in vec3 frag_pos;
in vec3 frag_normal;

uniform vec3 light_ambient;
uniform vec3 light_position;
uniform vec3 light_color;
uniform vec3 camera_position;
uniform vec3 material_color;      // Ka and Kd
uniform vec3 material_specular;   // Ks
uniform float material_shininess; // n

out vec4 FragColor;

void main() {
    //ambient
    vec3 ambient = light_ambient * material_color;
	
	vec3 l = normalize(light_position - frag_pos);
	
    // IK(N.L)
    vec3 diffuse = light_color * dot(frag_normal, l) * material_color;

	
	vec3 r = normalize(reflect(-light_direction, frag_normal));
	vec3 v = normalize(camera_position - frag_pos);
    // IK(R.V) 
	vec3 specular = light_color * pow(clamp(dot(r, v), 0.0, 1.0), material_shininess)* material_specular;
	
    vec3 result = ambient + diffuse + specular;

	FragColor = vec4(result, 1.0);
}


