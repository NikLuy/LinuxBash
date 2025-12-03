PS3='Geben sie eine Zahl ein: '
select opt in "Brot" "Milch" "Eier" "Ende"; do
    case $opt in
        "Brot")
            echo "Sie haben Brot gewählt."
            ;;
        "Milch")
            echo "Sie haben Milch gewählt."
            ;;
        "Eier")
            echo "Sie haben Eier gewählt."
            ;;
        "Ende")
            echo "Programm wird beendet."
            break
            ;;
        *)
            echo "Ungültige Option. Bitte erneut versuchen."
            ;;
    esac
done