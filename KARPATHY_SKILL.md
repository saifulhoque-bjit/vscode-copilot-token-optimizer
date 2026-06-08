---
applyTo: "**"
description: "Karpathy's coding guidelines - simple, clean, readable code"
---

# Karpathy's Coding Guidelines

## Philosophy

> "The best code is no code at all. The second best is simple, readable code."

Inspired by Andrej Karpathy's coding style from nanoGPT, minGPT, llm.c, and micrograd.

---

## Core Principles

### 1. Simplicity First
- If you can't explain it to a junior developer, simplify it
- One file is better than five files
- No unnecessary abstractions
- YAGNI: You Aren't Gonna Need It

### 2. Readability Over Cleverness
- Variable names should tell a story: `num_heads` not `nh`
- But standard abbreviations are fine: `B, T, C` for batch, time, channels
- Comments explain **why**, not **what**
- Code should read like prose

### 3. Minimal Dependencies
- Every dependency is a liability
- Standard library first, then pip, then conda
- If you can implement it in 20 lines, don't import a library

### 4. Self-Contained Code
- Each file should be independently runnable
- Avoid circular imports
- Configuration at the top of the file
- No hidden magic

### 5. Progressive Complexity
- Start with the simplest working version
- Add complexity only when needed
- Profile before optimizing
- Make it work, then make it fast, then make it pretty

---

## Code Style

### Python
```python
# ✅ GOOD: Clear, simple, readable
def count_even_numbers(numbers):
    """Count even numbers in a list."""
    return sum(1 for n in numbers if n % 2 == 0)

# ❌ BAD: Overly clever
def count_even_numbers(numbers):
    return len(list(filter(lambda x: not x & 1, numbers)))
```

### Variable Naming
```python
# ✅ GOOD: Descriptive
num_layers = 12
hidden_dim = 768
learning_rate = 1e-3

# ❌ BAD: Cryptic
nl = 12
hd = 768
lr = 1e-3
```

### Comments
```python
# ✅ GOOD: Explains WHY
# Flash attention makes GPU go brrrrr but support is only in PyTorch >= 2.0
self.flash = hasattr(torch.nn.functional, 'scaled_dot_product_attention')

# ❌ BAD: Explains WHAT (obvious from code)
# Check if flash attention is available
self.flash = hasattr(torch.nn.functional, 'scaled_dot_product_attention')
```

### Functions
```python
# ✅ GOOD: Single responsibility, clear signature
def compress_text(text: str, max_tokens: int = 500) -> str:
    """Compress text to fit within token limit."""
    if len(text.split()) <= max_tokens:
        return text
    return ' '.join(text.split()[:max_tokens]) + '...'

# ❌ BAD: Does too many things
def process_text(text, mode='compress', format='plain', validate=True, 
                 log=True, cache=True, retry=3):
    # 50 lines of if/else for each mode...
```

---

## File Organization

### Single-File Philosophy
```
# ✅ GOOD: Everything in one file (if < 500 lines)
model.py      # Full model definition
train.py      # Full training loop

# ❌ BAD: Over-engineered structure
src/
  models/
    __init__.py
    base.py
    attention.py
    feedforward.py
    transformer.py
    config.py
    utils.py
```

### Configuration
```python
# ✅ GOOD: Config at top of file, plain variables
# -----------------------------------------------------------------------------
# Config
batch_size = 32
learning_rate = 1e-3
num_epochs = 100
# -----------------------------------------------------------------------------

# ❌ BAD: Config in separate file, complex objects
from config import Config
config = Config.load('config.yaml')
```

---

## Error Handling

```python
# ✅ GOOD: Assert for programming errors, clear messages
assert config.n_embd % config.n_head == 0, f"n_embd ({config.n_embd}) must be divisible by n_head ({config.n_head})"

# ❌ BAD: Generic exceptions
if config.n_embd % config.n_head != 0:
    raise ValueError("Invalid config")
```

---

## Imports

```python
# ✅ GOOD: Grouped, minimal
import math
from dataclasses import dataclass

import torch
import torch.nn as nn
from torch.nn import functional as F

# ❌ BAD: Wildcards, unused imports
import torch
from torch import *
import numpy as np  # never used
from utils import *  # who knows what this imports
```

---

## Testing

```python
# ✅ GOOD: Test the public interface
def test_compress():
    result = compress("hello world " * 100, max_tokens=5)
    assert len(result.split()) <= 6  # 5 + "..."

# ❌ BAD: Test implementation details
def test_compress_internal():
    assert compress._split_words.__defaults__ == (500,)
```

---

## Documentation

### Docstrings
```python
# ✅ GOOD: Concise, describes behavior
def compress(text: str, max_tokens: int = 500) -> str:
    """Compress text to fit within token limit. Returns compressed text."""

# ❌ BAD: Verbose, describes implementation
def compress(text: str, max_tokens: int = 500) -> str:
    """
    This function takes a text string and compresses it by splitting
    on whitespace and taking the first max_tokens words, then appending
    an ellipsis if the text was truncated. It uses the split() method
    which splits on any whitespace character including spaces, tabs,
    and newlines. The max_tokens parameter defaults to 500 if not provided.
    """
```

---

## The Karpathy Checklist

Before submitting code, ask:

- [ ] Can a junior developer understand this in 5 minutes?
- [ ] Is every line necessary?
- [ ] Are variable names descriptive?
- [ ] Do comments explain "why" not "what"?
- [ ] Is it self-contained?
- [ ] Does it have minimal dependencies?
- [ ] Would I be proud to show this in a blog post?

---

## References

- [nanoGPT](https://github.com/karpathy/nanoGPT) - 300-line GPT implementation
- [minGPT](https://github.com/karpathy/minGPT) - Minimal GPT
- [llm.c](https://github.com/karpathy/llm.c) - LLMs in pure C/CUDA
- [micrograd](https://github.com/karpathy/micrograd) - Tiny autograd engine
- [nn-zero-to-hero](https://github.com/karpathy/nn-zero-to-hero) - Neural networks course

---

*"The best code is the code you don't write." — Every senior developer ever*
