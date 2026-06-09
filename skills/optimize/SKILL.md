---
name: optimize
description: Enable all 3 token optimizations for this session: compress, cache-align, CCR
argument-hint: ""
---

# /optimize

For the **rest of this session**, follow ALL three rules below on every response. These are persistent behavioral rules, not one-time tasks.

---

## Rule 1: COMPRESS — Always extract signatures first

Whenever the user references a file or codebase:

1. Run `python scripts/compress_context.py "<file>"` to get function/class signatures
2. Use the compressed signatures as your primary context
3. Only read the full file for the **specific function** the user asks about in detail

Never paste or quote an entire file. Compress first, drill down second.

## Rule 2: CACHE-ALIGN — Static prefix, dynamic suffix

Structure every response in this order:

1. **Static context first** (reusable): project structure, conventions, tech stack, architecture
2. **Dynamic content last** (query-specific): the actual answer, code changes, analysis

When answering follow-up questions:
- Reference previous answers: "Ref: auth flow above"
- Never re-explain context already established in this session
- Build incrementally on what's already been said

## Rule 3: CCR — Answer from structure, retrieve on demand

Default behavior for code questions:

| Question Type | Answer From | Full File Needed? |
|---------------|-------------|-------------------|
| "What does this do?" | Signatures only | No |
| "Explain the architecture" | Class/function map | No |
| "Where's the bug?" | Signatures + patterns | Maybe |
| "How does X work internally?" | Signatures first | Yes — read only that function |
| "Review this code" | Signatures first | Yes — read only flagged functions |

**Workflow for every code question:**
1. Compress → get signatures (60-80% fewer tokens)
2. Answer from signatures if possible
3. Retrieve full implementation only for specific functions requested
4. Reference compressed context for follow-ups

---

## Quick Reference

When the user provides a file path or asks about code:
```bash
python scripts/compress_context.py "<file>"
```
Use the output as your working context. Expand only when asked.

When the user asks a follow-up:
```
Ref: [previous topic] above. [new question]
```
Don't repeat context. Build on it.

---

**These rules are active until the session ends or the user says "stop optimizing".**
