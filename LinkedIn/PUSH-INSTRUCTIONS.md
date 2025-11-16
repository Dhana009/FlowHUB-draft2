# Push LinkedIn Folder to GitHub

Simple commands to push the LinkedIn folder to GitHub repo.

## Quick Commands (Copy & Paste)

```powershell
# 1. Go to parent directory
cd ..

# 2. Clone repo (first time only)
git clone https://github.com/Dhana009/FlowHUB_Linkedin.git

# 3. Remove old LinkedIn folder
Remove-Item -Path "FlowHUB_Linkedin\LinkedIn" -Recurse -Force

# 4. Copy LinkedIn folder
Copy-Item -Path "planning\FlowHUB_Project\LinkedIn" -Destination "FlowHUB_Linkedin\LinkedIn" -Recurse -Force

# 5. Remove .git if exists
if (Test-Path "FlowHUB_Linkedin\LinkedIn\.git") {
    Remove-Item -Path "FlowHUB_Linkedin\LinkedIn\.git" -Recurse -Force
}

# 6. Go to repo
cd FlowHUB_Linkedin

# 7. Push
git add LinkedIn/
git commit -m "Update LinkedIn folder"
git push origin main
```

## Or Use the Script

**From PowerShell:**
```powershell
# Option 1: From FlowHUB_Project directory
.\LinkedIn\push-to-github.ps1

# Option 2: From LinkedIn directory
.\push-to-github.ps1
```

**From CMD (Command Prompt):**
```cmd
# Option 1: From FlowHUB_Project directory
.\LinkedIn\push-to-github.bat

# Option 2: From LinkedIn directory
.\push-to-github.bat
```

## Repository
https://github.com/Dhana009/FlowHUB_Linkedin

