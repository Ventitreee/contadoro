# ContaDORO 2.0

Versione web di ContaDORO. Conta i DORO giornalieri con statistiche, storico e report stampabile. Tutto gira in locale nel browser tramite localStorage.

## Struttura
- `docs/index.html`: app web 2.0.
- `docs/*.png`: loghi e immagini usati come sfondo, pulsanti e report.

## Funzioni
- Conteggio giornaliero con pulsante DORO.
- Statistiche: oggi, settimana, mese, streak.
- Grafico ultimi 7 giorni.
- Storico completo.
- Report con grafici e stampa PDF (include loghi).

## Avvio locale
Opzione semplice: apri `docs/index.html` con Chrome/Edge/Firefox.

Opzione server locale:
```
cd "C:\Users\Michelebr\OneDrive - ESA engineering\Desktop\Apps\prova app\docs"
python -m http.server 8080
```
Poi apri `http://localhost:8080`.

## GitHub Pages
Per pubblicare solo la 2.0:
- Settings ? Pages
- Source: Deploy from a branch
- Branch: `contadoro-2.0`
- Folder: `/docs`

## Dati
I dati restano nel browser (localStorage). Non sono condivisi tra dispositivi.
