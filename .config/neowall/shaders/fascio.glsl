// Shader neowall: fascio

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    vec3 coloreFinale = vec3(0.0);

    for(float i = 0.0; i < 15.0; i++) {

        float t = iTime * (0.2 + i * 0.02);

        float y = sin(uv.x * (2.0 + i * 0.1) + t) * (0.3 + i * 0.01);
        y += cos(uv.x * 3.0 - t * 1.5) * 0.1;

        float dist = abs(uv.y - y);
        float glow = 0.0015 / (dist + 0.001);

        vec3 colore = 0.5 + 0.5 * cos(i * 0.4 + iTime + vec3(0.0, 2.0, 4.0));

        coloreFinale += colore * glow;
    }

    float scintilla = step(0.99, fract(uv.x * 3.0 - iTime * 2.0));
    coloreFinale += coloreFinale * scintilla * 2.0;

    coloreFinale *= smoothstep(1.0, 0.2, abs(uv.y));

    fragColor = vec4(coloreFinale, 1.0);
}
