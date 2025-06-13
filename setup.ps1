# set default Kernel name (edit to change)
param(
    [string]$KernelName = "CustomLLM"
)

Write-Host "Creating virtual environment..."
python -m venv venv

if ($IsWindows) {
    .\venv\Scripts\Activate.ps1
} else {
    source ./venv/bin/activate
}

Write-Host "Creating project directories..."
$dirs = @(".vscode", "data", "logs", "models", "notebooks", "src")
foreach ($dir in $dirs) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
}

Write-Host "Creating placeholder files..."
New-Item -ItemType File -Path "data/.data-files-go-here" -Force | Out-Null
New-Item -ItemType File -Path "logs/.log-files-go-here" -Force | Out-Null
New-Item -ItemType File -Path "models/.model-files-go-here" -Force | Out-Null
New-Item -ItemType File -Path "notebooks/.jupyter-notebooks-go-here" -Force | Out-Null
New-Item -ItemType File -Path "src/.source-files-go-here" -Force | Out-Null

Write-Host "Creating VSCode settings..."
$settings = if ($IsWindows) {
@"
{
  "python.pythonPath": ".\\venv\\Scripts\\python.exe",
  "jupyter.executablePath": ".\\venv\\Scripts\\jupyter.exe"
}
"@
} else {
@"
{
  "python.pythonPath": "./venv/bin/python",
  "python.envFile": "\${workspaceFolder}/.env",
  "jupyter.executablePath": "./venv/bin/jupyter"
}
"@
}
$settings | Out-File -Encoding utf8 .vscode/settings.json

Write-Host "Writing requirements.txt..."
@"
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
peft>=0.15.2
"@ | Set-Content requirements.txt

Write-Host "Upgrading pip version..."
python -m pip install --upgrade pip

# change if you want a different version
Write-Host "Installing PyTorch with CUDA 12.6... (this may take a while)"
pip install torch -i https://download.pytorch.org/whl/cu126

Write-Host "Installing other dependencies... (this may take a while longer!)"
pip install -r requirements.txt

Write-Host "Installing Jupyter kernel: $KernelName"
python -m ipykernel install --user --name=$KernelName --display-name "Python ($KernelName)"

Write-Host "✅ Virtual environment created and configured for regular/Jupyter projects!"
