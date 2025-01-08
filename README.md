# fastapi_project

A FastAPI project.

## Folder Structure

    fastapi_project/
    ├── app/                    # Main application logic.
    │   ├── main.py             # Entry point of the application.
    │   ├── __init__.py         # Package marker.
    │   ├── config/             # Application configurations (settings, logging).
    │   │   ├── settings.py     # Configuration settings.
    │   │   ├── logging_config.py   # Logging configuration.
    │   ├── core/               # Core functionalities (dependencies, event handlers).
    │   │   ├── dependencies.py # Dependency injection.
    │   │   ├── events.py       # Event handlers.
    │   ├── db/                 # Database setup and ORM base.
    │   │   ├── base.py         # Base class for ORM models.
    │   │   ├── session.py      # Database session management.
    │   ├── routes/             # API endpoint route definitions.
    │   │   ├── items.py        # Item-related routes.
    │   │   ├── users.py        # User-related routes.
    │   ├── schemas/            # Pydantic schemas for data validation.
    │   │   ├── item.py         # Item schema.
    │   │   ├── user.py         # User schema.
    │   ├── models/             # Database ORM models.
    │   │   ├── item.py         # Item model.
    │   │   ├── user.py         # User model.
    │   ├── services/           # Service layer for business logic.
    │   │   ├── item_service.py # Business logic for items.
    │   │   ├── user_service.py # Business logic for users.
    │   ├── utils/              # Utility functions.
    │   │   ├── common.py       # Common utility functions.
    │   ├── tests/              # Unit and integration tests.
    │   │   ├── test_items.py   # Tests for item routes.
    │   │   ├── test_users.py   # Tests for user routes.
    ├── scripts/                # Utility scripts.
    │   ├── check_server.sh     # Example script 1.
    │   ├── script2.sh          # Example script 2.
    ├── pyproject.toml          # PyProject TOML file.
    ├── .gitignore              # Git ignore file.
    ├── requirements.txt        # Project dependencies.
    └── README.md               # Project README file.

## Best Practice Tools

This section outlines the key tools used in our project for code formatting, linting, and type checking. Each tool is configured to maintain code quality and consistency across the project.

You can simply run the configured checks in terminal.

For black,

```bash
black --check --config pyproject.toml .
```

For ruff,

```bash
ruff check --config pyproject.toml .
```

For mypy,

```bash
mypy --config-file pyproject.toml .
```

All VS Code extensions related to configured tools can be install via extensions.json file (There'll be suggested notification to download them in one click.)

Below are basic descriptions for each configured tools.

### Black: Python Code Formatter

Black is an opinionated code formatter that ensures consistent code style across your project. It's designed to be uncompromising, requiring minimal configuration.

- **GitHub**: [Black on GitHub](https://github.com/psf/black)
- **Documentation**: [Black Documentation](https://black.readthedocs.io/en/stable/)

#### Configuration in `pyproject.toml`

```toml
[tool.black]
line-length = 88
skip-string-normalization = true
exclude = '''/(
  \.git
  | \.mypy_cache
  | \.venv
  | \.venv2
  | \.venv3
  | build
  | dist
  | alembic
)/'''
```

**Explanation**:

- `line-length = 88`: Sets the maximum line length to 88 characters, which is Black's default.
- `skip-string-normalization = true`: Prevents Black from converting all string quotes to double quotes.
- `exclude`: Specifies directories and files that Black should not format. This includes version control, cache directories, virtual environments, and build artifacts.

### Ruff: Fast Python Linter

Ruff is a high-performance Python linter written in Rust. It can replace multiple traditional Python linters and fixers, offering significant speed improvements.

- **GitHub**: [Ruff on GitHub](https://github.com/charliermarsh/ruff)
- **Documentation**: [Ruff Documentation](https://beta.ruff.rs/docs/)

#### Configuration in `pyproject.toml`

```toml
[tool.ruff]
line-length = 88
select = ["E", "F", "B", "W", "I", "C", "N"]
ignore = ["E501"]
exclude = [
  ".git",
  ".mypy_cache",
  ".venv",
  ".venv2",
  ".venv3",
  "build",
  "dist",
  "alembic/**/*",
  "*/__init__.py"
]

[tool.ruff.per-file-ignores]
"__init__.py" = ["F401"]

[tool.ruff.isort]
known-third-party = ["fastapi", "pydantic", "sqlalchemy"]
```

**Explanation**:

- `line-length = 88`: Matches Black's default line length for consistency.
- `select`: Enables specific rule sets:
  - `E`: pycodestyle errors
  - `F`: Pyflakes
  - `B`: flake8-bugbear
  - `W`: pycodestyle warnings
  - `I`: isort
  - `C`: mccabe complexity
  - `N`: pep8-naming
- `ignore = ["E501"]`: Disables the line length check (E501) as it's handled by Black.
- `exclude`: Lists directories and files to be ignored by Ruff.
- `per-file-ignores`: Specifies rules to ignore for specific files. Here, unused imports (F401) are allowed in `__init__.py` files.
- `isort`: Configures import sorting, specifying known third-party libraries.

### mypy: Static Type Checker

mypy is an optional static type checker for Python that helps catch type-related errors before runtime.

- **GitHub**: [mypy on GitHub](https://github.com/python/mypy)
- **Documentation**: [mypy Documentation](https://mypy.readthedocs.io/en/stable/)

#### Configuration in `pyproject.toml`

```toml
[tool.mypy]
strict = true
disallow_untyped_defs = false
ignore_missing_imports = true
warn_unused_ignores = true
ignore_errors = false
exclude = '.*/__init__.py'

[[tool.mypy.overrides]]
module = ["fastapi", "pydantic", "sqlalchemy"]
ignore_missing_imports = true
```

**Explanation**:

- `strict = true`: Enables strict type checking for maximum type safety.
- `disallow_untyped_defs = false`: Allows functions without type annotations.
- `ignore_missing_imports = true`: Ignores errors from missing type stubs for third-party libraries.
- `warn_unused_ignores = true`: Warns about unnecessary ignore comments.
- `ignore_errors = false`: Ensures mypy reports all type errors.
- `exclude = '.*/__init__.py'`: Excludes `__init__.py` files from type checking.
- `overrides`: Specifies settings for specific modules, here ignoring missing imports for FastAPI, Pydantic, and SQLAlchemy.

These configurations ensure consistent code style, catch potential errors early, and maintain a high standard of code quality across the project.

## Quick Start

To quickly bootstrap this project structure, you can use our setup script:

Download the setup script,

Using Windows Command Prompt:

Using Windows Command Prompt:

```cmd
curl -o setup.sh https://raw.githubusercontent.com/Promact/fastapi_boilerplate/main/setup.sh
```

Using PowerShell:

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Promact/fastapi_boilerplate/main/setup.sh" -OutFile "setup.sh"
```

Using Linux/Unix terminal:

```bash
wget https://raw.githubusercontent.com/Promact/fastapi_boilerplate/main/setup.sh
```

Using Mac terminal:

```bash
curl -O https://raw.githubusercontent.com/Promact/fastapi_boilerplate/main/setup.sh
```

Run the script,

```bash
chmod +x setup.sh
./setup.sh 'project-name'
```

The setup script will:

1. Create the directory structure
2. Initialize a Python virtual environment
3. Install required dependencies
4. Set up configuration files

Requirements:

- Unix-based terminals (Git bash)
- Python 3.10.4+
- pip
- virtualenv

The script will work the same way as in Unix environments, creating the project structure and setting up dependencies.

To run the project,

```bash
uvicorn app.main: app
```

or

Utilise launch.json with run and debug.
