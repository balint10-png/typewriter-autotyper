# typewriter-autotyper
Typewriter Auto-Typer (Tampermonkey + AutoHotkey)
Ein zweiteiliges Tool für typewriter.at. Das System liest den geforderten Übungstext automatisch aus und wandelt beliebige Tasteneingaben auf deiner Hardware-Tastatur in die exakt richtigen Zeichen um.

Features
Automatische Text-Synchronisation: Das Tampermonkey-Skript liest nachgeladene Textabschnitte aus und schreibt sie im Hintergrund in die Zwischenablage.

Smart Key-Mapping: Tippe in deinem eigenen Rhythmus auf beliebige Tasten – das AutoHotkey-Skript gibt immer das nächste korrekte Zeichen aus.

Menschliche Fehlersimulation: Einstellbare Tippfehler-Quote. Der Bot baut auf Wunsch zufällige Fehler ein, zögert kurz, löscht das falsche Zeichen per Backspace und schreibt korrekt weiter.

Sicherheits-Hotkeys: F2 zum Ein- und Ausschalten sowie ESC für den Notfall-Stopp.

Voraussetzungen
Browser-Erweiterung Tampermonkey

AutoHotkey v2.0 (unter Windows)

Installation & Einrichtung
1. Tampermonkey Userscript
Öffne das Tampermonkey-Dashboard in deinem Browser.

Erstelle ein neues Skript und füge den Code aus scraper.user.js ein.

Speichere das Skript mit Strg + S.

2. AutoHotkey Skript
Lade die Datei autotyper.ahk aus diesem Repository herunter.

Starte die Datei per Doppelklick. Ein grünes H-Symbol in der Windows-Taskleiste zeigt an, dass das Skript aktiv ist.

Nutzung
Starte eine Übung auf typewriter.at.

Klicke einmal in das Eingabefeld der Webseite, damit der Cursor dort blinkt.

Drücke F2, um den Bot zu aktivieren (Bestätigung AKTIVIERT erscheint oben links).

Tippe auf der Tastatur los.

Drücke erneut F2 oder ESC, um den Bot zu deaktivieren.

Einstellungen
Du kannst die Fehlerquote direkt in der Datei autotyper.ahk im Texteditor anpassen
