// Generatore per la pioggia
float hashRain(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec2 p = (fragCoord.xy * 2.0 - iResolution.xy) / iResolution.y;
    
    vec3 col = vec3(0.05, 0.07, 0.1); // Sfondo cielo tempestoso scuro
    
    // Più strati (layer) di pioggia per dare profondità
    for(float i = 0.0; i < 4.0; i++) {
        vec2 st = p * (1.0 + i * 0.5); // Scaliamo la griglia per simulare la distanza
        st.y += iTime * (3.0 + i * 1.5); // Velocità caduta (il Timefall cade rapido)
        st.x += st.y * 0.05; // Leggera inclinazione del vento
        
        vec2 grid = floor(st * vec2(15.0, 1.0));
        vec2 f = fract(st * vec2(15.0, 1.0));
        
        float n = hashRain(grid);
        if (n > 0.75) {
            // Forma della singola goccia
            float drop = smoothstep(0.05, 0.0, abs(f.x - 0.5)) * smoothstep(1.0, 0.4, f.y);
            col += vec3(0.6, 0.7, 0.8) * drop * (1.0 - i * 0.2); // Pioggia bianca/grigiastra
        }
    }
    
    // Gradiente nebbioso in basso
    col = mix(col, vec3(0.0, 0.0, 0.0), (1.0 - uv.y) * 0.4);

    fragColor = vec4(col, 1.0);
}
