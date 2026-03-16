void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = fragCoord / iResolution.xy;
    
    // Velocità di scorrimento del nastro dati
    float speed = iTime * 3.0;
    
    // Dividiamo lo schermo in "blocchi" di dati orizzontali
    float block = floor(uv.y * 40.0 + speed);
    
    // Funzione pseudo-random per decidere se il blocco è un 1 o uno 0
    float data = fract(sin(block * 12.9898) * 43758.5453);
    
    // Accendiamo solo il 15% dei blocchi per mantenere lo schermo molto scuro
    float led = step(0.85, data);
    
    // Aggiungiamo la testina di lettura fissa al centro
    float scanner_head = smoothstep(0.015, 0.0, abs(uv.y - 0.5));
    
    // Il dato brilla di più quando passa sotto lo scanner
    float read_flash = led * scanner_head * 2.0;
    
    // Colore Blu Cobalto/Ciano scuro
    vec3 color = vec3(0.05, 0.2, 0.5) * led + vec3(0.0, 0.8, 1.0) * read_flash;
    
    // Scuriamo un po' i bordi laterali per simulare il nastro fisico
    color *= smoothstep(0.0, 0.2, uv.x) * smoothstep(1.0, 0.8, uv.x);
    
    fragColor = vec4(color, 1.0);
}
