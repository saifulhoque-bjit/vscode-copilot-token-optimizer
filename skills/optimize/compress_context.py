#!/usr/bin/env python3
"""
VS Code Copilot Token Optimizer - Context Compression Script

Compresses code files for efficient Copilot context.
Extracts function/class signatures only, reducing token usage by 60-80%.

Usage:
    python compress_context.py <file>
    python compress_context.py <file> --format json
    python compress_context.py <file> --max-lines 50

Examples:
    python compress_context.py myfile.py
    python compress_context.py myfile.py --format json
    python compress_context.py large_file.py --max-lines 100
"""

import sys
import ast
import argparse
import json
from pathlib import Path
from typing import List, Dict, Any


def compress_python(code: str, max_lines: int = 100) -> str:
    """Extract Python function/class signatures only."""
    try:
        tree = ast.parse(code)
        lines = []
        
        for node in ast.walk(tree):
            if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
                # Get function arguments
                args = []
                for arg in node.args.args:
                    args.append(arg.arg)
                
                # Get return annotation if present
                ret = ""
                if node.returns:
                    ret = " -> ..."
                
                # Format function signature
                args_str = ", ".join(args)
                lines.append(f"def {node.name}({args_str}){ret}")
                
            elif isinstance(node, ast.ClassDef):
                # Get base classes
                bases = []
                for base in node.bases:
                    if isinstance(base, ast.Name):
                        bases.append(base.id)
                
                bases_str = f"({', '.join(bases)})" if bases else ""
                lines.append(f"class {node.name}{bases_str}:")
                
                # Add methods
                for item in node.body:
                    if isinstance(item, (ast.FunctionDef, ast.AsyncFunctionDef)):
                        args = [a.arg for a in item.args.args]
                        args_str = ", ".join(args)
                        lines.append(f"    def {item.name}({args_str})")
        
        if lines:
            result = "\n".join(lines[:max_lines])
            if len(lines) > max_lines:
                result += f"\n[...{len(lines) - max_lines} more signatures...]"
            return result
        else:
            # No functions/classes found, return first N lines
            code_lines = code.split("\n")[:max_lines]
            return "\n".join(code_lines)
            
    except SyntaxError:
        # Can't parse, return truncated code
        code_lines = code.split("\n")[:max_lines]
        return "\n".join(code_lines)


def compress_javascript(code: str, max_lines: int = 100) -> str:
    """Extract JavaScript function signatures."""
    lines = []
    in_function = False
    brace_count = 0
    
    for line in code.split("\n"):
        stripped = line.strip()
        
        # Detect function declarations
        if any(keyword in stripped for keyword in ["function ", "=>", "class "]):
            # Extract function name
            if "function " in stripped:
                name = stripped.split("function ")[1].split("(")[0].strip()
                lines.append(f"function {name}()")
            elif "class " in stripped:
                name = stripped.split("class ")[1].split("{")[0].strip()
                lines.append(f"class {name}")
            elif "=>" in stripped:
                # Arrow function
                parts = stripped.split("=")
                if len(parts) > 0:
                    name = parts[0].strip()
                    lines.append(f"{name} = () => ...")
        
        # Track braces for function bodies
        if "{" in stripped:
            brace_count += stripped.count("{")
            in_function = True
        if "}" in stripped:
            brace_count -= stripped.count("}")
            if brace_count <= 0:
                in_function = False
                brace_count = 0
    
    if lines:
        result = "\n".join(lines[:max_lines])
        if len(lines) > max_lines:
            result += f"\n[...{len(lines) - max_lines} more signatures...]"
        return result
    else:
        # No functions found, return first N lines
        code_lines = code.split("\n")[:max_lines]
        return "\n".join(code_lines)


def compress_generic(code: str, max_lines: int = 100) -> str:
    """Generic compression: first N lines + summary."""
    lines = code.split("\n")
    
    if len(lines) <= max_lines:
        return code
    
    # Return first N lines with summary
    result = "\n".join(lines[:max_lines])
    remaining = len(lines) - max_lines
    result += f"\n[...{remaining} more lines...]"
    
    return result


def compress_code(code: str, lang: str, max_lines: int = 100) -> str:
    """Compress code based on language."""
    compressors = {
        "py": compress_python,
        "python": compress_python,
        "js": compress_javascript,
        "javascript": compress_javascript,
        "jsx": compress_javascript,
        "ts": compress_javascript,
        "typescript": compress_javascript,
        "tsx": compress_javascript,
    }
    
    compressor = compressors.get(lang, compress_generic)
    return compressor(code, max_lines)


def format_output(compressed: str, original_lines: int, compressed_lines: int, 
                  format_type: str = "text") -> str:
    """Format the output."""
    if format_type == "json":
        return json.dumps({
            "compressed": compressed,
            "stats": {
                "original_lines": original_lines,
                "compressed_lines": compressed_lines,
                "reduction_percent": round((1 - compressed_lines / original_lines) * 100, 1)
            }
        }, indent=2)
    else:
        # Text format with stats
        reduction = round((1 - compressed_lines / original_lines) * 100, 1)
        return f"{compressed}\n\n--- Compression Stats ---\nOriginal: {original_lines} lines\nCompressed: {compressed_lines} lines\nReduction: {reduction}%"


def main():
    parser = argparse.ArgumentParser(
        description="Compress code context for Copilot",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python compress_context.py myfile.py
  python compress_context.py myfile.py --format json
  python compress_context.py large_file.py --max-lines 50
        """
    )
    
    parser.add_argument("file", help="Code file to compress")
    parser.add_argument("--format", choices=["text", "json"], default="text",
                       help="Output format (default: text)")
    parser.add_argument("--max-lines", type=int, default=100,
                       help="Maximum lines to include (default: 100)")
    
    args = parser.parse_args()
    
    # Read file
    try:
        with open(args.file, "r", encoding="utf-8") as f:
            code = f.read()
    except FileNotFoundError:
        print(f"Error: File '{args.file}' not found", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Error reading file: {e}", file=sys.stderr)
        sys.exit(1)
    
    # Detect language from extension
    ext = Path(args.file).suffix.lstrip(".")
    
    # Compress
    compressed = compress_code(code, ext, args.max_lines)
    
    # Count lines
    original_lines = len(code.split("\n"))
    compressed_lines = len(compressed.split("\n"))
    
    # Format output
    output = format_output(compressed, original_lines, compressed_lines, args.format)
    
    print(output)


if __name__ == "__main__":
    main()
