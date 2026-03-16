void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    
    // Scaliamo la griglia (più alto = esagoni più piccoli)
    uv *= 6.0;
    
    // Matematica per creare una griglia esagonale senza loop pesanti
    vec2 r = vec2(1.0, 1.7320508);
    vec2 h = r * 0.5;
    vec2 a = mod(uv, r) - h;
    vec2 b = mod(uv - h, r) - h;
    vec2 gv = dot(a, a) < dot(b, b) ? a : b;
    
    // Calcoliamo la distanza dal centro dell'esagono ai bordi
    float hexDist = max(abs(gv.x), dot(abs(gv), normalize(r)));
    
    // Creiamo il bordo luminoso dell'esagono (spessore sottile)
    float bordo = smoothstep(0.4, 0.5, hexDist) - smoothstep(0.5, 0.55, hexDist);
    
    // Creiamo un'onda di energia radiale che "spazza" la griglia
    // Basata sulla distanza reale dal centro dello schermo (fragCoord)
    vec2 screenUv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    float onda = sin(length(screenUv) * 10.0 - iTime * 3.0) * 0.5 + 0.5;
    
    // Scanner orizzontale aggiunto per maggiore dinamismo
    float scanner = sin(screenUv.x * 5.0 + iTime * 2.0) * 0.5 + 0.5;
    
    // Combiniamo il bordo con l'onda e lo scanner (Azzurro/Ciano elettrico)
    vec3 colore = vec3(0.0, 0.6, 1.0) * bordo * (onda + 0.2);
    colore += vec3(0.2, 0.8, 1.0) * bordo * scanner * 0.5;
    
    // Scuriamo i bordi estremi dello schermo per fonderlo nel nero
    colore *= smoothstep(0.8, 0.3, length(screenUv));
    
    fragColor = vec4(colore, 1.0);
}
