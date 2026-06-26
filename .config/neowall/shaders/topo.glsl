// Shader neowall: topo

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{

    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    float altezza = sin(uv.x * 5.0 + iTime * 0.4) * 0.5;
    altezza += cos(uv.y * 4.0 - iTime * 0.3) * 0.5;
    altezza += sin((uv.x + uv.y) * 3.0 + iTime * 0.2) * 0.5;

    float topografia = abs(fract(altezza * 4.0) - 0.5);

    float spessore = 0.015 / (topografia + 0.005);

    float scanner = fract(uv.y * 0.5 - iTime * 0.2);

    float fasciaLuce = smoothstep(0.0, 0.5, scanner) * smoothstep(1.0, 0.9, scanner);

    vec3 coloreLinea = vec3(0.1, 0.8, 1.0);
    vec3 coloreSfondo = vec3(0.02, 0.05, 0.1);

    vec3 coloreFinale = coloreSfondo + (coloreLinea * spessore * (fasciaLuce + 0.2));

    coloreFinale *= smoothstep(1.2, 0.3, length(uv));

    fragColor = vec4(coloreFinale, 1.0);
}
