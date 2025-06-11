# Python LLM Project Template

A ready-to-use template for setting up a Python development environment for LLM (Large Language Model) projects. Includes scripts for Windows, Linux, and PowerShell environments.

## Features

- Automatic virtual environment creation
- Project directory structure setup
- VSCode configuration
- Jupyter kernel installation
- CUDA-enabled PyTorch installation
- Common LLM dependencies pre-configured

## Prerequisites

- Python 3.12
- pip
- Git (optional)
- NVIDIA CUDA 12.6 (for GPU support - optional)

## Installation
Choose the appropriate setup script for your operating system:

### Windows
```
cmd
setup.bat [KERNEL_NAME]
```

### Linux/macOS
```
chmod +x setup.sh
./setup.sh [KERNEL_NAME]
```

### PowerShell (Cross-platform)
```
.\setup.ps1 -KernelName [KERNEL_NAME]
```

Note: Replace [KERNEL_NAME] with your preferred Jupyter kernel name (default: "TinyLLM").

## Project Structure
After setup, your project will have the following structure:
```
project-root/
│
├── .vscode/               # VSCode settings
│      └── settings.json   # VSCode settings JSON file
├── data/                  # Dataset storage
├── logs/                  # Training logs
├── models/                # Model checkpoints
├── notebooks/             # Jupyter notebooks
├── src/                   # Source code
├── venv/                  # Virtual environment
├── a.bat/a.sh             # Quick activate script
├── d.bat/d.sh             # Quick deactivate script
└── requirements.txt       # Project dependencies
```
Note: Don't forget to change the ptoject-root (LLM-Template) to your project name.

## Included Packages
The template installs the following key packages:

PyTorch with CUDA 12.6 support

Transformers (Hugging Face)

Jupyter Lab and IPython kernel

Data science stack (NumPy, Pandas, scikit-learn)

Training utilities (tqdm, tensorboard, datasets)

## Usage
1. Activate the virtual environment:
    - Windows: Run a.bat or .\venv\Scripts\activate
    - Linux/macOS: Run source a.sh or source venv/bin/activate

2. Start Jupyter Lab:
```
jupyter lab
```

3. Deactivate the environment when done:
    - Windows: Run d.bat or deactivate
    - Linux/macOS: Run source d.sh or deactivate

## Customization
1. Add new dependencies:
    - Add packages to requirements.txt
    - Run pip install -r requirements.txt
2. Change Jupyter kernel name:
    - Pass your preferred name as an argument to the setup script
3. Modify VSCode settings:
    - Edit .vscode/settings.json

## Notes
- The setup scripts assume you have Python added to your PATH.
- For GPU support, ensure you have compatible NVIDIA drivers and CUDA installed.
- The template uses PyTorch with CUDA 12.6 by default. Modify the setup scripts if you need a different version.

## License
This template is provided under the MIT License. Feel free to modify and use it for your projects.














