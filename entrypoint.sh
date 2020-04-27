#!/bin/sh
cmd=${1:- help}
PYPROJECT_PATH=${PYPROJECT_PATH:-"/code/pyproject.toml"}
config="--config-file ${PYPROJECT_PATH}"
MNT=${MNT:-/mnt/}

buildFileNames() {
	for x in $@; do
		filenames="${filenames} ${MNT}${x} "
	done
}

case $cmd in
	format)
		shift;
		buildFileNames $@
		set -x
		poetry run isort --recursive ${ISORT_ARGS} $filenames
		poetry run black ${BLACK_ARGS} $filenames
		;;
	lint)
		shift;
		buildFileNames $@
		set -x
	  	poetry run isort ${ISORT_ARGS} --check --recursive $filenames
        	poetry run black ${BLACK_ARGS} --check $filenames
        	poetry run mypy ${MYPY_ARGS} --pretty --follow-imports=skip --config-file pyproject.toml $filenames
		poetry run vulture ${VULTURE_ARGS} --min-confidence 70 $filenames
		;;
	*)
		echo -n "Error: specify "format" or "lint"\nUsage: docker run --rm -it -v \$(pwd):/mnt docker.io/metachu/py-formatter [ format | lint ] paths... \nSpecify ISORT_ARGS, BLACK_ARGS, MYPY_ARGS, VULTURE_ARGS for additional tooling arguments\n "
	;;
esac



