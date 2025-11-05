#!/bin/bash
# test_cmd_path.sh
# Demonstrates file test operators: -e, -f, -x, -d, -w, -r

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

# Ensure working directory exists
ensure_working_dir

echo -e "${GREEN}=== File Test Operators Demo ===${NC}\n"

# Create test files and directories in working_dir
TEST_DIR="$WD/test_files"
mkdir -p "$TEST_DIR"

# Create different test files
TEST_FILE="$TEST_DIR/testfile.txt"
TEST_SCRIPT="$TEST_DIR/testscript.sh"
TEST_READONLY="$TEST_DIR/readonly.txt"
TEST_NOREAD="$TEST_DIR/noread.txt"
TEST_SUBDIR="$TEST_DIR/subdir"
NONEXISTENT="$TEST_DIR/does_not_exist.txt"

# Create test file
echo "This is a test file" > "$TEST_FILE"

# Create executable script
echo "#!/bin/bash" > "$TEST_SCRIPT"
echo "echo 'Hello'" >> "$TEST_SCRIPT"
chmod +x "$TEST_SCRIPT"

# Create read-only file
echo "Read-only content" > "$TEST_READONLY"
chmod 444 "$TEST_READONLY"

# Create non-readable file (only if we have permissions)
echo "No read access" > "$TEST_NOREAD"
chmod 000 "$TEST_NOREAD" 2>/dev/null || chmod 200 "$TEST_NOREAD"

# Create subdirectory
mkdir -p "$TEST_SUBDIR"

echo -e "${YELLOW}Test Files Created:${NC}"
echo "  $TEST_FILE (normal file)"
echo "  $TEST_SCRIPT (executable script)"
echo "  $TEST_READONLY (read-only)"
echo "  $TEST_NOREAD (no read permission)"
echo "  $TEST_SUBDIR (directory)"
echo "  $NONEXISTENT (does not exist)"
echo ""

echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Test -e (exists)
echo -e "${YELLOW}Test: [ -e \$name ] → File/Directory exists${NC}"
echo "──────────────────────────────────────────────"

name="$TEST_FILE"
if [ -e "$name" ]; then
    echo "✓ [ -e $name ] → TRUE: existiert"
else
    echo "✗ [ -e $name ] → FALSE: existiert nicht"
fi

name="$NONEXISTENT"
if [ -e "$name" ]; then
    echo "✓ [ -e $name ] → TRUE: existiert"
else
    echo "✗ [ -e $name ] → FALSE: existiert nicht"
fi

name="$TEST_SUBDIR"
if [ -e "$name" ]; then
    echo "✓ [ -e $name ] → TRUE: existiert (auch für Verzeichnisse)"
else
    echo "✗ [ -e $name ] → FALSE: existiert nicht"
fi

echo ""

# Test -f (is regular file)
echo -e "${YELLOW}Test: [ -f \$name ] → Is regular file${NC}"
echo "──────────────────────────────────────────────"

name="$TEST_FILE"
if [ -f "$name" ]; then
    echo "✓ [ -f $name ] → TRUE: ist eine normale Datei"
else
    echo "✗ [ -f $name ] → FALSE: ist keine normale Datei"
fi

name="$TEST_SUBDIR"
if [ -f "$name" ]; then
    echo "✓ [ -f $name ] → TRUE: ist eine normale Datei"
else
    echo "✗ [ -f $name ] → FALSE: ist keine normale Datei (ist Verzeichnis)"
fi

name="$NONEXISTENT"
if [ -f "$name" ]; then
    echo "✓ [ -f $name ] → TRUE: ist eine normale Datei"
else
    echo "✗ [ -f $name ] → FALSE: existiert nicht"
fi

echo ""

# Test -x (is executable)
echo -e "${YELLOW}Test: [ -x \$name ] → Is executable${NC}"
echo "──────────────────────────────────────────────"

