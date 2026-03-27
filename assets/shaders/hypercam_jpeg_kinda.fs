extern float wquant;
extern float hquant;

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec2 cell_pos = vec2(mod(texture_coords.x, wquant), mod(texture_coords.y, hquant));
    texture_coords = texture_coords - cell_pos;
    vec2 texture_coords2 = texture_coords + vec2(    wquant / 2.,     hquant / 2.);
    vec2 texture_coords3 = texture_coords + vec2(    wquant / 4., 3 * hquant / 4.);
    vec2 texture_coords4 = texture_coords + vec2(3 * wquant / 4.,     hquant / 4.);

    //add coordinate-modifying effects here
    vec4 tex1 = Texel(texture, texture_coords);
    vec4 tex2 = Texel(texture, texture_coords2);
    vec4 tex3 = Texel(texture, texture_coords3);
    vec4 tex4 = Texel(texture, texture_coords4);
    // add colour-modifying effects here

    vec4 tex = (tex1 + tex2 + tex3 + tex4) / 4.;
    
    return tex;
}


//necessary to prevent crashes i believe
#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    return transform_projection * vertex_position;
}
#endif