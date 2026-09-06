#Requires AutoHotkey v2.0

; ==============================================================================
; ====== EINSTELLUNGEN =========================================================
; ==============================================================================

global ErrorRate := 2 ; Fehlerquote in % (z.B. 5 = ca. 5% Tippfehler)

; ==============================================================================

global currentText := ""
global textIndex := 1
global Alphabet := "abcdefghijklmnopqrstuvwxyz"
global ih := InputHook()

; Hook-Konfiguration: Alle Tasten abfangen
ih.KeyOpt("{All}", "N S")

; F2 und ESC explizit vom Blockieren freistellen!
ih.KeyOpt("{F2}{Esc}", "-S -N")

ih.OnKeyDown := OnAnyKeyPress

; --- F2: Modus EIN / AUS ---
F2:: {
    global ih, currentText, textIndex
    if (ih.InProgress) {
        StopBot("Manueller Modus DEAKTIVIERT")
    } else {
        currentText := A_Clipboard
        textIndex := 1
        if (currentText == "") {
            ShowStatus("Fehler: Keine Daten in der Zwischenablage!")
            return
        }
        ih.Start()
        ShowStatus("AKTIVIERT! Tippe auf der Tastatur! (F2/ESC = Aus)")
    }
}

; --- ESC: Notfall-Stopp ---
~Esc:: {
    if (ih.InProgress) {
        StopBot("Notfall-Stopp!")
    }
}

StopBot(msg) {
    global ih
    if (ih.InProgress) {
        ih.Stop()
    }
    ShowStatus(msg)
}

ShowStatus(msg) {
    ToolTip msg
    SetTimer () => ToolTip(), -2500
}

OnAnyKeyPress(ihObj, VK, SC) {
    global currentText, textIndex, ErrorRate, Alphabet
    
    ; Falls Ende des Chunks erreicht: Zwischenablage neu einlesen
    if (textIndex > StrLen(currentText)) {
        currentText := A_Clipboard
        textIndex := 1
    }
    
    if (currentText == "" || textIndex > StrLen(currentText)) {
        StopBot("Fertig / Kein Text vorhanden.")
        return
    }

    currentChar := SubStr(currentText, textIndex, 1)

    ; WICHTIG: Hook KURZ stoppen, damit SendText nicht vom Hook selbst verschluckt wird!
    ihObj.Stop()

    ; --- FEHLER-SIMULATION ---
    ; Prüft bei Buchstaben, ob ein Zufalls-Fehler eingebaut wird
    if (ErrorRate > 0 && RegExMatch(currentChar, "[a-zA-Z]") && Random(1, 100) <= ErrorRate) {
        wrongChar := SubStr(Alphabet, Random(1, StrLen(Alphabet)), 1)
        
        ; 1. Falsches Zeichen tippen
        SendText wrongChar
        
        ; 2. Kurz zögern (Mensch bemerkt Fehler)
        Sleep Random(100, 180)
        
        ; 3. Backspace drücken zum Löschen
        Send "{Backspace}"
        
        ; 4. Pause vor Korrektur
        Sleep Random(50, 100)
    }

    ; --- RICHTIGES ZEICHEN TIPPE N ---
    SendText currentChar
    textIndex++

    ; Hook sofort wieder starten für deinen NÄCHSTEN Anschlag!
    ihObj.Start()
}