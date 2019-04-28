#!/bin/bash
#
# This file was generated! Edits made directly to this file may be lost.
#   Generator:    /home/vedantm97/paritosh/build/commands/utils/genfile.sh
#   Timestamp:    Sun Apr 28 09:26:12 UTC 2019
#   Template Dir: /home/vedantm97/paritosh/build/templates/scripts
#
set -e

WORK_DIR=`pwd`
NUMARGS=$#
ARGS=$*

function logger() {
    TS=`date`
    echo "[$TS] $@"
}

function clone() {
  repo=$1
  directory=$2
  branch=${3:-""}
  noremote=${4:-""}
  
  rm -rf ${directory}

  if [[ ${branch} != "" ]]; then
      logger "Cloning '$branch' branch of $repo"
      # FIXME: --depth 1 is breaking builds - investigate
      #git clone --depth 1 --single-branch -b ${branch} ${repo} ${directory}
      git clone --single-branch -b ${branch} ${repo} ${directory}
  else
      logger "Cloning $repo"
      # FIXME: --depth 1 is breaking builds - investigate
      #git clone --depth 1 ${repo} ${directory}
      git clone ${repo} ${directory}
  fi
  cd ${WORK_DIR}/${directory}

  if [[ ${noremote} == "noremote" ]]; then
      git submodule update --init --recursive
  else
      git submodule update --init --remote --recursive
  fi
  git fetch --tags
  # FIXME: These lines result in an uncommitted file, and a 'dirty' tag to be added to some version strings - are they needed?
  #echo "${repo}" > current-commit.hash
  #git rev-parse HEAD >> current-commit.hash
  cd ${WORK_DIR}
}

function shouldClone {
    (( ${NUMARGS} == 0 )) || (echo " ${ARGS} " | grep -q " $1 ")
}

if shouldClone dask-xgboost; then
   clone https://github.com/rapidsai/dask-xgboost.git dask-xgboost dask-cudf
fi
if shouldClone dask-cuda; then
   clone https://github.com/rapidsai/dask-cuda.git dask-cuda branch-0.7
fi
if shouldClone cudf; then
   clone https://github.com/rapidsai/cudf.git cudf branch-0.7
fi
if shouldClone custrings; then
   clone https://github.com/rapidsai/custrings.git custrings branch-0.4
fi
if shouldClone rmm; then
   clone https://github.com/rapidsai/rmm.git rmm branch-0.7
fi
if shouldClone cuml; then
   clone https://github.com/rapidsai/cuml.git cuml branch-0.7 noremote
fi
if shouldClone xgboost; then
   clone https://github.com/rapidsai/xgboost.git xgboost cudf-interop noremote
fi
if shouldClone cugraph; then
   clone https://github.com/rapidsai/cugraph.git cugraph branch-0.7
fi
if shouldClone notebooks; then
   clone https://github.com/rapidsai/notebooks.git notebooks branch-0.7
fi
if shouldClone dask-cudf; then
   clone https://github.com/rapidsai/dask-cudf.git dask-cudf branch-0.7
fi

logger "Done"
