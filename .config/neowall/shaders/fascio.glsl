void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    vec3 coloreFinale = vec3(0.0);
    
    // Generiamo 15 "fibre" o cavi luminosi
    // (Un ciclo di 15 è leggerissimo per qualsiasi GPU moderna)
    for(float i = 0.0; i < 15.0; i++) {
        // Ogni fibra ha una velocità e un'ampiezza sfasata
        float t = iTime * (0.2 + i * 0.02);
        
        // Creiamo la forma intrecciata della fibra
        float y = sin(uv.x * (2.0 + i * 0.1) + t) * (0.3 + i * 0.01);
        y += cos(uv.x * 3.0 - t * 1.5) * 0.1; // Seconda perturbazione
        
        // Calcoliamo il bagliore basato sulla distanza
        float dist = abs(uv.y - y);
        float glow = 0.0015 / (dist + 0.001); // Linee molto sottili e taglienti
        
        // Assegniamo un colore dinamico che sfuma tra Viola, Magenta e Arancio
        vec3 colore = 0.5 + 0.5 * cos(i * 0.4 + iTime + vec3(0.0, 2.0, 4.0));
        
        coloreFinale += colore * glow;
    }
    
    // Aggiungiamo delle "scintille" di dati che corrono lungo le fibre
    float scintilla = step(0.99, fract(uv.x * 3.0 - iTime * 2.0));
    coloreFinale += coloreFinale * scintilla * 2.0; // Fa brillare i punti incrociati
    
    // Scuriamo il top e il bottom per concentrare l'azione al centro
    coloreFinale *= smoothstep(1.0, 0.2, abs(uv.y));
    
    fragColor = vec4(coloreFinale, 1.0);
}
