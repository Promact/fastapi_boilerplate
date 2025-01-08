#!/bin/bash

# Project name
PROJECT_NAME=${1:-fastapi_boilerplate}

# Folder structure
echo "Creating folder structure for $PROJECT_NAME..."

mkdir -p $PROJECT_NAME/{app/{config,core,db,routes,schemas,models,services,utils,tests},scripts,\.vscode}

# Create an __init__.py file in each subdirectory under app
find $PROJECT_NAME/app -type d -exec touch {}/__init__.py \;

# Files to create
touch $PROJECT_NAME/requirements.txt \
      $PROJECT_NAME/Dockerfile \
      $PROJECT_NAME/.env \
      $PROJECT_NAME/.env.sample \

# Adding comments to files
echo "Adding comments to files..."

# Add comments to main.py
cat <<EOF > $PROJECT_NAME/app/main.py
"""
Main entry point of the FastAPI application.
Contains the initialization of the app and core routes.
"""
EOF

# Add comments to settings.py
cat <<EOF > $PROJECT_NAME/app/config/settings.py
"""
This file contains configuration settings for the application,
such as environment variables and constants.
"""
EOF

# Add comments to logging_config.py
cat <<EOF > $PROJECT_NAME/app/config/logging_config.py
"""
This file defines the logging configuration for the application.
"""
EOF

# Add comments to README.md
cat <<EOF > $PROJECT_NAME/README.md
# $PROJECT_NAME

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

### Black: Python Code Formatter

Black is an opinionated code formatter that ensures consistent code style across your project. It's designed to be uncompromising, requiring minimal configuration.

