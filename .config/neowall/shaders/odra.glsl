void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // Centriamo le coordinate
    vec2 uv = (fragCoord.xy - 0.5 * iResolution.xy) / iResolution.y;
    
    float dist = length(uv);
    float time = iTime * 2.5;
    
    // Sfondo buio
    vec3 col = vec3(0.01, 0.01, 0.015);
    
    // Impulso radar
    float pulse = sin(dist * 25.0 - time);
    // Rendiamo le linee del radar più nette
    pulse = smoothstep(0.96, 1.0, pulse);
    
    // Colore dell'Odradek: fluttua dinamicamente tra l'azzurro rassicurante e l'arancione emergenza
    vec3 colorSafe = vec3(0.1, 0.5, 1.0);
    vec3 colorDanger = vec3(1.0, 0.3, 0.0);
    float dangerLevel = sin(iTime * 0.3) * 0.5 + 0.5; // Oscilla lentamente
    vec3 scannerColor = mix(colorSafe, colorDanger, dangerLevel);
    
    // Il radar si indebolisce allontanandosi dal centro
    float fadeOut = smoothstep(0.8, 0.1, dist);
    
    // Aggiungiamo il cerchio pulsante al colore di base
    col += scannerColor * pulse * fadeOut;
    
    // Aggiunta di un bagliore (glow) centrale
    col += scannerColor * 0.05 / (dist + 0.01);
    
    fragColor = vec4(col, 1.0);
}
