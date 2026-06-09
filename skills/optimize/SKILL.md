---
name: optimize
description: Compress code context before answering — extract signatures instead of reading full files
argument-hint: ""
---

# /optimize

For the **rest of this session**, follow this rule on every response:

## Rule: COMPRESS BEFORE ANSWERING

Whenever the user references a file or codebase:

1. Run the compression script to get function/class signatures:
   - **Windows:** `python %USERPROFILE%\.copilot\skills\optimize\compress_context.py "<file>"`
   - **Linux/Mac:** `python ~/.copilot/skills/optimize/compress_context.py "<file>"`
2. Use the compressed signatures as your primary context
3. Only read the full file for the **specific function** the user asks about in detail

Never paste or quote an entire file. Compress first, drill down second.

### When to read the full file

| User asks... | What to do |
|---|---|
| "What does this file do?" | Answer from signatures only |
| "Explain the architecture" | Answer from class/function map |
| "Where's the bug?" | Answer from signatures, flag suspicious patterns |
| "How does X work internally?" | Read only that function's implementation |
| "Review this code" | Read only the functions you flag |

### Follow-up questions

When the user asks follow-ups, reference previous answers instead of re-explaining:
```
Ref: [previous topic] above. [new question]
```

---

**This rule is active until the session ends or the user says "stop optimizing".**