- **GitHub**: [Black on GitHub](https://github.com/psf/black)
- **Documentation**: [Black Documentation](https://black.readthedocs.io/en/stable/)

#### Configuration in \`pyproject.toml\`

\`\`\`toml
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
\`\`\`

**Explanation**:

- \`line-length = 88\`: Sets the maximum line length to 88 characters, which is Black's default.
- \`skip-string-normalization = true\`: Prevents Black from converting all string quotes to double quotes.
- \`exclude\`: Specifies directories and files that Black should not format. This includes version control, cache directories, virtual environments, and build artifacts.

### Ruff: Fast Python Linter

Ruff is a high-performance Python linter written in Rust. It can replace multiple traditional Python linters and fixers, offering significant speed improvements.

- **GitHub**: [Ruff on GitHub](https://github.com/charliermarsh/ruff)
- **Documentation**: [Ruff Documentation](https://beta.ruff.rs/docs/)

#### Configuration in \`pyproject.toml\`

\`\`\`toml
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
\`\`\`

**Explanation**:

- \`line-length = 88\`: Matches Black's default line length for consistency.
- \`select\`: Enables specific rule sets:
  - \`E\`: pycodestyle errors
  - \`F\`: Pyflakes
  - \`B\`: flake8-bugbear
  - \`W\`: pycodestyle warnings
  - \`I\`: isort
  - \`C\`: mccabe complexity
  - \`N\`: pep8-naming
- \`ignore = ["E501"]\`: Disables the line length check (E501) as it's handled by Black.
- \`exclude\`: Lists directories and files to be ignored by Ruff.
- \`per-file-ignores\`: Specifies rules to ignore for specific files. Here, unused imports (F401) are allowed in \`__init__.py\` files.
- \`isort\`: Configures import sorting, specifying known third-party libraries.

### mypy: Static Type Checker

mypy is an optional static type checker for Python that helps catch type-related errors before runtime.

- **GitHub**: [mypy on GitHub](https://github.com/python/mypy)
- **Documentation**: [mypy Documentation](https://mypy.readthedocs.io/en/stable/)

#### Configuration in \`pyproject.toml\`

\`\`\`toml
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
\`\`\`

**Explanation**:

- \`strict = true\`: Enables strict type checking for maximum type safety.
- \`disallow_untyped_defs = false\`: Allows functions without type annotations.
- \`ignore_missing_imports = true\`: Ignores errors from missing type stubs for third-party libraries.
- \`warn_unused_ignores = true\`: Warns about unnecessary ignore comments.
- \`ignore_errors = false\`: Ensures mypy reports all type errors.
- \`exclude = '.*/__init__.py'\`: Excludes \`__init__.py\` files from type checking.
- \`overrides\`: Specifies settings for specific modules, here ignoring missing imports for FastAPI, Pydantic, and SQLAlchemy.

These configurations ensure consistent code style, catch potential errors early, and maintain a high standard of code quality across the project.

EOF

# Add comments to .gitignore
cat <<EOF > $PROJECT_NAME/.gitignore
# Ignore Python cache files
*.pyc
__pycache__/
*.ruff_cache

# Environment files
.env

# Virtual environment
.venv
venv

# Ignore logs
*.log
EOF

# Add comments to core files
cat <<EOF > $PROJECT_NAME/app/core/dependencies.py
"""
Defines shared dependencies used across the application.
"""
EOF

cat <<EOF > $PROJECT_NAME/app/core/events.py
"""
Defines application event handlers (startup, shutdown, etc.).
"""
EOF

# Add comments to db files
cat <<EOF > $PROJECT_NAME/app/db/base.py
"""
Defines the base class for database ORM models.
"""
EOF

cat <<EOF > $PROJECT_NAME/app/db/session.py
"""
Manages the database session creation and lifecycle.
"""
EOF

# Add comments to routes files
cat <<EOF > $PROJECT_NAME/app/routes/users.py
"""
Defines user-related API endpoints.
"""
EOF

cat <<EOF > $PROJECT_NAME/app/routes/items.py
"""
Defines item-related API endpoints.
"""
EOF

cat <<EOF > $PROJECT_NAME/app/routes/auth.py
"""
Defines authentication-related API endpoints.
"""
EOF

# Add comments to schema files
cat <<EOF > $PROJECT_NAME/app/schemas/user.py
"""
Pydantic schemas for user-related operations.
"""
EOF

cat <<EOF > $PROJECT_NAME/app/schemas/item.py
"""
Pydantic schemas for item-related operations.
"""
EOF

# Add comments to model files
cat <<EOF > $PROJECT_NAME/app/models/user.py
"""
Database ORM models for users.
"""
EOF

cat <<EOF > $PROJECT_NAME/app/models/item.py
"""
Database ORM models for items.
"""
EOF

# Add comments to service files
cat <<EOF > $PROJECT_NAME/app/services/user_service.py
"""
Business logic for user-related operations.
"""
EOF

cat <<EOF > $PROJECT_NAME/app/services/item_service.py
"""
Business logic for item-related operations.
"""
EOF

# Add comments to utils files
cat <<EOF > $PROJECT_NAME/app/utils/email.py
"""
Utility functions for sending emails.
"""
EOF

cat <<EOF > $PROJECT_NAME/app/utils/hash.py
"""
Utility functions for hashing passwords.
"""
EOF

cat <<EOF > $PROJECT_NAME/app/utils/validators.py
"""
Custom validation utilities.
"""
EOF

# Add comments to test files
cat <<EOF > $PROJECT_NAME/app/tests/conftest.py
"""
Test configuration and fixtures.
"""
EOF

cat <<EOF > $PROJECT_NAME/app/tests/test_main.py
"""
Unit tests for the main application entry point.
"""
EOF

cat <<EOF > $PROJECT_NAME/app/tests/test_users.py
"""
Unit tests for user-related functionality.
"""
EOF

cat <<EOF > $PROJECT_NAME/app/tests/test_items.py
"""
Unit tests for item-related functionality.
"""
EOF

# Create launch.json file
cat << EOF > $PROJECT_NAME/.vscode/launch.json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Python Debugger: FastAPI",
      "type": "debugpy",
      "request": "launch",
      "module": "uvicorn",
      "args": ["app.main:app", "--reload"],
      "jinja": true
    }
  ]
}
EOF

# Create extensions.json file
cat << EOF > $PROJECT_NAME/.vscode/extensions.json
{
  "recommendations": [
    "charliermarsh.ruff",
    "codezombiech.gitignore",
    "cstrap.python-snippets",
    "kevinrose.vsc-python-indent",
    "mechatroner.rainbow-csv",
    "ms-python.black-formatter",
    "ms-python.debugpy",
    "ms-python.isort",
    "ms-python.python",
    "njqdev.vscode-python-typehint",
    "oderwat.indent-rainbow",
    "usernamehw.errorlens",
    "ms-python.mypy-type-checker"
  ]
}
EOF



# Create main.py
cat << EOF > $PROJECT_NAME/app/main.py
"""
Main FastAPI application file.
Define your FastAPI app and include routers here.
"""
from fastapi import FastAPI

app = FastAPI()

# Include your routers here
# from app.routes import users, items
# app.include_router(users.router)
# app.include_router(items.router)

@app.get("/")
async def root():
    return {"message": "Hello World"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
EOF

# Create pyproject.toml
cat << EOF > $PROJECT_NAME/pyproject.toml
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

[tool.ruff]
line-length = 88
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

[tool.ruff.lint]
select = ["E", "F", "B", "W", "I", "C", "N"]
ignore = ["E501"]
per-file-ignores = { "__init__.py" = ["F401"] }

[tool.ruff.lint.isort]
known-third-party = ["fastapi", "pydantic", "sqlalchemy"]

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

[build-system]
requires = ["setuptools", "wheel"]
build-backend = "setuptools.build_meta"

EOF

# Create check_server.sh
cat << EOF > $PROJECT_NAME/scripts/run_lint_checks.sh
#!/usr/bin/env bash

set -e

echo "Running code checks..."

# Determine Python command
if command -v python3 &> /dev/null; then
    PYTHON=python3
elif command -v python &> /dev/null; then
    PYTHON=python
else
    echo "Error: Python not found. Please install Python 3."
    exit 1
fi

# Function to run checks
run_check() {
    if command -v "$1" &> /dev/null; then
        echo "Running $1..."
        "$@"
    else
        echo "Warning: $1 not found. Skipping."
    fi
}

# Change to the project root directory
cd "$(dirname "$0")/.."

# Ensure pyproject.toml exists
if [ ! -f pyproject.toml ]; then
    echo "Error: pyproject.toml not found in the project root."
    exit 1
fi

# Run Black
run_check black --config pyproject.toml .

# Run Ruff
run_check ruff check --config pyproject.toml .

# Run mypy
run_check mypy --config-file pyproject.toml .

echo "All checks completed!"

EOF

chmod +x $PROJECT_NAME/scripts/run_lint_checks.sh

# Create requirements.txt with basic FastAPI requirements
cat << EOF > $PROJECT_NAME/requirements.txt
fastapi
uvicorn
pydantic
sqlalchemy
alembic
python-dotenv
black
ruff
mypy
EOF

echo "Project structure created"

# Install uv
echo "Installing uv..."
pip install uv

# Create virtual environment using uv
echo "Creating virtual environment..."
cd $PROJECT_NAME
uv venv

# Activate virtual environment and install dependencies
echo "Activating virtual environment and installing dependencies..."
if [ -f ".venv/Scripts/activate" ]; then
    source .venv/Scripts/activate
else
    source .venv/bin/activate
fi
uv pip install -r requirements.txt

echo "Project structure created successfully!"
echo "Virtual environment activated and dependencies installed."
echo "To deactivate the virtual environment, run: deactivate"
