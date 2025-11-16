# Push LinkedIn Folder to GitHub

Simple way to push the LinkedIn folder to GitHub repo.

## Quick Start

**Just run one of these:**

### From PowerShell:
```powershell
# From FlowHUB_Project directory
.\LinkedIn\push-to-github.ps1

# OR from LinkedIn directory
.\push-to-github.ps1
```

### From CMD (Command Prompt):
```cmd
# From FlowHUB_Project directory
.\LinkedIn\push-to-github.bat

# OR from LinkedIn directory
.\push-to-github.bat
```

That's it! The script will:
1. ✅ Clone repo if needed
2. ✅ Copy LinkedIn folder
3. ✅ Pull latest changes
4. ✅ Commit and push

---

## Manual Commands (If Needed)

If you prefer to do it manually:

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

# 7. Pull and push
git pull origin main
git add LinkedIn/
git commit -m "Update LinkedIn folder"
git push origin main
```

---

## Repository
https://github.com/Dhana009/FlowHUB_Linkedin

---

## Troubleshooting

**Error: "Failed to push"**
- Check your GitHub credentials
- Make sure you have write access to the repo

**Error: "Cannot find path"**
- Make sure you're running from FlowHUB_Project or LinkedIn directory

**No changes detected**
- This is normal if the folder hasn't changed since last push
