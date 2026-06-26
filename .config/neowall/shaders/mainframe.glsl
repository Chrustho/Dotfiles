// Shader neowall: mainframe

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    vec2 uv = fragCoord / iResolution.xy;

    vec2 gridCount = vec2(15.0, 40.0);
    vec2 gridId = floor(uv * gridCount);
    vec2 gridUv = fract(uv * gridCount);

    float rand = fract(sin(dot(gridId, vec2(12.9898, 78.233))) * 43758.5453);
    float blink = sin(iTime * (2.0 + rand * 3.0) + rand * 6.28);

    blink = smoothstep(0.9, 1.0, blink);

    float shape = smoothstep(0.1, 0.3, gridUv.x) * smoothstep(0.9, 0.7, gridUv.x) *
                  smoothstep(0.1, 0.3, gridUv.y) * smoothstep(0.9, 0.7, gridUv.y);

    vec3 color = vec3(0.9, 0.05, 0.05) * blink * shape;

    fragColor = vec4(color, 1.0);
}
