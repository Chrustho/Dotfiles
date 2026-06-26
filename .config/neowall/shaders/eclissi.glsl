// Shader neowall: eclissi

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    float angolo = atan(uv.y, uv.x);
    float raggio = length(uv);

    float onda = sin(angolo * 5.0 + iTime * 1.5) * 0.08;
    onda += cos(angolo * 3.0 - iTime * 1.0) * 0.12;

    float nucleo = abs(raggio - 0.35 - onda);

    float anelli = fract(nucleo * 8.0 - iTime * 2.0);
    float lineeAnelli = abs(anelli - 0.5);

    float baglioreAnelli = 0.008 / (lineeAnelli + 0.005);
    float baglioreNucleo = 0.02 / (nucleo + 0.005);

    float maschera = smoothstep(0.85, 0.2, raggio);

    vec3 coloreNucleo = vec3(1.0, 0.3, 0.1) * baglioreNucleo;
    vec3 coloreAnelli = vec3(0.5, 0.1, 0.9) * baglioreAnelli;

    vec3 coloreFinale = (coloreNucleo + coloreAnelli) * maschera;

    fragColor = vec4(coloreFinale, 1.0);
}
