#!/usr/bin/env bash

# usage, inside your project directory
# `pyinit <python_version>`

# uncomment to debug
# set -x

set -Eeuo pipefail

python_version="${1}"
environment_name="$(basename "$(pwd)")"

pyenv local "${python_version}"
python -m venv --prompt="${environment_name}" --clear --upgrade-deps venv

venv/bin/python -m pip install mypy flake8 black isort
cat <<_end_of_text >requirements_dev.txt
-r requirements.txt

_end_of_text
venv/bin/python -m pip freeze >>requirements_dev.txt

touch requirements.txt
touch requirements_lock.txt

cat <<_end_of_text >.flake8
[flake8]
max-line-length = 88
extend-ignore = E203
_end_of_text

cat <<_end_of_text >.isort.cfg
[settings]
profile = black
_end_of_text

echo "The Python environment \"${environment_name}\" was successfully initialized. Remember to run \`source venv/bin/activate\`"
