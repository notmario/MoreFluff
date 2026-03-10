#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 triangle_badge_alt;
extern MY_HIGHP_OR_MEDIUMP vec2 uibox_pos;
extern MY_HIGHP_OR_MEDIUMP vec2 uibox_size;

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = colour;

    vec2 uv = (screen_coords - uibox_pos) / uibox_size.xy;

    uv.x = mod(uv.x + triangle_badge_alt.x, 0.4) * 5.; // EVIL...
    uv.y = (uv.y - 0.2) / (1.8);
    if (uv.x > 1) {
        uv.x = 2 - uv.x;
    }

    vec4 outcol = vec4(0.765, 0.259, 0.259, 1.0);
    if (uv.y <= uv.x) {
        outcol = vec4(0.621, 0.113, 0.154, 1.0);
    }

    // outcol = vec4(uv.y, 0., triangle_badge.y / 100000., 1.);

    return outcol;
}