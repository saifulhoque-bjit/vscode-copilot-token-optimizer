# Copilot Instructions

## Response Style

- Be concise: 3-5 sentences max for explanations
- Use structured output: JSON, tables, bullet points
- Avoid repetition and filler words
- Don't repeat the question in your answer
- Use abbreviations for common terms (fn, var, arg, ret)

## Code Generation Rules

When generating code, ALWAYS follow these rules:

1. **Simplicity first** - If you can't explain it to a junior dev, simplify it
2. **One file is better than five** - Keep it self-contained
3. **No unnecessary abstractions** - YAGNI
4. **Minimal dependencies** - Standard library first, then pip
5. **Readable variable names** - `num_heads` not `nh`
6. **Comments explain WHY, not WHAT**
7. **Assert for programming errors** with clear messages
8. **Progressive complexity** - Start simple, add only when needed

## Token Saving

- Use concise prompts
- Prefer tables over paragraphs for comparisons
- Use bullet points instead of long paragraphs
- Combine related information into structured formats
- Avoid unnecessary pleasantries and filler text

## Output Format

When appropriate, use these formats:

### For comparisons:
```
| Option | Pros | Cons |
|--------|------|------|
| A      | ...  | ...  |
| B      | ...  | ...  |
```

### For analysis:
```json
{
  "purpose": "what the code does",
  "issues": ["issue1", "issue2"],
  "suggestions": ["suggestion1", "suggestion2"]
}
```

### For explanations:
- **What:** Brief description
- **Why:** Reason/purpose
- **How:** Key mechanism (if complex)

## Examples

### ❌ DON'T (verbose):
"Can you please help me understand what this function does? I'm a bit confused about the logic and would appreciate a detailed explanation with examples."

### ✅ DO (concise):
"Explain this function. Use examples."

### ❌ DON'T (verbose code):
```python
class DataProcessingService:
    def __init__(self, config):
        self.config = config
        self.validator = Validator(config)
        self.transformer = Transformer(config)
    
    def process(self, data):
        validated = self.validator.validate(data)
        return self.transformer.transform(validated)
```

### ✅ DO (simple code):
```python
def process_data(data):
    """Process data: validate and transform."""
    assert len(data) > 0, "data cannot be empty"
    return [transform(x) for x in data if validate(x)]
```
