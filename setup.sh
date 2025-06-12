#!/bin/bash

# Exit on any error
set -e

KERNEL_NAME=${1:-TinyLLM}

echo "Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Create project directories
echo "Creating project directories..."
mkdir -p .vscode data logs models notebooks src

# Create 'placeholder' files
echo "Creating placeholder files..."
echo;>data/.data-files-go-here
echo;>logs/.log-files-go-here
echo;>models/.model-files-go-here
echo;>notebooks/.jupyter-notebooks-go-here
echo;>src/.source-files-go-here

# Create VSCode settings for Linux
echo "Creating VSCode Linux settings..."
cat > .vscode/settings.json <<EOF
{
  "python.pythonPath": "./venv/bin/python",
  "python.envFile": "\${workspaceFolder}/.env",
  "jupyter.executablePath": "./venv/bin/jupyter"
}
EOF

# Create shortcut shell scripts to activate/deactivate
echo "Creating activate/deactivate shortcut scripts..."
echo '#!/bin/bash' > a.sh
echo 'source venv/bin/activate' >> a.sh
chmod +x a.sh

echo '#!/bin/bash' > d.sh
echo 'deactivate' >> d.sh
chmod +x d.sh

# Create requirements.txt
echo "Writing requirements.txt..."
cat > requirements.txt <<EOF
transformers>=4.52.4
accelerate>=0.26.0
bitsandbytes>=0.42.0
datasets>=2.16.0
dataclasses>=0.6
ipykernel>=6.0
jupyterlab>=3.0
ipywidgets>=7.0
matplotlib>=3.5
tensorboard>=2.13
torchvision>=0.18.0
torchaudio>=0.18.0
tqdm>=4.64.0
filelock>=3.12.0
packaging>=21.3
numpy>=1.23.0
pandas>=1.5.0
scikit-learn>=1.3.0
sentencepiece>=0.2.0
EOF

# Upgrade pip
echo "Upgrading pip..."
python -m pip install --upgrade pip

# Install PyTorch with CUDA 12.6 support
echo "Installing PyTorch with CUDA 12.6... (this may take a while)"
pip install torch -i https://download.pytorch.org/whl/cu126

# Install remaining dependencies
echo "Installing other dependencies... (this may take a while longer!)"
pip install -r requirements.txt

# Install Jupyter kernel
echo "Installing Jupyter kernel..."
python -m ipykernel install --user --name="$KERNEL_NAME" --display-name "Python ($KERNEL_NAME)"

echo "Virtual environment created and configured for regular/Jupyter projects on Linux."
