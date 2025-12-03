# Funktionsbibliotheken für Bash-Scripte

Dieses Verzeichnis enthält wiederverwendbare Funktionsbibliotheken für Bash-Scripte.

## Übersicht

### 1. `util_functions` - Allgemeine Hilfsfunktionen

**Benutzerinteraktion:**
- `ask_yes_no(frage)` - Ja/Nein-Abfrage
- `confirm_action(aktion)` - Aktion bestätigen lassen
- `read_input(prompt, validator)` - Eingabe mit Validierung

**Meldungen:**
- `error_exit(meldung, [exit_code])` - Fehlermeldung ausgeben und beenden
- `warning(meldung)` - Warnung ausgeben
- `info(meldung)` - Info-Meldung ausgeben

**Validierung:**
- `is_empty(string)` - Prüft ob String leer ist
- `is_number(wert)` - Prüft ob Wert eine Zahl ist

**Sonstiges:**
- `progress_bar(aktuell, gesamt)` - Fortschrittsbalken anzeigen

### 2. `file_functions` - Datei- und Verzeichnisfunktionen

**Existenz-Prüfungen:**
- `file_exists(pfad)` - Datei/Verzeichnis existiert
- `is_regular_file(pfad)` - Ist reguläre Datei
- `is_directory(pfad)` - Ist Verzeichnis
- `is_symlink(pfad)` - Ist symbolischer Link

**Berechtigungen:**
- `is_readable(pfad)` - Datei ist lesbar
- `is_writable(pfad)` - Datei ist schreibbar
- `is_executable(pfad)` - Datei ist ausführbar
- `get_file_permissions(pfad)` - Berechtigungen als Oktalwert

**Datei-Informationen:**
- `get_file_size(pfad)` - Größe in Bytes
- `get_file_mtime(pfad)` - Änderungsdatum (Unix-Timestamp)
- `is_empty_file(pfad)` - Datei ist leer
- `is_newer_than(datei1, datei2)` - Datei1 neuer als Datei2
- `is_older_than(datei1, datei2)` - Datei1 älter als Datei2

**Pfad-Operationen:**
- `get_absolute_path(pfad)` - Absoluten Pfad zurückgeben
- `get_filename(pfad)` - Dateiname ohne Pfad
- `get_directory(pfad)` - Verzeichnispfad ohne Dateiname
- `get_file_extension(pfad)` - Dateiendung
- `get_filename_without_extension(pfad)` - Dateiname ohne Endung

**Verzeichnis-Operationen:**
- `count_files(verzeichnis, [pattern])` - Dateien zählen
- `create_directory(pfad)` - Verzeichnis mit Parents erstellen

### 3. `math_functions` - Mathematische Funktionen

**Grundrechenarten:**
- `add(a, b)` - Addition
- `subtract(a, b)` - Subtraktion
- `multiply(a, b)` - Multiplikation
- `divide(a, b)` - Division (ganzzahlig)
- `modulo(a, b)` - Modulo-Operation

**Erweiterte Mathematik:**
- `power(basis, exponent)` - Potenzrechnung
- `factorial(n)` - Fakultät
- `abs(zahl)` - Absoluter Wert
- `gcd(a, b)` - Größter gemeinsamer Teiler
- `calc(ausdruck, [dezimalstellen])` - Gleitkomma-Berechnung mit bc

**Vergleiche:**
- `max(a, b)` - Maximum zweier Zahlen
- `min(a, b)` - Minimum zweier Zahlen
- `is_even(zahl)` - Prüft ob gerade
- `is_odd(zahl)` - Prüft ob ungerade
- `is_prime(zahl)` - Prüft ob Primzahl

**Listen-Operationen:**
- `sum(zahlen...)` - Summe aller Zahlen
- `average(zahlen...)` - Durchschnitt
- `find_max(zahlen...)` - Größte Zahl
- `find_min(zahlen...)` - Kleinste Zahl

### 4. `number_validation` - Zahlenvalidierung und -verarbeitung

**Validierungsfunktionen:**
- `is_int(wert)` - Prüft ob ganze Zahl (mit optionalem Vorzeichen), Return: 0=ja, 1=nein
- `is_num(wert)` - Prüft ob Zahl mit/ohne Nachkommastellen (Dezimalpunkt `.`), Return: 0=ja, 1=nein

