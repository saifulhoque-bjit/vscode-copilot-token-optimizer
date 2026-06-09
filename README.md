<div align="center">

# VS Code Copilot Token Optimizer

### `/optimize` — one command, every session, fewer tokens

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Version](https://img.shields.io/badge/version-2.0.0-green.svg)
![VS Code](https://img.shields.io/badge/VS%20Code-1.80+-blue.svg)
![Copilot](https://img.shields.io/badge/GitHub%20Copilot-Supported-brightgreen.svg)

[Quick Start](#-quick-start) • [How It Works](#-how-it-works) • [/optimize Skill](#-optimize-skill) • [Compression Script](#-compression-script) • [FAQ](#-faq)

---

</div>

## What Is This?

A [Copilot skill](https://code.visualstudio.com/docs/copilot/copilot-skills) that makes Copilot compress code before answering. When you ask about a file, instead of reading the entire file, Copilot extracts function/class signatures and answers from the skeleton. If you need details on a specific function, it reads only that one.

**Without `/optimize`:**
```
You:  "What does src/auth.py do?"
Copilot: [reads all 500 lines, 2000 tokens consumed]
```

**With `/optimize`:**
```
You:  "What does src/auth.py do?"
Copilot: [reads 8 function signatures, 200 tokens consumed, same answer]
```

Also installs **Karpathy's coding guidelines** globally — teaches Copilot clean, simple code across all projects.

---

## Quick Start

### 1. Install

**Windows (PowerShell):**
```powershell
iwr -useb https://raw.githubusercontent.com/saifulhoque-bjit/vscode-copilot-token-optimizer/main/install.ps1 | iex
```

**Linux / Mac:**
```bash
curl -fsSL https://raw.githubusercontent.com/saifulhoque-bjit/vscode-copilot-token-optimizer/main/install.sh | bash
```

**Or clone and run locally:**
```bash
git clone https://github.com/saifulhoque-bjit/vscode-copilot-token-optimizer.git
cd vscode-copilot-token-optimizer
install.bat          # Windows
bash install.sh      # Linux / Mac
```

### 2. Restart VS Code

### 3. Run `/optimize` in Copilot Chat

> **This is the key step.** Open Copilot Chat (Ctrl+Shift+I), type `/optimize`, press Enter. Copilot confirms it's active. Now every file question compresses automatically.

```
You:  /optimize
Copilot: ✅ Optimization mode enabled.

You:  What does src/auth.py do?
Copilot: [reads 8 signatures instead of 500 lines]

You:  How does the login function work?
Copilot: [reads only that function's implementation]
```

**Run `/optimize` at the start of every new Copilot Chat session.** Without it, Copilot reads full files.

---

## What Gets Installed

```
~/.copilot/skills/optimize/           ← /optimize skill (global, all projects)
  SKILL.md                            ← slash command rules
  compress_context.py                 ← compression script

%APPDATA%/Code/User/prompts/          ← Karpathy's guidelines (global)
  global.instructions.md
```

---

## How It Works

### The `/optimize` Skill

A [Copilot skill](https://code.visualstudio.com/docs/copilot/copilot-skills) installed to `~/.copilot/skills/optimize/`. When you type `/optimize`, Copilot reads `SKILL.md` and follows one main rule for the rest of the session:

**Before answering any file question, run `compress_context.py` to extract function/class signatures. Answer from the compressed output. Only read the full implementation when the user asks about a specific function.**

The script uses Python's `ast` module to parse code and extract:
- Function names and parameters
- Class names and methods
- Return type annotations (if present)

It strips all function bodies, comments, and implementation details — leaving just the skeleton.

### Karpathy's Coding Guidelines

Installed to VS Code's global prompts folder (`global.instructions.md`). Teaches Copilot clean coding principles on ALL projects automatically:

- Simplicity first — no unnecessary abstractions
- Readable variable names — `num_heads` not `nh`
- Minimal dependencies — stdlib first
- Self-contained code — each file independently runnable
- Comments explain **why**, not **what**

---

## `/optimize` Skill

### When to Run It

| Situation | Action |
|-----------|--------|
| Starting a new Copilot Chat session | Type `/optimize` |
| Already ran it this session | Still active, no need to re-run |
| Switched to a different VS Code window | Type `/optimize` again (new session) |

**Rule of thumb: fresh Copilot Chat = run `/optimize` first.**

### Location

```
Windows:  %USERPROFILE%\.copilot\skills\optimize\
Linux:    ~/.copilot/skills/optimize/
Mac:      ~/.copilot/skills/optimize/
```

### Files

| File | Purpose |
|------|---------|
| `SKILL.md` | Defines the `/optimize` slash command and its rules |
| `compress_context.py` | Extracts function/class signatures from code files |

### How It Works Step by Step

1. You type `/optimize` in Copilot Chat
2. Copilot reads `SKILL.md` and follows the rules for the rest of the session
3. When you ask about a file, Copilot runs `compress_context.py` internally
4. It answers from the compressed signatures (not the full file)
5. If you ask "how does X work internally?", it reads only that function

### Supported Languages

| Language | Extension | Compression Method |
|----------|-----------|-------------------|
| Python | `.py` | AST-based function/class signatures |
| JavaScript | `.js`, `.jsx` | Function declaration extraction |
| TypeScript | `.ts`, `.tsx` | Function declaration extraction |
| Other | `*` | First N lines + summary |

---

## Compression Script

The script is installed with the skill. You can also run it manually:

```bash
# Windows
python %USERPROFILE%\.copilot\skills\optimize\compress_context.py myfile.py

# Linux / Mac
python ~/.copilot/skills/optimize/compress_context.py myfile.py
```

### Options

```bash
compress_context.py <file>                  # text output (default)
compress_context.py <file> --format json    # JSON output with stats
compress_context.py <file> --max-lines 50   # limit output lines
```

### Example

```
$ python compress_context.py app.py

def fibonacci(n) -> ...
def is_prime(n)
def sum_even_numbers(numbers)
class DataProcessor:
    def __init__(self)
    def process(self)
    def validate(self)

--- Compression Stats ---
Original: 150 lines
Compressed: 8 lines
Reduction: 94.7%
```

---

## Prompting Tips (Not Automated)

These are habits that save tokens on top of what `/optimize` does. They're **not built into the tool** — you do them yourself:

| Tip | Example | Why it helps |
|-----|---------|-------------|
| **Be concise** | "Sum even nums in list" instead of "Can you please help me write a function that..." | Fewer input tokens |
| **Ask for structured output** | "Analyze function: {params, returns, purpose}" | Shorter responses |
| **Batch questions** | "Explain lines 10, 20, 30" instead of 3 separate asks | One API call instead of three |
| **Reference, don't repeat** | "Ref: auth flow above. Optimize it." | Avoids re-sending context |

---

## FAQ

**Q: Does this work with GitHub Copilot?**
A: Yes. The skill uses Copilot's native skills system. No extensions needed.

**Q: Does it affect inline code suggestions?**
A: No. Only affects Copilot Chat responses.

**Q: How much can I save?**
A: The compression script typically reduces code context by 60-90% (150 lines → 8 signatures). Actual token savings depend on how much of the conversation is file context vs. your questions.

**Q: Do I need to run `/optimize` every session?**
A: Yes. Open Copilot Chat, type `/optimize`, press Enter. Once per session.

**Q: Can I stop optimizing mid-session?**
A: Say "stop optimizing" in chat.

**Q: What if I don't run `/optimize`?**
A: Karpathy's guidelines are always active globally. But the automatic compression only kicks in when `/optimize` is running.

**Q: Is this free?**
A: Yes. MIT License.

---

## Contributing

1. Fork the repo
2. Create a feature branch
3. Commit your changes
4. Open a Pull Request

---

## Acknowledgments

- [headroom-ai](https://github.com/chopratejas/headroom) — Inspiration for context compression
- [Andrej Karpathy](https://github.com/karpathy) — Coding philosophy

---

## Support

- [GitHub Issues](https://github.com/saifulhoque-bjit/vscode-copilot-token-optimizer/issues)
- [GitHub Discussions](https://github.com/saifulhoque-bjit/vscode-copilot-token-optimizer/discussions)

---

<div align="center">

**Made for the VS Code Copilot community**

[⬆ Back to Top](#vs-code-copilot-token-optimizer)

</div>
