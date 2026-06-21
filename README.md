# VS Code / VSCodium Minimal Setup

A minimal, automated dotfiles repository to sync settings and extensions for **VS Code** and **VSCodium** across Linux and Windows.

🔗 **Repository:** [khan-debug/VS-Code-Minimal-Setup](https://github.com/khan-debug/VS-Code-Minimal-Setup)

## 🚀 Quick Start (For My Machines)

Pick your editor and run the corresponding one-liner:

### VS Code

**Linux:**
```bash
bash <(curl -s https://raw.githubusercontent.com/khan-debug/VS-Code-Minimal-Setup/main/setup.sh) code
```

**Windows (PowerShell):**
```powershell
iex "& { $(irm https://raw.githubusercontent.com/khan-debug/VS-Code-Minimal-Setup/main/setup.ps1) }" code
```

### VSCodium

**Linux:**
```bash
bash <(curl -s https://raw.githubusercontent.com/khan-debug/VS-Code-Minimal-Setup/main/setup.sh) codium
```

**Windows (PowerShell):**
```powershell
iex "& { $(irm https://raw.githubusercontent.com/khan-debug/VS-Code-Minimal-Setup/main/setup.ps1) }" codium
```

If you omit the argument, `codium` is used as the default (backward compatible).

## 🛠️ Make It Your Own (For Other Users)

If you are a visitor wanting to use this template for your own setup, you must configure it to sync with your own GitHub repository:

1. **Clone and Remove Git Tracking:**
   ```bash
   git clone https://github.com/khan-debug/VS-Code-Minimal-Setup.git ~/VS-Code-Minimal-Setup
   cd ~/VS-Code-Minimal-Setup
   rm -rf .git
   git init
   ```

2. **Point to Your Own Repository:**
   Open the `setup.sh` file and change the `REPO_URL` variable to your own GitHub repository link:
   ```bash
   REPO_URL="https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git"
   ```

3. **Export Your Settings & Push:**
   Replace the default settings with your own, export your extensions, and push to your new repo:
   ```bash
   # For VSCodium
   codium --list-extensions > ~/VS-Code-Minimal-Setup/vscodium/extensions.txt
   # For VS Code
   code --list-extensions > ~/VS-Code-Minimal-Setup/vscode/extensions.txt

   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
   git add .
   git commit -m "chore: initial setup"
   git branch -M main
   git push -u origin main
   ```

## 📂 Structure

```text
.
├── setup.sh                 # Linux automation script (./setup.sh [code|codium])
├── setup.ps1                # Windows automation script
├── vscode/
│   ├── settings.json        # VS Code user settings
│   └── extensions.txt       # VS Code extension list
└── vscodium/
    ├── settings.json        # VSCodium user settings
    └── extensions.txt       # VSCodium extension list
```

## 🔄 Updating Configurations

When you modify settings or add new extensions, update your remote repository:

1. Export the latest extension list:
   ```bash
   # For VSCodium
   codium --list-extensions > ~/VS-Code-Minimal-Setup/vscodium/extensions.txt
   # For VS Code
   code --list-extensions > ~/VS-Code-Minimal-Setup/vscode/extensions.txt
   ```
2. Commit and push:
   ```bash
   cd ~/VS-Code-Minimal-Setup
   git add .
   git commit -m "chore: update settings and extensions"
   git push
   ```

