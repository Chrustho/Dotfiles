// Shader neowall: neon

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    vec3 coloreFinale = vec3(0.0);

    for(float i = 1.0; i <= 3.0; i++) {

        vec2 p = uv;
        p.x += sin(p.y * 2.0 * i + iTime * 0.5) * 0.2;
        p.y += cos(p.x * 2.0 * i - iTime * 0.5) * 0.2;

        float linea = abs(sin(p.y * 5.0 + iTime * i));

        float spessore = 0.008 / (linea + 0.002);

        vec3 colore = 0.5 + 0.5 * cos(iTime * 0.8 + p.xyx * 3.0 + vec3(0.0, 2.0, 4.0));

        coloreFinale += colore * spessore;
    }

    coloreFinale *= smoothstep(1.1, 0.2, length(uv));

    fragColor = vec4(coloreFinale, 1.0);
}
