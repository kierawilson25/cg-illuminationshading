#version 300 es

precision highp float;

in vec3 vertex_position;
in vec3 vertex_normal;

uniform vec3 light_ambient;
uniform vec3 light_position;
uniform vec3 light_color;
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

    vec3 view_normal = normalize(inverse(transpose(mat3(model_matrix))) * vertex_normal);

    vec3 light_direction = normalize(light_position - vert_position);

    float dif_dot_prod = dot(v_normal, light_direction);

    diffuse = clamp(light_color* d_prod, 0.0, 1.0);

    //specular calculations

    vec3 view_direction = normalize
     
    vec3 spec_dot_prod = dot(reflect(-light_direction, view_normal), light_direction);

    specular = light_color * pow(clamp(spec_dot_prod,0.0, 1.0), material_shininess);


}
