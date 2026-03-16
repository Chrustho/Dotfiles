void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    // Risoluzione nativa, nessun aggiustamento aspect ratio (riempie tutto)
    vec2 uv = fragCoord / iResolution.xy;
    
    // Definiamo la densità dei nodi sulla griglia (15x40 celle)
    vec2 gridCount = vec2(15.0, 40.0);
    vec2 gridId = floor(uv * gridCount);
    vec2 gridUv = fract(uv * gridCount);
    
    // Generazione del tempo di lampeggio casuale per singola cella
    float rand = fract(sin(dot(gridId, vec2(12.9898, 78.233))) * 43758.5453);
    float blink = sin(iTime * (2.0 + rand * 3.0) + rand * 6.28);
    
    // Manteniamo la cella spenta per il 90% del tempo
    blink = smoothstep(0.9, 1.0, blink);
    
    // Disegniamo la forma quadrata smussata di un singolo LED
    float shape = smoothstep(0.1, 0.3, gridUv.x) * smoothstep(0.9, 0.7, gridUv.x) *
                  smoothstep(0.1, 0.3, gridUv.y) * smoothstep(0.9, 0.7, gridUv.y);
                  
    // Rosso scuro e minaccioso
    vec3 color = vec3(0.9, 0.05, 0.05) * blink * shape;
    
    fragColor = vec4(color, 1.0);
}
