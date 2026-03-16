void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    
    // Generiamo l'increspatura dell'acqua/corrente dati
    float flusso = sin(uv.x * 6.0 + iTime) * 0.15;
    flusso += cos(uv.y * 5.0 - iTime * 1.2) * 0.15;
    
    // Sfasiamo le coordinate stesse
    vec2 uvDistorto = uv + vec2(flusso, -flusso);
    
    // Creiamo una griglia fluida (combiniamo asse X e Y)
    float grigliaX = abs(fract(uvDistorto.x * 5.0) - 0.5);
    float grigliaY = abs(fract(uvDistorto.y * 5.0) - 0.5);
    
    // Calcoliamo lo spessore e il bagliore
    float baglioreX = 0.01 / (grigliaX + 0.01);
    float baglioreY = 0.01 / (grigliaY + 0.01);
    
    // Onda di scansione diagonale molto ampia
    float scanner = sin(uv.x + uv.y - iTime * 2.0);
    float fasciaLuce = smoothstep(0.5, 1.0, scanner);
    
    // Colori ciano sottomarino e smeraldo
    vec3 coloreOrizzontale = vec3(0.0, 0.6, 0.8) * baglioreY;
    vec3 coloreVerticale = vec3(0.0, 0.9, 0.5) * baglioreX;
    
    // Il colore si illumina moltissimo dove passa lo scanner
    vec3 coloreFinale = (coloreOrizzontale + coloreVerticale) * (fasciaLuce + 0.3);
    
    // Scuriamo fortemente i bordi per l'estetica OLED e per un look più profondo
    coloreFinale *= smoothstep(1.0, 0.25, length(uv));
    
    fragColor = vec4(coloreFinale, 1.0);
}
