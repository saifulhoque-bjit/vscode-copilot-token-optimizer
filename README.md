<div align="center">

# VS Code Copilot Token Optimizer

### Reduce GitHub Copilot token usage by 30-60%

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Version](https://img.shields.io/badge/version-2.0.0-green.svg)
![VS Code](https://img.shields.io/badge/VS%20Code-1.80+-blue.svg)
![Copilot](https://img.shields.io/badge/GitHub%20Copilot-Supported-brightgreen.svg)

**Save money. Save tokens. Code faster.**

[Quick Start](#-quick-start) • [How It Works](#-how-it-works) • [/optimize Skill](#-optimize-skill) • [Compression Script](#-compression-script) • [FAQ](#-faq)

---

</div>

## What Is This?

A **Copilot skill + custom instructions** that automatically reduce GitHub Copilot's token usage. Type `/optimize` once per session, then code normally — every file question gets compressed to function signatures before Copilot answers.

```
❌ Before: Copilot reads your entire 500-line file (2000 tokens)
✅ After:  Copilot reads 8 function signatures (200 tokens) → same answer
```

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

### 3. Type `/optimize` in Copilot Chat

That's it. Every file question now auto-compresses for the rest of the session.

```
You:  /optimize
Copilot: ✅ Optimization mode enabled.

You:  What does src/auth.py do?
Copilot: [reads 8 signatures instead of 500 lines, answers from structure]

You:  How does the login function work?
Copilot: [drills into just that function, references previous answer]

You:  Explain the token validation flow
Copilot: [builds on previous answers, no re-explaining]
```

---

## What Gets Installed

```
~/.copilot/skills/optimize/           ← /optimize skill (global, all projects)
  SKILL.md                            ← slash command rules
  compress_context.py                 ← compression script

%APPDATA%/Code/User/prompts/          ← Karpathy's guidelines (global)
  global.instructions.md

<project>/.github/                    ← Copilot custom instructions (per-project)
  copilot-instructions.md
```

---

## How It Works

### 1. The `/optimize` Skill (Core Feature)

A [Copilot skill](https://code.visualstudio.com/docs/copilot/copilot-skills) installed to `~/.copilot/skills/optimize/`. When you type `/optimize` in Copilot Chat, it activates 3 persistent rules for the session:

**Rule 1 — COMPRESS:** Before answering any file question, Copilot runs `compress_context.py` to extract function/class signatures. Answers from the compressed skeleton (60-80% fewer tokens). Only reads full implementations when you ask for specific function details.

**Rule 2 — CACHE-ALIGN:** Structures every response with static context first (project structure, conventions) and dynamic content last (the actual answer). Follow-up questions reference previous answers instead of re-explaining.

**Rule 3 — CCR (Compress-Cache-Retrieve):** Compress → answer from signatures → retrieve full details only on demand. The compression is reversible — any function can be expanded to its full implementation when needed.

### 2. Custom Instructions (Automatic)

`.github/copilot-instructions.md` teaches Copilot to be concise — 3-5 sentences max, structured output, no filler. Active on any project with this file.

### 3. Karpathy's Coding Guidelines (Global)

Installed to VS Code's global prompts folder. Teaches Copilot clean coding principles: simplicity first, readable variable names, minimal dependencies, self-contained code.

---

## `/optimize` Skill

### Location

```
Windows:  %USERPROFILE%\.copilot\skills\optimize\
Linux:    ~/.copilot/skills/optimize/
Mac:      ~/.copilot/skills/optimize/
```

### Files

| File | Purpose |
|------|---------|
| `SKILL.md` | Defines the `/optimize` slash command and its 3 rules |
| `compress_context.py` | Extracts function/class signatures from code files |

### How the Skill Works

1. You type `/optimize` in Copilot Chat
2. Copilot reads `SKILL.md` and follows the 3 rules for the rest of the session
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

## Token Savings

| Technique | Savings | How |
|-----------|---------|-----|
| Context Compression | 60-80% | Extract signatures instead of full files |
| Cache-Align | 20-40% | Static prefix, dynamic suffix for API caching |
| CCR Pattern | 60-80% | Compress → answer → retrieve on demand |
| Concise Prompting | 70-80% | "Sum even nums" instead of full sentences |
| Structured Output | 40-60% | JSON/tables instead of paragraphs |
| Reference Instead of Repeat | 30-50% | "Ref: auth flow above" |

---

## FAQ

**Q: Does this work with GitHub Copilot?**
A: Yes. The skill uses Copilot's native skills system. No extensions needed.

**Q: Does it affect inline code suggestions?**
A: No. Only affects Copilot Chat responses.

**Q: Do I need to run `/optimize` every session?**
A: Yes. Type it once at the start of each session.

**Q: Can I stop optimizing mid-session?**
A: Say "stop optimizing" in chat.

**Q: Is this free?**
A: Yes. MIT License.

---

## Contributing

1. Fork the repo
2. Create a feature branch
3. Commit your changes
4. Open a Pull Request

Ideas: more language support, token usage dashboard, VS Code extension.

---

## Acknowledgments

- [GitHub Copilot](https://github.com/features/copilot) — AI pair programmer
- [headroom-ai](https://github.com/chopratejas/headroom) — Compression technique inspiration
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
