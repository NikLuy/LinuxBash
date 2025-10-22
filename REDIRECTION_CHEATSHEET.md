# Bash Redirection Cheat Sheet

## Basic Redirections

| Syntax | Description | Example |
|--------|-------------|---------|
| `cmd > file` | Redirect stdout to file (overwrite) | `echo "text" > output.txt` |
| `cmd >> file` | Redirect stdout to file (append) | `echo "text" >> output.txt` |
| `cmd 2> file` | Redirect stderr to file | `ls /bad 2> errors.txt` |
| `cmd 2>> file` | Redirect stderr to file (append) | `ls /bad 2>> errors.txt` |
| `cmd &> file` | Redirect both stdout and stderr | `cmd &> all.txt` |
| `cmd > file 2>&1` | Redirect both (alternate syntax) | `cmd > all.txt 2>&1` |
| `cmd < file` | Redirect file to stdin | `sort < input.txt` |
| `cmd > /dev/null` | Discard stdout | `echo "silent" > /dev/null` |
| `cmd 2> /dev/null` | Discard stderr | `ls /bad 2> /dev/null` |
| `cmd &> /dev/null` | Discard everything | `cmd &> /dev/null` |

## File Descriptors

- **0** = stdin (standard input)
- **1** = stdout (standard output)
- **2** = stderr (standard error)

## Pipes

| Syntax | Description | Example |
|--------|-------------|---------|
| `cmd1 \| cmd2` | Pipe stdout of cmd1 to stdin of cmd2 | `cat file \| grep "text"` |
| `cmd1 2>&1 \| cmd2` | Pipe both stdout and stderr | `ls /bad 2>&1 \| grep "No"` |
| `cmd \| tee file` | Send output to file AND stdout | `echo "hi" \| tee out.txt` |
| `cmd \| tee -a file` | Append to file AND stdout | `echo "hi" \| tee -a out.txt` |

## Advanced Techniques

### Here Documents
```bash
cat <<EOF
Multiple lines
of text
EOF
```

### Here Strings
```bash
grep "pattern" <<< "search this string"
```

### Process Substitution
```bash
diff <(cmd1) <(cmd2)
```

### Swap stdout and stderr
```bash
cmd 3>&1 1>&2 2>&3
```

### Separate stdout and stderr
```bash
cmd > stdout.txt 2> stderr.txt
```

## Common Patterns

### Silent execution (ignore all output)
```bash
cmd &> /dev/null
```

### Log both output and errors
```bash
cmd > output.log 2>&1
# or
cmd &> output.log
```

### See output AND save to file
```bash
cmd | tee output.txt
```

### Pipe errors through grep
```bash
cmd 2>&1 | grep "ERROR"
```

### Append both stdout and stderr
```bash
cmd >> output.log 2>&1
```

## Practice Examples

Run the demo scripts to see these in action:
- `./scripts/demo_stdout_stderr.sh` - Basic stdout/stderr
- `./scripts/demo_redirections.sh` - Common redirections
- `./scripts/demo_pipes_and_tee.sh` - Pipes and tee
- `./scripts/demo_advanced_redirections.sh` - Advanced techniques
- `./scripts/test_all_redirections.sh` - Run all demos
