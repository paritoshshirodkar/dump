#!/bin/bash
#
# This file was generated! Edits made directly to this file may be lost.
#   Generator:    /home/vedantm97/paritosh/build/commands/utils/genfile.sh
#   Timestamp:    Sun Apr 28 09:26:12 UTC 2019
#   Template Dir: /home/vedantm97/paritosh/build/templates/scripts
#
set -e

NUMARGS=$#
ARGS=$*
function shouldBuild {
    (( ${NUMARGS} == 0 )) || (echo " ${ARGS} " | grep -q " $1 ")
}

####################
# rmm
if shouldBuild rmm; then
    pushd .
    
    cd rmm && mkdir -p build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX \
          -DCMAKE_CXX11_ABI=ON \
          -DCMAKE_BUILD_TYPE=release .. && \
    make -j && make -j install && \
    make rmm_python_cffi && make rmm_install_python && \
    cd ../python && python setup.py build_ext --inplace && \
    python setup.py install

    exitCode=$?
    if (( ${exitCode} != 0 )); then
        exit ${exitCode}
    fi
    popd
fi
####################
# custrings
if shouldBuild custrings; then
    pushd .
    
    cd custrings/cpp && mkdir -p build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX \
          -DCMAKE_CXX11_ABI=ON \
          -DCMAKE_BUILD_TYPE=release .. && \
    make -j && make -j install && \
    cd ../../python && \
    python setup.py install --single-version-externally-managed --record=record.txt

    exitCode=$?
    if (( ${exitCode} != 0 )); then
        exit ${exitCode}
    fi
    popd
fi
####################
# cudf
if shouldBuild cudf; then
    pushd .
    
    cd cudf/cpp && mkdir -p build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX \
          -DCMAKE_CXX11_ABI=ON \
          -DCMAKE_BUILD_TYPE=release .. && \
    make -j && make -j install && \
    make python_cffi && make install_python && \
    cd ../../python && python setup.py build_ext --inplace && \
    python setup.py install

    exitCode=$?
    if (( ${exitCode} != 0 )); then
        exit ${exitCode}
    fi
    popd
fi
####################
# cuml
if shouldBuild cuml; then
    pushd .
    
    # Set the multigpu option based on CUDA_VERSION env var
    # Version 9.2 will disable multigpu, all others assume it should be
    # enabled.
    MULTIGPU_OPTION=""
    if [[ ${CUDA_VERSION} != "9.2" ]]; then
        MULTIGPU_OPTION=--multigpu
    fi
    
    # FIXME: -DCMAKE_BUILD_TYPE should be set to release! This is working
    # around a cuML bug.
    cd cuml/cuML && mkdir -p build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX \
          -DCMAKE_CXX11_ABI=ON \
          -DCMAKE_BUILD_TYPE=debug .. && \
    make -j && make -j install && \
    cd ../../python && python setup.py build_ext --inplace ${MULTIGPU_OPTION} && \
    python setup.py install ${MULTIGPU_OPTION}

    exitCode=$?
    if (( ${exitCode} != 0 )); then
        exit ${exitCode}
    fi
    popd
fi
####################
# cugraph
if shouldBuild cugraph; then
    pushd .
    
    cd cugraph/cpp && mkdir -p build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX \
          -DCMAKE_CXX11_ABI=ON \
          -DNVG_PLUGIN=True \
          -DCMAKE_BUILD_TYPE=release .. && \
    make -j && make -j install && \
    cd ../../python && python setup.py build_ext --inplace && \
    python setup.py install

    exitCode=$?
    if (( ${exitCode} != 0 )); then
        exit ${exitCode}
    fi
    popd
fi
####################
# xgboost
if shouldBuild xgboost; then
    pushd .
    
    cd xgboost && mkdir -p build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX \
          -DUSE_NCCL=ON -DUSE_CUDA=ON -DUSE_CUDF=ON \
          -DGDF_INCLUDE_DIR=$CONDA_PREFIX/include \
          -DCMAKE_CXX11_ABI=ON \
          -DCMAKE_BUILD_TYPE=release .. && \
    make -j && make -j install && \
    cd ../python-package && python setup.py install

    exitCode=$?
    if (( ${exitCode} != 0 )); then
        exit ${exitCode}
    fi
    popd
fi
####################
# dask-xgboost
if shouldBuild dask-xgboost; then
    pushd .
    
    cd dask-xgboost && \
    python setup.py install

    exitCode=$?
    if (( ${exitCode} != 0 )); then
        exit ${exitCode}
    fi
    popd
fi
####################
# dask-cudf
if shouldBuild dask-cudf; then
    pushd .
    
    cd dask-cudf && \
    python setup.py install

    exitCode=$?
    if (( ${exitCode} != 0 )); then
        exit ${exitCode}
    fi
    popd
fi
####################
# dask-cuda
if shouldBuild dask-cuda; then
    pushd .
    
    cd dask-cuda && \
    python setup.py install

    exitCode=$?
    if (( ${exitCode} != 0 )); then
        exit ${exitCode}
    fi
    popd
fi
