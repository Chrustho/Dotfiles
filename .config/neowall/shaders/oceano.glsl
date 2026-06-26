// Shader neowall: oceano

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    float flusso = sin(uv.x * 6.0 + iTime) * 0.15;
    flusso += cos(uv.y * 5.0 - iTime * 1.2) * 0.15;

    vec2 uvDistorto = uv + vec2(flusso, -flusso);

    float grigliaX = abs(fract(uvDistorto.x * 5.0) - 0.5);
    float grigliaY = abs(fract(uvDistorto.y * 5.0) - 0.5);

    float baglioreX = 0.01 / (grigliaX + 0.01);
    float baglioreY = 0.01 / (grigliaY + 0.01);

    float scanner = sin(uv.x + uv.y - iTime * 2.0);
    float fasciaLuce = smoothstep(0.5, 1.0, scanner);

    vec3 coloreOrizzontale = vec3(0.0, 0.6, 0.8) * baglioreY;
    vec3 coloreVerticale = vec3(0.0, 0.9, 0.5) * baglioreX;

    vec3 coloreFinale = (coloreOrizzontale + coloreVerticale) * (fasciaLuce + 0.3);

    coloreFinale *= smoothstep(1.0, 0.25, length(uv));

    fragColor = vec4(coloreFinale, 1.0);
}
