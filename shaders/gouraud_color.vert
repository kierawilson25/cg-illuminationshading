#version 300 es

precision highp float;

in vec3 vertex_position;
in vec3 vertex_normal;

uniform vec3 light_ambient;
uniform vec3 light_position[];
uniform vec3 light_color[];
uniform int light_num;
uniform vec3 camera_position;
uniform float material_shininess; // n
uniform mat4 model_matrix;
uniform mat4 view_matrix;
uniform mat4 projection_matrix;

out vec3 ambient;
out vec3 diffuse;
out vec3 specular;

void main() {

    gl_Position = projection_matrix * view_matrix * model_matrix * vec4(vertex_position, 1.0);

    ambient = light_ambient;

    //can add a loop here if we want mulpitple lights

    vec3 view_position = vec3(model_matrix * vec4(vertex_position, 1.0));

    vec3 view_normal = inverse(transpose(mat3(model_matrix))) * vertex_normal;

    for(int i = 0; i < light_num; i++)
    {
        vec3 N = normalize(view_normal);
        vec3 L = normalize(light_position - view_position);
        diffuse += light_color * clamp(dot(N, L), 0.0, 1.0);

        vec3 V = normalize(camera_position-view_position);
        vec3 R = normalize(reflect(-L, N));
        specular += light_color * pow(clamp(dot(R, V), 0.0, 1.0), material_shininess);
    }
}
