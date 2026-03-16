void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    
    // Frequenze d'onda sfasate per asse X e Y che evolvono nel tempo
    float freqX = sin(iTime * 0.7) * 3.0 + 4.0;
    float freqY = cos(iTime * 0.5) * 3.0 + 4.0;

    // Creiamo la forma dell'onda matematica
    float wave = sin(uv.x * freqX + iTime * 2.0) * 0.3 * cos(uv.x * freqY);

    // Calcoliamo la distanza del pixel dalla linea dell'onda
    float dist = abs(uv.y - wave);
    
    // Effetto "glow" tipico dei fosfori (più vicino sei alla linea, più brilla)
    float glow = 0.005 / (dist + 0.001); 
    
    // Attenuazione ai bordi dello schermo (vignettatura del tubo catodico)
    glow *= smoothstep(0.8, 0.2, length(uv));

    // Colore verde laboratorio intenso
    vec3 color = vec3(0.1, 0.9, 0.3) * glow;
    
    // Tagliamo i valori troppo alti per evitare artefatti bianchi esagerati
    color = clamp(color, 0.0, 1.0);
    
    fragColor = vec4(color, 1.0);
}
