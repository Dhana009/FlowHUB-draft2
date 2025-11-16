# Push LinkedIn folder to GitHub repo
# Usage: Run from FlowHUB_Project or LinkedIn directory
# .\LinkedIn\push-to-github.ps1


# # You're already in LinkedIn folder, just run:
#  .\push-to-github.ps1

#Now you can run from CMD:
# .\LinkedIn\push-to-github.bat


# Get the script's directory (LinkedIn folder)
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
# Get FlowHUB_Project directory (parent of LinkedIn)
$projectDir = Split-Path -Parent $scriptDir
# Get planning directory (parent of FlowHUB_Project)
$planningDir = Split-Path -Parent $projectDir

# Step 1: Go to planning directory
Set-Location $planningDir

# Step 2: Clone the repo (if not already cloned)
if (-not (Test-Path "FlowHUB_Linkedin")) {
    git clone https://github.com/Dhana009/FlowHUB_Linkedin.git
}

# Step 3: Remove old LinkedIn folder if exists
if (Test-Path "FlowHUB_Linkedin\LinkedIn") {
    Remove-Item -Path "FlowHUB_Linkedin\LinkedIn" -Recurse -Force
}

# Step 4: Copy LinkedIn folder (use absolute path)
$linkedInSource = Join-Path $projectDir "LinkedIn"
Copy-Item -Path $linkedInSource -Destination "FlowHUB_Linkedin\LinkedIn" -Recurse -Force

# Step 5: Remove .git folder if exists inside LinkedIn
if (Test-Path "FlowHUB_Linkedin\LinkedIn\.git") {
    Remove-Item -Path "FlowHUB_Linkedin\LinkedIn\.git" -Recurse -Force
}

# Step 6: Go to repo directory
Set-Location "FlowHUB_Linkedin"

# Step 7: Pull latest changes first
git pull origin main

# Step 8: Add, commit, and push
git add LinkedIn/
git commit -m "Update LinkedIn folder: infrastructure, flows, and SDLC documents"
git push origin main

Write-Host "✅ LinkedIn folder pushed successfully!"

