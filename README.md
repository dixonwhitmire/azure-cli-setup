# Azure-Cli-Setup
A setup tool used to provision a Python3 virtual environment for use with Microsoft's Azure CLI library. The setup script 
executes the following tasks:
- Creates a python3 virtual environment to support the Azure CLI.
- Installs the [Azure CLI](https://pypi.org/project/azure-cli/).
- Optionally appends a CA bundle (PEM file) to the virtual environment's CA bundle.

## Requirements
- Python 3.x
- OS X or "nix" Operating System

## Script Arguments
| Argument | Description | Required |
| --------- | ---------- | --------- | 
| VENV_PATH | The path to the target virtual environment. | Y |
| PYTHON_COMMAND | The name of the Python 3.x command/interpreter on the system. | Y |
| CERT_PATH | Used to append a custom CA bundle (PEM format) to the environment's registered bundle. Useful in environments which utilize a proxy server. | N |

## Usage
Installs the Azure-CLI within a virtual environment using a standard CA bundle.
```
./install-azure-cli.sh venv python3
```

Installs the Azure-CLI within a virtual environment, including a custom CA bundle.
```
./install-azure-cli.sh venv python3 /etc/certs/custom-bundle.pem
```


## Running the Azure-CLI
Start the virtual environment
```
source venv/bin/activate
```

Launch the Azure login screen and authenticate.
```
az login
```

Successful authentication returns a response simliar to
```
Note, we have launched a browser for you to login. For old experience with device code, use "az login --use-device-code"
You have logged in. Now let us find all the subscriptions to which you have access...
[
  {
    "cloudName": "AzureCloud",
    "id": "<resource id>",
    "isDefault": true,
    "name": "Sandbox",
    "state": "Enabled",
    "tenantId": "<tenant id>",
    "user": {
      "name": "john.doe@bigco.com",
      "type": "user"
    }
  }
]
```
