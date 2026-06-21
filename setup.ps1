$ErrorActionPreference = "Stop"

$RepoUrl = "https://github.com/khan-debug/VS-Code-Minimal-Setup.git"
$SetupDir = "$HOME\VS-Code-Minimal-Setup"

# Editor selection: interactive menu when no arg, direct if specified
$Editor = ""
if ($args.Count -gt 0) {
    $Editor = $args[0].ToLower()
} else {
    Write-Host "Select editor to configure:" -ForegroundColor Cyan
    Write-Host "  1) VS Code"
    Write-Host "  2) VSCodium"
    $choice = Read-Host "Choice [1-2]"
    switch ($choice) {
        "1" { $Editor = "code" }
        "2" { $Editor = "codium" }
        default { Write-Host "Invalid choice. Defaulting to codium." -ForegroundColor Yellow; $Editor = "codium" }
    }
}

switch ($Editor) {
    "code"   { $SrcDir = "vscode";   $VscTarget = "$env:APPDATA\Code\User";      $Cli = "code";   $Name = "VS Code" }
    "codium" { $SrcDir = "vscodium"; $VscTarget = "$env:APPDATA\VSCodium\User";  $Cli = "codium"; $Name = "VSCodium" }
    default  { Write-Error "Usage: setup.ps1 [code|codium]"; exit 1 }
}

$VscSource = "$SetupDir\$SrcDir"

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
    if (!(Get-Command $Cli -ErrorAction SilentlyContinue)) {
        Write-Host "Warning: '$Cli' not found in PATH. Skipping extension install." -ForegroundColor Yellow
    } else {
        Write-Host "Installing extensions..." -ForegroundColor Cyan
        Get-Content $extFile | Where-Object { $_.Trim() -ne "" } | ForEach-Object {
            & $Cli --install-extension $_
        }
    }
}

Write-Host "$Name Windows sync complete! 🎉" -ForegroundColor Green
