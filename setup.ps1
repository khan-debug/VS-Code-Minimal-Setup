$ErrorActionPreference = "Stop"

$RepoUrl = "https://github.com/khan-debug/VS-Code-Minimal-Setup.git"
$SetupDir = "$HOME\VS-Code-Minimal-Setup"
$VscSource = "$SetupDir\vscodium"
$VscTarget = "$env:APPDATA\VSCodium\User"

# 1. Clone or Update Repository
if (Test-Path "$SetupDir\.git") {
    Write-Host "Updating existing setup..." -ForegroundColor Cyan
    git -C $SetupDir pull
} else {
    Write-Host "Cloning repository..." -ForegroundColor Cyan
    git clone $RepoUrl $SetupDir
}

# 2. Ensure Target Directory Exists
if (!(Test-Path $VscTarget)) {
    New-Item -ItemType Directory -Force -Path $VscTarget | Out-Null
}

# 3. Create Symlinks (or Hard Links as fallback)
Write-Host "Symlinking settings..." -ForegroundColor Cyan
$files = @("settings.json")

foreach ($file in $files) {
    $source = "$VscSource\$file"
    $target = "$VscTarget\$file"

    if (Test-Path $target) {
        Remove-Item $target -Force
    }

    # Windows requires Developer Mode or Administrator privileges for Symbolic Links.
    # We try Symbolic Links first, and fall back to Copy if it fails.
    try {
        New-Item -ItemType SymbolicLink -Path $target -Target $source -Force | Out-Null
        Write-Host " -> Symlinked $file" -ForegroundColor Green
    } catch {
        Write-Host " -> Symlink failed (needs Admin). Copying instead for $file..." -ForegroundColor Yellow
        Copy-Item $source $target -Force
    }
}

# 4. Install Extensions
$extFile = "$VscSource\extensions.txt"
if (Test-Path $extFile) {
    if (!(Get-Command codium -ErrorAction SilentlyContinue)) {
        Write-Host "Warning: 'codium' not found in PATH. Skipping extension install." -ForegroundColor Yellow
    } else {
        Write-Host "Installing extensions..." -ForegroundColor Cyan
        Get-Content $extFile | Where-Object { $_.Trim() -ne "" } | ForEach-Object {
            codium --install-extension $_
        }
    }
}

Write-Host "VSCodium Windows sync complete! 🎉" -ForegroundColor Green
