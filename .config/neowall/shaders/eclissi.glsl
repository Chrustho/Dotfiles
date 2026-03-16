void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    
    // Passiamo alle coordinate polari: raggio e angolo
    float angolo = atan(uv.y, uv.x);
    float raggio = length(uv);
    
    // Creiamo onde organiche basate sull'angolo (come i petali di un fiore instabile)
    float onda = sin(angolo * 5.0 + iTime * 1.5) * 0.08;
    onda += cos(angolo * 3.0 - iTime * 1.0) * 0.12;
    
    // Definiamo il bordo del "nucleo" deformato dall'onda
    float nucleo = abs(raggio - 0.35 - onda);
    
    // Generiamo anelli concentrici in espansione, simili a quelli topografici
    float anelli = fract(nucleo * 8.0 - iTime * 2.0);
    float lineeAnelli = abs(anelli - 0.5);
    
    // Bagliore per il nucleo centrale e per gli anelli
    float baglioreAnelli = 0.008 / (lineeAnelli + 0.005);
    float baglioreNucleo = 0.02 / (nucleo + 0.005);
    
    // Maschera per dissolvere dolcemente verso il nero assoluto ai bordi
    float maschera = smoothstep(0.85, 0.2, raggio);
    
    // Colori: Arancione scuro/Rosso per il nucleo, Viola per l'onda di espansione
    vec3 coloreNucleo = vec3(1.0, 0.3, 0.1) * baglioreNucleo;
    vec3 coloreAnelli = vec3(0.5, 0.1, 0.9) * baglioreAnelli;
    
    vec3 coloreFinale = (coloreNucleo + coloreAnelli) * maschera;
    
    fragColor = vec4(coloreFinale, 1.0);
}
