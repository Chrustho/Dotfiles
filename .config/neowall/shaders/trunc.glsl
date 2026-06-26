// Shader neowall: trunc

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    vec2 screenUv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    vec2 uv = screenUv * 8.0;
    uv.x += iTime * 1.5;
    uv.y += sin(iTime * 0.5);

    vec2 id = floor(uv);
    vec2 gv = fract(uv) - 0.5;

    float n = hash(id);
    if(n < 0.5) gv.x *= -1.0;

    float d = min(length(gv - 0.5), length(gv + 0.5));

    float tubo = abs(d - 0.5);

    float glow = 0.015 / (tubo + 0.005);

    float scanner = sin(length(screenUv) * 15.0 - iTime * 4.0) * 0.5 + 0.5;

    vec3 coloreBase = vec3(1.0, 0.1, 0.4);
    vec3 colore = coloreBase * glow * (scanner + 0.3);

    colore *= smoothstep(0.7, 0.2, length(screenUv));

    fragColor = vec4(colore, 1.0);
}
