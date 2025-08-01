@echo off

set KERNEL_NAME=CustomLLM
if not "%~1"=="" set KERNEL_NAME=%~1

:: Create virtual environment
echo "Creating virtual environment..."
python -m venv venv
call venv\Scripts\activate.bat

:: Make directories for project
echo "Creating project directories..."
mkdir .vscode data logs models notebooks src

:: Create 'placeholder' files
echo "Creating placeholder files..."
echo;>data/.data-files-go-here
echo;>logs/.log-files-go-here
echo;>models/.model-files-go-here
echo;>notebooks/.jupyter-notebooks-go-here
echo;>src/.source-files-go-here

:: Create VSCode settings files (Windows)
echo "Creating VSCode Windows settings..."
echo { > ./.vscode/settings.json
echo   "python.pythonPath": ".\\venv\\Scripts\\python.exe", >> ./.vscode/settings.json
echo   "jupyter.executablePath": ".\\venv\\Scripts\\jupyter.exe" >> ./.vscode/settings.json
echo } >> ./.vscode/settings.json

:: Create shortcuts to Activate & Deactivate environment
echo "Creating activate/deactivate shortcut scripts..."
echo @echo off > a.bat
echo call venv\Scripts\activate.bat >> a.bat
echo @echo off > d.bat
echo call venv\Scripts\deactivate.bat >> d.bat

:: Create requirements.txt file
echo "Writing requirements.txt..."
echo transformers^>=4.52.4 > requirements.txt
echo accelerate^>=0.26.0 >> requirements.txt
echo bitsandbytes^>=0.42.0 >> requirements.txt
echo datasets^>=2.16.0 >> requirements.txt
echo dataclasses^>=0.6 >> requirements.txt
echo ipykernel^>=6.0 >> requirements.txt
echo jupyterlab^>=3.0 >> requirements.txt
echo ipywidgets^>=7.0 >> requirements.txt
echo matplotlib^>=3.5 >> requirements.txt
echo tensorboard^>=2.13 >> requirements.txt
echo tqdm^>=4.64.0 >> requirements.txt
echo filelock^>=3.12.0 >> requirements.txt
echo packaging^>=21.3 >> requirements.txt
echo numpy^>=1.23.0 >> requirements.txt
echo pandas^>=1.5.0 >> requirements.txt
echo scikit-learn^>=1.3.0 >> requirements.txt
echo sentencepiece^>=0.2.0 >> requirements.txt
echo peft^>=0.15.2 >> requirements.txt
echo cupy_cuda12x^>=13.4.1 >> requirements.txt
echo onnxruntime-gpu^>=1.22.0 >> requirements.txt
echo ctranslate2^>=4.6.0 >> requirements.txt

:: Upgrade pip version
echo "Upgrading pip..."
python.exe -m pip install --upgrade pip

:: Install PyTorch with CUDA 12.8 support
echo "Installing PyTorch with CUDA 12.8... (this may take a while)"
pip install torch torchaudio torchvision -i https://download.pytorch.org/whl/cu128

:: Install other dependencies
echo "Installing other dependencies... (this may take a while longer!)"
pip install -r requirements.txt

:: Install Jupyter kernel
echo "Installing Jupyter kernel..."
python -m ipykernel install --user --name=%KERNEL_NAME% --display-name "Python (%KERNEL_NAME%)"

echo Virtual environment created and configured for regular/Jupyter projects on Windows.
