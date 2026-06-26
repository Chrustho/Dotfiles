// Shader neowall: nastro

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = fragCoord / iResolution.xy;

    float speed = iTime * 3.0;

    float block = floor(uv.y * 40.0 + speed);

    float data = fract(sin(block * 12.9898) * 43758.5453);

    float led = step(0.85, data);

    float scanner_head = smoothstep(0.015, 0.0, abs(uv.y - 0.5));

    float read_flash = led * scanner_head * 2.0;

    vec3 color = vec3(0.05, 0.2, 0.5) * led + vec3(0.0, 0.8, 1.0) * read_flash;

    color *= smoothstep(0.0, 0.2, uv.x) * smoothstep(1.0, 0.8, uv.x);

    fragColor = vec4(color, 1.0);
}
