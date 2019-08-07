#!/bin/bash
#
# install-azure-cli.sh
# Creates a Python 3 based virtual environment for the Azure CLI tools in a specified directory.
#
# Arguments:
# -VENV_PATH: The path to including the name of the virtual environment directory (Required).
# -PYTHON_COMMAND: The python command used to launch the Python 3 executable (Required).
# -CERT_PATH: The path to a PEM file containing additional CA certs (Optional).

set -e

if [[ $# -lt 2 ]]; then 
    echo "Usage: install-azure-cli.sh VENV_PATH PYTHON_COMMAND [CERT_PATH]"
    exit 1;
fi

VENV_PATH=${1}
PYTHON_COMMAND=${2}
CERT_PATH=${3:-""}

if [[ -z $(which ${PYTHON_COMMAND}) ]]; then
   echo "Unable to find Python3 installation"
   exit 1;
fi

echo "Setting virtual environment to  ${VENV_PATH}"

if [[ -z ${CERT_PATH} ]]; then
    echo "CERT_PATH not provided"
else
    echo "CERT_PATH set to ${CERT_PATH}"
fi


echo "Creating virtual environment . . ."
if [[ -d ${VENV_PATH} ]] && [[ ${VENV_PATH} != "/" ]]; then
   echo "Removing existing Virtual Environment Directory ${VENV_PATH}"
   rm -rf ${VENV_PATH}
fi

$(${PYTHON_COMMAND} -m venv ${VENV_PATH})
source ${VENV_PATH}/bin/activate && \
   pip install --upgrade pip && \
   pip install azure-cli

# Append additional certs to the CA Bundle if provided
CERT_BUNDLE=$(${PYTHON_COMMAND} -m certifi)

if [[ -n ${CERT_PATH} ]] && [[ -n ${CERT_BUNDLE} ]]; then
  echo "Appending CERT_PATH to ${CERT_PATH} to Bundle ${CERT_BUNDLE}"
  cat ${CERT_PATH} >> ${CERT_BUNDLE}  
fi