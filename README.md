# Linux Kurs - Bash Scripts

This repository contains scripts and exercises for the Linux course.

## Structure

- `config.sh` - Common configuration variables (WD, KURS_DIR, colors)
- `scripts/` - All course scripts
- `working_dir/` - Working directory for outputs (git ignored)

## Configuration

The `config.sh` file contains common variables used across all scripts:
- `WD` - Working directory path (default: "working_dir")
- `KURS_DIR` - Course structure directory (default: "$WD/Kurs")
- Color variables for terminal output

To use in your scripts:
```bash
# Source the configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

# Use the variables
ensure_working_dir
echo "Output will go to: $WD"
```

## Usage

All scripts should output to the `working_dir/` directory. This directory is ignored by Git to keep the repository clean.

Run scripts from the repository root:
```bash
./scripts/script_name.sh
```

## Scripts

### Course Setup
- `create_kurs_structure.sh` - Creates the course folder structure (blocks 1-5 with aufgaben/loesungen subdirectories)
- `mkscript.sh` - Creates a new bash script with standard header template (description, author, version, date)
- `test_mkscript.sh` - Tests the mkscript.sh script
- `example_with_config.sh` - Example showing how to use the common configuration

### Parameters
- `show_params.sh` - Displays script parameters ($1-$9, $@, $#)
- `test_params.sh` - Tests the show_params.sh script with different parameters

### Redirection Demos
- `demo_stdout_stderr.sh` - Basic stdout and stderr demonstration
- `demo_redirections.sh` - Common redirection techniques (>, >>, 2>, &>)
- `demo_pipes_and_tee.sh` - Pipes and tee command examples
- `demo_advanced_redirections.sh` - Advanced techniques (heredocs, process substitution, etc.)
- `test_all_redirections.sh` - Run all redirection demos in sequence

See `REDIRECTION_CHEATSHEET.md` for quick reference!
