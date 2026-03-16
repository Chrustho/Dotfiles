// --- FUNZIONI DI BASE (Leggerissime) ---
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453123);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // 1. Setup coordinate e Griglia
    vec2 p = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    float dimensioneGriglia = 45.0; 
    vec2 griglia = p * dimensioneGriglia;
    vec2 idCella = floor(griglia);
    vec2 uvCella = fract(griglia);

    // Tempo a scatti (3.0 FPS)
    float tempoScatti = floor(iTime * 3.0);

    // --- LOGICA STATO ATTUALE ---
    
    // Livello 1: I cluster (le macchie lente e dense)
    float attivita = noise(idCella * 0.06 + vec2(tempoScatti * 0.02, iTime * 0.01));
    float probabilitaVita = smoothstep(0.7, 0.85, attivita);
    float casoCella = hash(idCella + tempoScatti * 0.13);
    float clusterVivo = step(0.6, casoCella) * step(0.1, probabilitaVita);

    // Livello 2: Gli sprazzi nel vuoto (Le "Anomalie")
    // Generiamo un numero da 0.0 a 1.0. 
    // Modifica 0.992 per regolarne la quantità: 0.998 = rari, 0.950 = tantissimi
    float scintillaCasuale = hash(idCella * 7.31 + tempoScatti * 0.45);
    float sprazzoVivo = step(0.992, scintillaCasuale);

    // La cella è viva se appartiene a un cluster OPPURE è uno sprazzo
    float cellaViva = max(clusterVivo, sprazzoVivo);

    // --- LOGICA STATO PRECEDENTE (Per l'effetto fantasma) ---
    float tempoPrec = tempoScatti - 1.0;
    
    // Ricalcoliamo esattamente cosa succedeva nel tick precedente
    float attivitaPrec = noise(idCella * 0.06 + vec2(tempoPrec * 0.02, (iTime - 0.33) * 0.01));
    float probabilitaPrec = smoothstep(0.7, 0.85, attivitaPrec);
    float casoPrec = hash(idCella + tempoPrec * 0.13);
    float clusterPrec = step(0.6, casoPrec) * step(0.1, probabilitaPrec);
    
    float scintillaPrec = step(0.992, hash(idCella * 7.31 + tempoPrec * 0.45));
    
    float cellaFantasma = max(clusterPrec, scintillaPrec);

    // --- ESTETICA E COLORI ---
    
    // Disegniamo il blocco e la sottile griglia di fondo
    float blocco = smoothstep(0.1, 0.15, uvCella.x) * smoothstep(0.9, 0.85, uvCella.x) *
                   smoothstep(0.1, 0.15, uvCella.y) * smoothstep(0.9, 0.85, uvCella.y);
    float lineeGriglia = smoothstep(0.02, 0.0, uvCella.x) + smoothstep(0.02, 0.0, uvCella.y);

    // Palette Colori Desaturata
    vec3 coloreSfondo = vec3(0.06, 0.07, 0.08);    // Grigio Ardesia scuro
    vec3 coloreLinea = vec3(0.1, 0.12, 0.14);      // Griglia leggerissima
    vec3 coloreFantasma = vec3(0.18, 0.22, 0.25);  // Grigio-Blu debole (Ghosting)
    
    // Differenziamo leggermente il colore: i cluster sono blu acciaio, gli sprazzi sono più chiari
    vec3 coloreCluster = vec3(0.4, 0.55, 0.6);
    vec3 coloreSprazzo = vec3(0.55, 0.7, 0.75); // Ghiaccio/Bianco sporco
    vec3 coloreAttuale = mix(coloreCluster, coloreSprazzo, sprazzoVivo);

    // Composizione Finale
    vec3 coloreFinale = coloreSfondo;
    coloreFinale = mix(coloreFinale, coloreLinea, lineeGriglia * 0.5); // Sfondo + Griglia
    
    // Aggiungiamo l'ombra della cella passata (se non è coperta da una viva ora)
    coloreFinale = mix(coloreFinale, coloreFantasma, cellaFantasma * blocco * (1.0 - cellaViva));
    
    // Aggiungiamo la cella viva
    coloreFinale = mix(coloreFinale, coloreAttuale, cellaViva * blocco);

    // Vignettatura per oscurare i bordi dello schermo
    coloreFinale *= smoothstep(1.5, 0.4, length(p));

    fragColor = vec4(coloreFinale, 1.0);
}