**Verarbeitungsfunktionen:**
- `sum_up(zahlen...)` - Summiert ganze Zahlen, ignoriert ungültige Werte
  - Ausgabe: Summe auf stdout
  - Return: 0=alle gültig, 1=mindestens ein ungültiger Wert oder keine gültigen Zahlen

## Verwendung

### 1. FNCPATH-Variable setzen

Die Variable `FNCPATH` wurde bereits in Ihrer `.bashrc` hinzugefügt:

```bash
export FNCPATH="$HOME/LinuxBash/functionLib"
```

Nach erneutem Login oder mit `source ~/.bashrc` aktivieren.

### 2. Bibliotheken einbinden

In Ihrem Script:

```bash
#!/bin/bash

# Einzelne Bibliothek laden
source "$FNCPATH/util_functions"

# Oder mit Punkt-Notation
. "$FNCPATH/file_functions"

# Mehrere Bibliotheken
source "$FNCPATH/util_functions"
source "$FNCPATH/file_functions"
source "$FNCPATH/math_functions"
```

### 3. Funktionen verwenden

```bash
#!/bin/bash

source "$FNCPATH/util_functions"
source "$FNCPATH/file_functions"

# Beispiel: Datei mit Bestätigung löschen
if file_exists "meinedatei.txt"; then
    if confirm_action "Datei löschen"; then
        rm meinedatei.txt
        info "Datei wurde gelöscht"
    else
        warning "Löschvorgang abgebrochen"
    fi
else
    error_exit "Datei nicht gefunden"
fi
```

## Beispiele

### Test-Scripts ausführen

```bash
cd /home/nikluy/LinuxBash/functionLib

# Alle Basis-Funktionen testen
./test_function_libs.sh

# Zahlenvalidierung testen (umfassend)
./test_number_validation.sh

# Zahlenvalidierung Demo
./demo_number_validation.sh

# Mit eigenen Werten testen
./demo_number_validation.sh 100 200 abc 300
```

### Interaktives Beispiel

```bash
chmod +x example_usage.sh
./example_usage.sh
```

### number_validation Beispiele

```bash
#!/bin/bash
source "$FNCPATH/number_validation"

# Beispiel 1: Ganze Zahl prüfen
if is_int "$user_input"; then
    echo "Gültige ganze Zahl"
fi

# Beispiel 2: Dezimalzahl prüfen
if is_num "$value"; then
    echo "Gültige Zahl (auch mit Dezimalpunkt)"
fi

# Beispiel 3: Zahlen summieren
result=$(sum_up 10 20 30 abc 40)
exit_code=$?
echo "Summe: $result"
if [ $exit_code -eq 1 ]; then
    echo "Warnung: Ungültige Werte wurden ignoriert"
fi
```

## Tipps

1. **Nur benötigte Bibliotheken laden** - Für bessere Performance nur die wirklich benötigten Funktionen einbinden

2. **Fehlerbehandlung** - Prüfen Sie ob FNCPATH gesetzt ist:
   ```bash
   if [ -z "$FNCPATH" ]; then
       export FNCPATH="$HOME/LinuxBash/functionLib"
   fi
   ```

3. **Eigene Funktionen hinzufügen** - Erweitern Sie die Bibliotheken nach Bedarf

4. **Dokumentation** - Jede Funktion ist mit Kommentaren dokumentiert (Parameter, Rückgabewerte, Ausgaben)

## Verzeichnisstruktur

```
functionLib/
├── README.md                      # Diese Datei
├── util_functions                 # Allgemeine Hilfsfunktionen
├── file_functions                 # Datei- und Verzeichnisfunktionen
├── math_functions                 # Mathematische Funktionen
├── number_validation              # Zahlenvalidierung und -verarbeitung
├── test_function_libs.sh          # Automatischer Test (util, file, math)
├── test_number_validation.sh      # Umfassender Test für number_validation
├── demo_number_validation.sh      # Demo für number_validation
└── example_usage.sh               # Interaktives Beispielprogramm
```

## Lizenz und Verwendung

Diese Funktionsbibliotheken sind frei verwendbar für Lern- und Produktivzwecke.
