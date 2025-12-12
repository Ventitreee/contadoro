# ContaDORO

App iOS (SwiftUI) per contare quanti panini mangi ogni giorno, con statistiche settimanali e mensili in locale (solo offline).

## Struttura
- `ContaDORO/ContaDOROApp.swift`: entry point con TabView (Oggi + Statistiche).
- `ContaDORO/CounterView.swift`: schermo principale con pulsante panino e conteggio del giorno.
- `ContaDORO/StatsView.swift`: riepilogo settimana/mese/streak e lista storico.
- `ContaDORO/Models.swift`: store con persistenza locale (UserDefaults) e calcolo statistiche.
- `ContaDORO/Theme.swift`: palette anni '80.

## Assets
Metti il logo nelle risorse Xcode:
1. Apri `ContaDORO.xcodeproj` (creala da Xcode usando App iOS SwiftUI e sostituisci i file con questi).
2. In `Assets.xcassets`, aggiungi:
   - App Icon con il logo (`dorolungo.png` o `Dorooriginale.png`).
   - Un `Image Set` chiamato `SandwichIcon` se vuoi usare un'immagine al posto dell'icona disegnata; altrimenti il pulsante usa il disegno SwiftUI incluso.

## Note di design
- Palette neon: rosa/verde/mostarda su sfondo viola scuro, vibe anni '80.
- Pulsante centrale con gradiente e icona panino agli spinaci disegnata in SwiftUI (`SandwichIcon`).

## Build
1. Crea un nuovo progetto iOS App (SwiftUI) in Xcode chiamato `ContaDORO`.
2. Sostituisci i file generati con quelli in `ContaDORO/`.
3. Seleziona un target minimo iOS 16+ (consigliato) e builda su simulator/dispositivo.

## Funzionalità
- Tap sul bottone aggiunge un panino al giorno corrente.
- Statistiche calcolate localmente: oggi, settimana, mese, streak giornaliera.
- Storico giornaliero ordinato dal più recente.

## Versione PC (offline, browser)
- Apri `web/index.html` con Chrome/Edge/Firefox (doppio click da PC).
- Salva dati in locale via localStorage, nessuna connessione richiesta.
- Schermate: contatore giornaliero, riepilogo, grafico ultimi 7 giorni e storico.
- Logo: `web/dorolungo.png` gia incluso; sostituiscilo con il tuo file mantenendo lo stesso nome per aggiornarlo.
