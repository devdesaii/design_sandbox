# Flutter Mini Meta-Editor

A compact Flutter-based DSL renderer that takes a small custom language, parses it, and renders live widgets entirely on-device. The project implements a full input-to-render pipeline without relying on external compilers or interpreters.

## Overview

The editor accepts a lightweight DSL for defining Flutter UI elements. The input passes through a series of custom stages:

Input → Debounce → Normalization → Tokenizer → Parser (AST) → Renderer → Preview

The system currently supports a minimal widget set (Text and Container) but includes a complete tokenizer, parser, AST, and rendering architecture implemented from scratch.

Example

Input:

Container {
  color: red,
  width: 200,
  child: Text("Hello")
}


Rendered as:

Container(
  color: Colors.red,
  width: 200,
  child: Text("Hello"),
);

## Architecture Summary

### Debounce
Prevents unnecessary rebuilds while typing and ensures stable input for the tokenizer.

### Normalization
Cleans and restructures the raw user input to guarantee predictable formatting.

### Tokenizer
Converts the normalized string into tokens (identifiers, numbers, strings, braces, punctuation) while tracking line and column numbers for error reporting.

### Parser
A hand-written recursive-descent parser that converts the token stream into an abstract syntax tree. The grammar supports widget declarations, property maps, and literal values.

### AST
Defines two core node types: WidgetNode and LiteralNode.

### Renderer
Traverses the AST and produces the equivalent Flutter widget tree. Includes basic error handling for unknown widgets, invalid literals, and malformed syntax.

### Current Status

The prototype is functional: widgets render correctly, errors are surfaced in a console pane, and updates occur live in response to user input. The UI is minimal but stable.

### Future Work

Upcoming improvements include additional widgets, more detailed error messages, a more capable console, syntax highlighting, and UI polish.

### Feedback

This is my first non-trivial end-to-end project involving parsing, AST construction, and dynamic widget rendering. Feedback and suggestions are welcome.
