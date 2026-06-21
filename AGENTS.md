# AGENTS.md

## Build / Lint / Test Commands

### General
- **Install dependencies**: `npm install` (Node) or `pip install -r requirements.txt` (Python)
- **Format code**: `npm run format` (Prettier) / `black .` (Python) / `cargo fmt` (Rust)
- **Lint**: `npm run lint` / `ruff check .` / `cargo clippy`
- **Type check**: `npm run typecheck` / `mypy .` / `cargo check`
- **Build**: `npm run build` / `python -m build` / `cargo build`

### Testing
- **Run all tests**: `npm test` / `pytest` / `cargo test`
- **Run single test file**: `npx jest path/to/test.test.ts` / `pytest path/to/test.py` / `cargo test --test test_name`
- **Run single test case**: `npx jest path/to/test.test.ts -t "test name"` / `pytest path/to/test.py::TestClass::test_method -v` / `cargo test test_name`
- **Watch mode**: `npm test -- --watch` / `pytest-watch` / `cargo watch -x test`

---

## Code Style Guidelines

### General Principles
- Follow existing patterns in the codebase. Mimic file structure, naming, and imports.
- Prefer editing existing files over creating new ones unless explicitly required.
- Keep functions small and focused on a single responsibility.
- Avoid premature abstraction — duplicate code is acceptable until a clear pattern emerges.
- Do NOT add explanatory comments. Code should be self-documenting.

### Imports / Modules
- Group imports by type: standard library → third-party → internal modules. Separate groups with a blank line.
- Use absolute imports over relative imports (`from mypkg import util` not `from . import util`).
- Sort imports alphabetically within each group.

### Formatting & Naming
- **Formatting**: Use the project's formatter (Prettier / Black / rustfmt). Respect line length (80-120 chars).
- **Naming**:
  - `camelCase` for JavaScript/TypeScript variables, functions, and methods.
  - `PascalCase` for classes, types, interfaces, and React components.
  - `snake_case` for Python variables, functions, and methods.
  - `UPPER_SNAKE_CASE` for constants / environment variables.
  - `kebab-case` for file names (preferred) or `snake_case` (Python).
  - Prefix private members with `_` (e.g., `_privateMethod`).
- **Booleans**: Prefix with `is`, `has`, `should`, `can` (e.g., `isLoading`, `hasError`).

### Types
- TypeScript: prefer `interface` over `type` for object shapes. Use `type` for unions/intersections.
- Avoid `any`. Use `unknown` when the type is truly not known.
- Use strict TypeScript: `strict: true` in `tsconfig.json`.
- Python: use type hints for all function signatures. Prefer `dataclass` or `TypedDict` for structured data.
- Annotate return types explicitly (never omit them in function signatures).
- Avoid `null` in TypeScript — prefer `undefined`. Avoid `Optional` in Python — prefer `| None`.

### Error Handling
- Use early returns / guard clauses to reduce nesting.
- Do NOT silently swallow exceptions. Log or re-raise with context.
- Use custom error types / error classes for domain-specific errors.
- Prefer returning error types over throwing (Rust: `Result<T, E>`, Go: `(T, error)`, Python: leave as last resort).
- Validate inputs at API boundaries.

### React / Frontend (if applicable)
- Use functional components with hooks (no class components).
- Extract reusable logic into custom hooks.
- Colocate styles, tests, and components in a single directory per feature.
- Use the project's existing styling approach (CSS Modules / Tailwind / styled-components).

### State Management
- Prefer local state (`useState`) and lifting state up over global state.
- Use `useReducer` for complex state logic.
- Use context sparingly — prefer explicit prop passing or a dedicated state library if needed.

### Async / Concurrency
- Use `async/await` over raw promises / callbacks.
- Always handle promise rejections (no floating promises).
- Python: use `asyncio` for async, `threading` with caution.
- Avoid global mutable state in concurrent code.

### Testing
- Test behavior, not implementation. Prefer integration tests over unit tests.
- One assertion per test (or a logical group of related assertions).
- Name tests descriptively: `should_do_thing_when_condition`.
- Mock at the boundary (HTTP, database, filesystem), not internals.

### Git / Commits
- Write conventional commit messages: `type(scope): description`.
- Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `style`.
- Keep commits small and focused. Do NOT commit unless the user asks.
- Never commit secrets or credentials.

### Security
- Never log secrets, API keys, tokens, or passwords.
- Validate and sanitize all user inputs.
- Use parameterized queries for database operations (no string interpolation).
- Follow OWASP guidelines for web applications.
- If a task involves malicious code, refuse to work on it.