name="$TEST_SCRIPT"
if [ -x "$name" ]; then
    echo "✓ [ -x $name ] → TRUE: ist ausführbar"
else
    echo "✗ [ -x $name ] → FALSE: ist nicht ausführbar"
fi

name="$TEST_FILE"
if [ -x "$name" ]; then
    echo "✓ [ -x $name ] → TRUE: ist ausführbar"
else
    echo "✗ [ -x $name ] → FALSE: ist nicht ausführbar"
fi

name="$TEST_SUBDIR"
if [ -x "$name" ]; then
    echo "✓ [ -x $name ] → TRUE: Verzeichnis ist betretbar"
else
    echo "✗ [ -x $name ] → FALSE: Verzeichnis nicht betretbar"
fi

echo ""

# Test -d (is directory)
echo -e "${YELLOW}Test: [ -d \$name ] → Is directory${NC}"
echo "──────────────────────────────────────────────"

name="$TEST_SUBDIR"
if [ -d "$name" ]; then
    echo "✓ [ -d $name ] → TRUE: ist ein Verzeichnis"
else
    echo "✗ [ -d $name ] → FALSE: ist kein Verzeichnis"
fi

name="$TEST_FILE"
if [ -d "$name" ]; then
    echo "✓ [ -d $name ] → TRUE: ist ein Verzeichnis"
else
    echo "✗ [ -d $name ] → FALSE: ist kein Verzeichnis (ist Datei)"
fi

name="$NONEXISTENT"
if [ -d "$name" ]; then
    echo "✓ [ -d $name ] → TRUE: ist ein Verzeichnis"
else
    echo "✗ [ -d $name ] → FALSE: existiert nicht"
fi

echo ""

# Test -w (is writable)
echo -e "${YELLOW}Test: [ -w \$name ] → Is writable${NC}"
echo "──────────────────────────────────────────────"

name="$TEST_FILE"
if [ -w "$name" ]; then
    echo "✓ [ -w $name ] → TRUE: ist beschreibbar"
else
    echo "✗ [ -w $name ] → FALSE: ist nicht beschreibbar"
fi

name="$TEST_READONLY"
if [ -w "$name" ]; then
    echo "✓ [ -w $name ] → TRUE: ist beschreibbar"
else
    echo "✗ [ -w $name ] → FALSE: ist nicht beschreibbar (read-only)"
fi

echo ""

# Test -r (is readable)
echo -e "${YELLOW}Test: [ -r \$name ] → Is readable${NC}"
echo "──────────────────────────────────────────────"

name="$TEST_FILE"
if [ -r "$name" ]; then
    echo "✓ [ -r $name ] → TRUE: ist lesbar"
else
    echo "✗ [ -r $name ] → FALSE: ist nicht lesbar"
fi

name="$TEST_READONLY"
if [ -r "$name" ]; then
    echo "✓ [ -r $name ] → TRUE: ist lesbar (auch wenn read-only)"
else
    echo "✗ [ -r $name ] → FALSE: ist nicht lesbar"
fi

name="$TEST_NOREAD"
if [ -r "$name" ]; then
    echo "✓ [ -r $name ] → TRUE: ist lesbar"
else
    echo "✗ [ -r $name ] → FALSE: ist nicht lesbar (keine Leserechte)"
fi

echo ""
echo -e "${GREEN}=== File Test Operators Summary ===${NC}"
echo "  -e  →  exists (existiert - Datei oder Verzeichnis)"
echo "  -f  →  is regular file (ist normale Datei, kein Verzeichnis)"
echo "  -x  →  is executable (ist ausführbar / bei Verz.: betretbar)"
echo "  -d  →  is directory (ist Verzeichnis)"
echo "  -w  →  is writable (ist beschreibbar)"
echo "  -r  →  is readable (ist lesbar)"
echo ""
echo -e "${YELLOW}Test files are in: $TEST_DIR${NC}"
echo "To clean up: rm -rf $TEST_DIR"
