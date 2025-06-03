param(
    [string]$KernelName = "TinyLLM"
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
"@ | Set-Content requirements.txt

Write-Host "Installing packages..."
python -m pip install --upgrade pip
pip install torch -i https://download.pytorch.org/whl/cu126
pip install -r requirements.txt

Write-Host "Installing Jupyter kernel: $KernelName"
python -m ipykernel install --user --name=$KernelName --display-name "Python ($KernelName)"

Write-Host "✅ Setup complete!"
