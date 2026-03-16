void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    
    // Piccolissima deriva analogica/interferenza per non renderlo "troppo" perfetto
    uv += vec2(sin(iTime * 0.3), cos(iTime * 0.4)) * 0.005;

    // Reticolo centrale (Croce sottilissima)
    float crosshair = smoothstep(0.002, 0.0, abs(uv.x)) * step(abs(uv.y), 0.08) +
                      smoothstep(0.002, 0.0, abs(uv.y)) * step(abs(uv.x), 0.08);
                      
    // Cerchio di inquadramento
    float radius = length(uv);
    float circle = smoothstep(0.003, 0.0, abs(radius - 0.35));
    
    // Tacche di misurazione (Ticks) sugli assi X e Y
    float tickX = smoothstep(0.002, 0.0, abs(uv.x)) * step(fract(uv.y * 15.0), 0.1) * step(abs(uv.y), 0.45);
    float tickY = smoothstep(0.002, 0.0, abs(uv.y)) * step(fract(uv.x * 15.0), 0.1) * step(abs(uv.x), 0.45);

    // Uniamo gli elementi geometrici
    float hud = crosshair + circle + tickX + tickY;
    
    // Riduciamo la luminosità generale per l'OLED (70%)
    hud *= 0.7;
    
    // Colore ciano ghiaccio tipico dei display HUD militari o VFD
    vec3 color = vec3(0.2, 0.9, 0.8) * hud;
    
    fragColor = vec4(color, 1.0);
}
