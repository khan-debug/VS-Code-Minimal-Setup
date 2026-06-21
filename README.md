# VSCodium Minimal Setup

A minimal, automated dotfiles repository to synchronize VSCodium settings and extensions across Linux and Windows environments.

🔗 **Repository:** [khan-debug/VS-Code-Minimal-Setup](https://github.com/khan-debug/VS-Code-Minimal-Setup)

## 🚀 Quick Start (For My Machines)

Run one of these commands on any new machine to clone the repo, symlink configurations, and install all extensions:

**Linux:**
```bash
bash <(curl -s https://raw.githubusercontent.com/khan-debug/VS-Code-Minimal-Setup/main/setup.sh)
```

**Windows (PowerShell):**
```powershell
iex "& { $(irm https://raw.githubusercontent.com/khan-debug/VS-Code-Minimal-Setup/main/setup.ps1) }"
```

## 🛠️ Make It Your Own (For Other Users)

If you are a visitor wanting to use this template for your own VSCodium setup, you must configure it to sync with your own GitHub repository:

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
   codium --list-extensions > ~/VS-Code-Minimal-Setup/vscodium/extensions.txt
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
   git add .
   git commit -m "chore: initial setup for my vscodium"
   git branch -M main
   git push -u origin main
   ```

## 📂 Structure

```text
.
├── setup.sh                 # Linux automation script
├── setup.ps1                # Windows automation script
└── vscodium/
    ├── settings.json        # User settings
    └── extensions.txt       # Exported list of extensions
```

## 🔄 Updating Configurations

When you modify settings or add new extensions, update your remote repository:

1. Export the latest extension list:
   ```bash
   codium --list-extensions > ~/VS-Code-Minimal-Setup/vscodium/extensions.txt
   ```
2. Commit and push:
   ```bash
   cd ~/VS-Code-Minimal-Setup
   git add .
   git commit -m "chore: update settings and extensions"
   git push
   ```

