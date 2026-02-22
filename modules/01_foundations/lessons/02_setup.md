# Lesson 1.2: Environment Setup

## Learning Objectives

- [ ] Install Zig on your system
- [ ] Verify the installation works
- [ ] Understand basic project structure
- [ ] Run your first Zig command

## Prerequisites

- Command line familiarity (terminal, shell basics)
- A text editor (VS Code recommended)

## Installing Zig

**Check the official installation instructions:**
- [ziglang.org/learn/getting-started](https://ziglang.org/learn/getting-started/) — official guide
- [zig.guide/getting-started/installation](https://zig.guide/getting-started/installation/) — community guide with more detail

Both pages have up-to-date instructions for all platforms.

### Option 1: Official Download Page (Recommended)

Visit [ziglang.org/learn/getting-started](https://ziglang.org/learn/getting-started/) and follow the instructions for your platform. The page provides:
- Direct download links
- curl/wget one-liners for Linux
- Installation instructions for each platform

After downloading and extracting, add the Zig directory to your PATH:

**Linux/macOS:**
```bash
# Add to ~/.bashrc or ~/.zshrc
export PATH=$PATH:/path/to/zig
```

**Windows:**
Add the extracted folder to your system PATH via Environment Variables.

### Option 2: Package Managers

```bash
# macOS (Homebrew)
brew install zig

# Arch Linux
pacman -S zig

# Ubuntu/Debian (via snap)
sudo snap install zig --classic --beta
```

Note: Package managers may lag behind the latest release.

### Option 3: zigup (Version Manager)

Useful if you need to switch between versions:
```bash
# See https://github.com/marler/zigup for installation
zigup master  # or a specific version
```

## Verify Installation

```bash
zig version
```

You should see the current stable version (e.g., `0.15.2`).

If you see "command not found," check your PATH.

## Editor Setup

### VS Code (Recommended)

1. Install the "Zig Language" extension by ziglang
2. The extension provides:
   - Syntax highlighting
   - Error diagnostics
   - Auto-formatting
   - Go to definition

### Other Editors

- **Vim/Neovim**: Use `ziglang/zig.vim` or LSP with `zls`
- **Emacs**: Use `zig-mode`
- **Sublime Text**: Use Zig package

### Zig Language Server (ZLS)

For advanced features, install ZLS:
```bash
# Check https://github.com/zigtools/zls for instructions
# It provides:
# - Autocomplete
# - Hover documentation
# - Go to definition
```

## Project Structure

A typical Zig project looks like:

```
my-project/
├── build.zig          # Build configuration
├── build.zig.zon      # Dependencies
├── src/
│   └── main.zig       # Main source file
└── zig-out/           # Build output (generated)
```

### Creating a New Project

```bash
# Create directory
mkdir my-project
cd my-project

# Initialize with default files
zig init
```

This creates:
- `build.zig` - Build system configuration
- `src/main.zig` - Your main source file

## Basic Zig Commands

| Command | Purpose |
|---------|---------|
| `zig version` | Show Zig version |
| `zig init` | Initialize a new project |
| `zig build` | Build the project |
| `zig run src/main.zig` | Compile and run directly |
| `zig test src/main.zig` | Run tests in a file |
| `zig fmt src/main.zig` | Format code |

## Your First Command

Let's verify everything works. There's a `scratch/hello.zig` in this repo:

```bash
cat scratch/hello.zig
```

```zig
const std = @import("std");

pub fn main() void {
    std.debug.print("Zig works!\n", .{});
}
```

Run it:

```bash
zig run scratch/hello.zig
```

Expected output:
```
Zig works!
```

The `scratch/` directory is for quick experiments — feel free to add files there.

## For Python Developers

| Python | Zig | Notes |
|--------|-----|-------|
| `python script.py` | `zig run script.zig` | Direct execution |
| `python -c "..."` | Write to file, then run | No inline execution |
| `pip install` | `build.zig.zon` + `zig fetch` | Dependency management |
| `pytest` | `zig test` | Built-in test runner |
| `black/ruff` | `zig fmt` | Built-in formatter |

### No REPL

Unlike Python, Zig has no REPL (interactive mode). You always:
1. Write code to a file
2. Compile/run with `zig run` or `zig build`

This seems slower but ensures you always have reproducible code.

## Troubleshooting

### "command not found: zig"

Your PATH isn't set correctly. Verify:
```bash
echo $PATH | grep zig
```

### Wrong version showing

Multiple Zig installations may exist. Check which one runs:
```bash
which zig
```

### Permission denied

On Linux/macOS, ensure the binary is executable:
```bash
chmod +x /path/to/zig
```

## Self-Check

Before moving on:

1. Does `zig version` show a version number?
2. Can you run `zig run` on a simple file?
3. Is your editor showing Zig syntax highlighting?

## Next Steps

With Zig installed, you're ready to write your first real program.

→ Continue to [Lesson 1.3: Hello Zig](03_hello.md)
