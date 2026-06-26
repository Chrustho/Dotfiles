// Shader neowall: tele_spazio

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = fragCoord / iResolution.xy;

    float scanline = fract(iTime * 0.4 - uv.x);

    float signal = 0.5 + sin(uv.x * 15.0) * 0.05 + sin(uv.x * 50.0 + iTime) * 0.02;

    float trace = 0.003 / abs(uv.y - signal);

    float fade = smoothstep(1.0, 0.9, scanline) * (1.0 - scanline);

    float intensity = trace * fade;

    float grid = step(0.98, fract(uv.x * 20.0)) + step(0.98, fract(uv.y * 20.0));
    grid *= 0.02;

    vec3 color = vec3(1.0, 0.6, 0.0) * (intensity + grid);

    fragColor = vec4(color, 1.0);
}
