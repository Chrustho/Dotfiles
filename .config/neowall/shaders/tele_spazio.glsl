void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = fragCoord / iResolution.xy;
    
    // Raggio di scansione che si muove da sinistra a destra
    float scanline = fract(iTime * 0.4 - uv.x);
    
    // Generiamo un segnale sporco (un'onda con delle interferenze)
    float signal = 0.5 + sin(uv.x * 15.0) * 0.05 + sin(uv.x * 50.0 + iTime) * 0.02;
    
    // Disegniamo la traccia del segnale
    float trace = 0.003 / abs(uv.y - signal);
    
    // Facciamo in modo che la traccia sia visibile solo "dietro" il raggio di scansione
    // e che sfumi verso il nero man mano che il tempo passa
    float fade = smoothstep(1.0, 0.9, scanline) * (1.0 - scanline);
    
    // Uniamo il segnale alla dissolvenza
    float intensity = trace * fade;
    
    // Griglia millimetrata di sfondo debolissima (quasi spenta)
    float grid = step(0.98, fract(uv.x * 20.0)) + step(0.98, fract(uv.y * 20.0));
    grid *= 0.02; 

    // Colore Ambra monocromatico
    vec3 color = vec3(1.0, 0.6, 0.0) * (intensity + grid);
    
    fragColor = vec4(color, 1.0);
}
