// Shader neowall: oscillo

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    float freqX = sin(iTime * 0.7) * 3.0 + 4.0;
    float freqY = cos(iTime * 0.5) * 3.0 + 4.0;

    float wave = sin(uv.x * freqX + iTime * 2.0) * 0.3 * cos(uv.x * freqY);

    float dist = abs(uv.y - wave);

    float glow = 0.005 / (dist + 0.001);

    glow *= smoothstep(0.8, 0.2, length(uv));

    vec3 color = vec3(0.1, 0.9, 0.3) * glow;

    color = clamp(color, 0.0, 1.0);

    fragColor = vec4(color, 1.0);
}
