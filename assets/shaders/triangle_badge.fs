#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 triangle_badge;
extern MY_HIGHP_OR_MEDIUMP vec4 uie_details;
extern MY_HIGHP_OR_MEDIUMP number uie_scale;
extern MY_HIGHP_OR_MEDIUMP number uie_rot;

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = colour;

    vec2 uv = (screen_coords - uie_details.xy) / uie_details.ga;

    if (uie_scale < 0.00001) {
        uv.x = uv.x + 0.0001;
    }
    if (uie_rot < 0.00001) {
        uv.x = uv.x + 0.0001;
    }
    
    uv.x = mod(uv.x * 2.5 + triangle_badge.x, 0.3) * 6.66666666; // EVIL...
    uv.y = (uv.y - 1.5) / (1.8);
    if (uv.x > 1) {
        uv.x = 2 - uv.x;
    }

    vec4 outcol = vec4(0.765, 0.259, 0.259, 1.0);
    if (uv.y <= uv.x) {
        outcol = vec4(0.621, 0.113, 0.154, 1.0);
    }

    outcol.rgb *= tex.r * 2;

    // outcol = vec4(uv.y, 0., triangle_badge.y / 100000., 1.);

    return outcol;
}