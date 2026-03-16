void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalizza le coordinate tenendo conto delle proporzioni dello schermo
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    
    // Creiamo una "mappa altimetrica" organica sovrapponendo onde sfalsate
    float altezza = sin(uv.x * 5.0 + iTime * 0.4) * 0.5;
    altezza += cos(uv.y * 4.0 - iTime * 0.3) * 0.5;
    altezza += sin((uv.x + uv.y) * 3.0 + iTime * 0.2) * 0.5;
    
    // Generiamo le linee di contorno (Isolinee) affilate
    float topografia = abs(fract(altezza * 4.0) - 0.5);
    
    // Creiamo un bagliore (glow) per le linee, rendendole "neon"
    float spessore = 0.015 / (topografia + 0.005);
    
    // Scanner orizzontale che scende ciclicamente
    float scanner = fract(uv.y * 0.5 - iTime * 0.2);
    // Creiamo una fascia di luce che sfuma gradualmente
    float fasciaLuce = smoothstep(0.0, 0.5, scanner) * smoothstep(1.0, 0.9, scanner);
    
    // Colori: Ciano e Blu scuro
    vec3 coloreLinea = vec3(0.1, 0.8, 1.0);
    vec3 coloreSfondo = vec3(0.02, 0.05, 0.1);
    
    // Combiniamo il tutto: lo sfondo base + le linee illuminate dallo scanner
    // Il +0.2 fa sì che le linee non scompaiano mai del tutto quando lo scanner passa
    vec3 coloreFinale = coloreSfondo + (coloreLinea * spessore * (fasciaLuce + 0.2));
    
    // Leggera vignettatura per scurire i bordi
    coloreFinale *= smoothstep(1.2, 0.3, length(uv));

    fragColor = vec4(coloreFinale, 1.0);
}
