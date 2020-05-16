#version 300 es

precision mediump float;

in vec3 ambient;
in vec3 diffuse;
in vec3 specular;

uniform vec3 material_color;    // Ka and Kd
uniform vec3 material_specular; // Ks

out vec4 FragColor;

void main() {
	vec3 newAmbient = ambient * material_color;
	vec3 newDiffuse = diffuse * material_color;
	vec3 newSpecular = specular * material_specular;

	vec3 newColor = newAmbient + newDiffuse + newSpecular;

	FragColor = vec4(min(newColor, vec3(1,1,1)), 1.0);
}
