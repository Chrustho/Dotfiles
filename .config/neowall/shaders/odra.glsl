// Shader neowall: odra

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

    vec2 uv = (fragCoord.xy - 0.5 * iResolution.xy) / iResolution.y;

    float dist = length(uv);
    float time = iTime * 2.5;

    vec3 col = vec3(0.01, 0.01, 0.015);

    float pulse = sin(dist * 25.0 - time);

    pulse = smoothstep(0.96, 1.0, pulse);

    vec3 colorSafe = vec3(0.1, 0.5, 1.0);
    vec3 colorDanger = vec3(1.0, 0.3, 0.0);
    float dangerLevel = sin(iTime * 0.3) * 0.5 + 0.5;
    vec3 scannerColor = mix(colorSafe, colorDanger, dangerLevel);

    float fadeOut = smoothstep(0.8, 0.1, dist);

    col += scannerColor * pulse * fadeOut;

    col += scannerColor * 0.05 / (dist + 0.01);

    fragColor = vec4(col, 1.0);
}
