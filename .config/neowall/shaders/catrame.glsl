// Shader neowall: catrame

vec2 hash(vec2 p) {
    p = vec2(dot(p, vec2(127.1, 311.7)), dot(p, vec2(269.5, 183.3)));
    return -1.0 + 2.0 * fract(sin(p) * 43758.5453123);
}

float noise(in vec2 p) {
    const float K1 = 0.366025404;
    const float K2 = 0.211324865;
    vec2 i = floor(p + (p.x + p.y) * K1);
    vec2 a = p - i + (i.x + i.y) * K2;
    float m = step(a.y, a.x);
    vec2 o = vec2(m, 1.0 - m);
    vec2 b = a - o + K2;
    vec2 c = a - 1.0 + 2.0 * K2;
    vec3 h = max(0.5 - vec3(dot(a, a), dot(b, b), dot(c, c)), 0.0);
    vec3 n = h * h * h * h * vec3(dot(a, hash(i + 0.0)), dot(b, hash(i + o)), dot(c, hash(i + 1.0)));
    return dot(n, vec3(70.0));
}

float fbm(vec2 uv) {
    float f = 0.0;
    float amp = 0.5;
    mat2 rot = mat2(0.87758, 0.47942, -0.47942, 0.87758);
    for (int i = 0; i < 4; i++) {
        f += amp * noise(uv);
        uv = rot * uv * 2.0 + vec2(100.0);
        amp *= 0.5;
    }
    return f;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

    vec2 uv = fragCoord.xy / iResolution.xy;
    vec2 p = uv * 2.0 - 1.0;
    p.x *= iResolution.x / iResolution.y;

    p *= 1.5;

    float t = iTime * 0.15;

    vec2 q = vec2(fbm(p + t * 0.4), fbm(p + vec2(5.2, 1.3) - t * 0.3));
    vec2 r = vec2(fbm(p + q * 2.0 + t * 0.2), fbm(p + q * 2.0 - t * 0.2));

    float f = fbm(p + r * 1.5);

    vec3 colBase = vec3(0.01, 0.015, 0.02);

    float specular = smoothstep(0.5, 0.9, r.y) * 0.2;
    colBase += vec3(0.6, 0.7, 0.8) * specular;

    float goldVeins = smoothstep(0.06, 0.0, abs(f - 0.55));

    float goldPools = smoothstep(0.75, 1.0, f);

    vec3 colorGold = vec3(1.0, 0.75, 0.15);

    vec3 finalColor = mix(colBase, colorGold * 1.5, goldVeins);
    finalColor = mix(finalColor, colorGold * 2.5, goldPools);

    fragColor = vec4(finalColor, 1.0);
}
