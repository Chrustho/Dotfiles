void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;
    
    float v = 0.0;
    vec2 p = uv * 1.5; // Zoom
    
    // Creiamo una distorsione spaziale molto complessa (Domain Warping iterativo)
    for(float i = 1.0; i <= 4.0; i++) {
        p.x += sin(p.y * i + iTime * 0.5) * 0.4;
        p.y += cos(p.x * i - iTime * 0.3) * 0.4;
        // Accumuliamo le onde per creare "alture" e "depressioni" circolari
        v += sin(length(p) * 3.0 - iTime) * 0.5 + 0.5;
    }
    v /= 4.0; // Normalizziamo il risultato tra 0 e 1
    
    // Estraiamo le linee topografiche dal rumore fluido
    float linee = abs(fract(v * 6.0) - 0.5);
    float glow = 0.01 / (linee + 0.002);
    
    // Mappatura del colore: le aree basse sono Blu profondo, quelle alte Verde Acido
    vec3 coloreBasso = vec3(0.0, 0.2, 0.8);
    vec3 coloreAlto = vec3(0.1, 1.0, 0.4);
    
    // Mixiamo il colore in base all'altezza (v)
    vec3 coloreFinale = mix(coloreBasso, coloreAlto, v) * glow;
    
    // Aggiungiamo un leggero "respiro" all'intensità generale
    coloreFinale *= 0.8 + 0.2 * sin(iTime * 2.0);
    
    // Vignettatura forte per gli OLED
    coloreFinale *= smoothstep(1.2, 0.3, length(uv));
    
    fragColor = vec4(coloreFinale, 1.0);
}
