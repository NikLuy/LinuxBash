#!/bin/bash
# example_usage.sh - Beispiel für die Verwendung der Funktionsbibliotheken

# Prüfen ob FNCPATH gesetzt ist, sonst setzen
if [ -z "$FNCPATH" ]; then
    export FNCPATH="$HOME/LinuxBash/functionLib"
fi

# Nur die benötigten Bibliotheken laden
source "$FNCPATH/util_functions"
source "$FNCPATH/file_functions"
source "$FNCPATH/math_functions"

# Beispiel 1: Datei-Backup mit Bestätigung
backup_file() {
    local source_file="$1"
    
    # Prüfen ob Datei existiert
    if ! file_exists "$source_file"; then
        error_exit "Datei '$source_file' nicht gefunden"
    fi
    
    # Dateigröße anzeigen
    local size=$(get_file_size "$source_file")
    info "Dateigröße: $size Bytes"
    
    # Bestätigung einholen
    if confirm_action "Backup von $(get_filename "$source_file") erstellen"; then
        local backup_name="${source_file}.backup.$(date +%Y%m%d)"
        cp "$source_file" "$backup_name"
        info "Backup erstellt: $backup_name"
    else
        warning "Backup abgebrochen"
    fi
}

# Beispiel 2: Rechner mit Eingabevalidierung
calculator() {
    info "Einfacher Rechner"
    
    read_input "Erste Zahl" is_number
    local num1=$REPLY
    
    read_input "Zweite Zahl" is_number
    local num2=$REPLY
    
    echo "Ergebnisse:"
    echo "  Addition:       $num1 + $num2 = $(add $num1 $num2)"
    echo "  Subtraktion:    $num1 - $num2 = $(subtract $num1 $num2)"
    echo "  Multiplikation: $num1 * $num2 = $(multiply $num1 $num2)"
    
    if [ $num2 -ne 0 ]; then
        echo "  Division:       $num1 / $num2 = $(divide $num1 $num2)"
        echo "  Modulo:         $num1 % $num2 = $(modulo $num1 $num2)"
    else
        warning "Division durch Null nicht möglich"
    fi
    
    echo "  Maximum:        max($num1, $num2) = $(max $num1 $num2)"
    echo "  Minimum:        min($num1, $num2) = $(min $num1 $num2)"
}

# Beispiel 3: Verzeichnis-Analyse
analyze_directory() {
    local dir="${1:-.}"
    
    if ! is_directory "$dir"; then
        error_exit "'$dir' ist kein Verzeichnis"
    fi
    
    info "Analysiere Verzeichnis: $(get_absolute_path "$dir")"
    echo ""
    
    # Dateien zählen
    local file_count=$(count_files "$dir")
    info "Anzahl Dateien: $file_count"
    
    # Verschiedene Dateitypen analysieren
    local txt_count=$(count_files "$dir" "*.txt")
    local sh_count=$(count_files "$dir" "*.sh")
    
    echo "  - Text-Dateien (.txt): $txt_count"
    echo "  - Shell-Scripte (.sh): $sh_count"
    echo ""
    
    # Berechtigungen prüfen
    info "Erste 5 Dateien mit Berechtigungen:"
    local count=0
    for file in "$dir"/*; do
        if [ -f "$file" ] && [ $count -lt 5 ]; then
            local perms=$(get_file_permissions "$file")
            local size=$(get_file_size "$file")
            echo "  $(get_filename "$file"): $perms ($size Bytes)"
            count=$((count + 1))
        fi
    done
}

# Hauptmenü
show_menu() {
    echo ""
    echo "=========================================="
    echo "  Funktionsbibliotheken - Beispiele"
    echo "=========================================="
    echo "1) Datei-Backup erstellen"
    echo "2) Rechner"
    echo "3) Verzeichnis analysieren"
    echo "4) Primzahlen-Test"
    echo "5) Beenden"
    echo "=========================================="
}

# Primzahlen-Test
test_primes() {
    info "Primzahlen-Prüfung"
    read_input "Zahl eingeben" is_number
    local num=$REPLY
    
    if is_prime $num; then
        info "$num ist eine Primzahl"
    else
        info "$num ist keine Primzahl"
    fi
    
    # Primzahlen bis n ausgeben
    if ask_yes_no "Alle Primzahlen bis $num anzeigen?"; then
        echo -n "Primzahlen: "
        for ((i=2; i<=num; i++)); do
            if is_prime $i; then
                echo -n "$i "
            fi
        done
        echo ""
    fi
}

# Hauptprogramm
main() {
    while true; do
        show_menu
        read -p "Wahl [1-5]: " choice
        
        case $choice in
            1)
                read -p "Dateipfad: " filepath
                backup_file "$filepath"
                ;;
            2)
                calculator
                ;;
            3)
                read -p "Verzeichnis [. für aktuelles]: " dir
                dir=${dir:-.}
                analyze_directory "$dir"
                ;;
            4)
                test_primes
                ;;
            5)
                info "Programm wird beendet"
                exit 0
                ;;
            *)
                warning "Ungültige Auswahl"
                ;;
        esac
        
        echo ""
        read -p "Drücken Sie Enter zum Fortfahren..."
    done
}

# Programm starten, wenn direkt ausgeführt
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    main
fi
