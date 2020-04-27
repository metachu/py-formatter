# py-formatter CI/CD Linter

Docker command for ci/cd to lint and auto format python. Runs MYPY, ISORT, BLACK and VULTURE

Usage:

```
docker run --rm -it -v \$(pwd):/mnt docker.io/metachu/py-formatter [ format | lint ] paths...
```

Specify environment variables to pass extra arguments to formatters/linters:
- `ISORT_ARGS`
- `BLACK_ARGS`
- `VULTURE_ARGS`
- `MYPY_ARGS`
