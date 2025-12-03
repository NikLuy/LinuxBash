#!/bin/bash
# aufgabe-02.sh - Zeigt den Inhalt eines TAR-Archivs sortiert an

# Hilfsfunktion für Fehlerausgabe
usage() {
    echo "usage: aufgabe-02.sh [-s ASC|DESC] [-l] tar-archive" >&2
    echo "       aufgabe-02.sh [-n ASC|DESC] [-l] tar-archive" >&2
    echo "       aufgabe-02.sh -h" >&2
    exit 1
}

# Variablen initialisieren
sort_by=""
sort_order=""
count_files=0
help_mode=0
tarfile=""

# Optionen parsen
while getopts "s:n:lh" opt; do
    case $opt in
        s)
            if [ -n "$sort_by" ]; then
                usage
            fi
            sort_by="size"
            sort_order="$OPTARG"
            if [ "$sort_order" != "ASC" ] && [ "$sort_order" != "DESC" ]; then
                usage
            fi
            ;;
        n)
            if [ -n "$sort_by" ]; then
                usage
            fi
            sort_by="name"
            sort_order="$OPTARG"
            if [ "$sort_order" != "ASC" ] && [ "$sort_order" != "DESC" ]; then
                usage
            fi
            ;;
        l)
            count_files=1
            ;;
        h)
            help_mode=1
            ;;
        ?)
            usage
            ;;
    esac
done

# Prüfen ob -h mit anderen Optionen kombiniert wurde
if [ $help_mode -eq 1 ]; then
    if [ $OPTIND -gt 2 ]; then
        usage
    fi
    echo "usage: aufgabe-02.sh [-s ASC|DESC] [-l] tar-archive" >&2
    echo "       aufgabe-02.sh [-n ASC|DESC] [-l] tar-archive" >&2
    echo "       aufgabe-02.sh -h" >&2
    exit 0
fi

# Zum letzten Argument shiften (Dateiname)
shift $((OPTIND - 1))

# Prüfen ob Dateiname angegeben wurde
if [ $# -eq 0 ]; then
    usage
fi

tarfile="$1"

# Fehlerbehandlung: Datei existiert nicht
if [ ! -e "$tarfile" ]; then
    echo "error: file $tarfile not found" >&2
    exit 1
fi

# Fehlerbehandlung: Datei ist nicht lesbar oder kein TAR-Archiv
if ! tar -tzf "$tarfile" >/dev/null 2>&1; then
    echo "error: tar archive $tarfile cannot be opened" >&2
    exit 1
fi

# TAR-Inhalt auflisten und sortieren
if [ -z "$sort_by" ]; then
    # Keine Sortierung angegeben - Standardausgabe
    tar -tvf "$tarfile"
elif [ "$sort_by" = "size" ]; then
    # Nach Größe sortieren (Spalte 3)
    if [ "$sort_order" = "ASC" ]; then
        tar -tvf "$tarfile" | sort -k3 -n
    else
        tar -tvf "$tarfile" | sort -k3 -nr
    fi
elif [ "$sort_by" = "name" ]; then
    # Nach Namen sortieren (Spalte 6)
    if [ "$sort_order" = "ASC" ]; then
        tar -tvf "$tarfile" | sort -k6
    else
        tar -tvf "$tarfile" | sort -k6 -r
    fi
fi

# Anzahl der Dateien ausgeben, wenn -l gesetzt
if [ $count_files -eq 1 ]; then
    file_count=$(tar -tzf "$tarfile" | wc -l)
    echo "$file_count items in tar archive"
fi

exit 0
