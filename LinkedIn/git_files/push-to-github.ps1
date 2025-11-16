# Push LinkedIn folder to GitHub repo
# Usage: Run from FlowHUB_Project, LinkedIn, or git_files directory
# IMPORTANT: Do NOT run from FlowHUB_Linkedin (the GitHub repo) - run from FlowHUB_Project!

# Get the script's directory (git_files folder)
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
# Get LinkedIn directory (parent of git_files)
$linkedInDir = Split-Path -Parent $scriptDir
# Get FlowHUB_Project directory (parent of LinkedIn)
$projectDir = Split-Path -Parent $linkedInDir
# Get planning directory (parent of FlowHUB_Project)
$planningDir = Split-Path -Parent $projectDir

# Check if we're in the wrong directory (FlowHUB_Linkedin)
$currentDir = Get-Location
if ($currentDir.Path -like "*FlowHUB_Linkedin*" -and $currentDir.Path -notlike "*FlowHUB_Project*") {
    Write-Host "ERROR: You're in the wrong directory!" -ForegroundColor Red
    Write-Host "You're in: $($currentDir.Path)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Please go to FlowHUB_Project directory and run:" -ForegroundColor Cyan
    Write-Host "  cd D:\planning\FlowHUB_Project" -ForegroundColor White
    Write-Host "  .\LinkedIn\git_files\push-to-github.ps1" -ForegroundColor White
    Write-Host ""
    exit 1
}

Write-Host "Preparing to push LinkedIn folder..." -ForegroundColor Cyan

# Step 1: Go to planning directory
Set-Location $planningDir

# Step 2: Clone the repo (if not already cloned)
if (-not (Test-Path "FlowHUB_Linkedin")) {
    Write-Host "Cloning repository..." -ForegroundColor Yellow
    git clone https://github.com/Dhana009/FlowHUB_Linkedin.git
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Failed to clone repository!" -ForegroundColor Red
        exit 1
    }
}

# Step 3: Remove old LinkedIn folder if exists
if (Test-Path "FlowHUB_Linkedin\LinkedIn") {
    Write-Host "Removing old LinkedIn folder..." -ForegroundColor Yellow
    Remove-Item -Path "FlowHUB_Linkedin\LinkedIn" -Recurse -Force
}

# Step 4: Copy LinkedIn folder (use absolute path)
Write-Host "Copying LinkedIn folder..." -ForegroundColor Yellow
Copy-Item -Path $linkedInDir -Destination "FlowHUB_Linkedin\LinkedIn" -Recurse -Force

# Step 5: Remove .git folder if exists inside LinkedIn
if (Test-Path "FlowHUB_Linkedin\LinkedIn\.git") {
    Write-Host "Removing .git folder from LinkedIn..." -ForegroundColor Yellow
    Remove-Item -Path "FlowHUB_Linkedin\LinkedIn\.git" -Recurse -Force
}

# Step 6: Go to repo directory
Set-Location "FlowHUB_Linkedin"

# Step 7: Pull latest changes first
Write-Host "Pulling latest changes..." -ForegroundColor Yellow
git pull origin main 2>&1 | Out-Null
# Ignore pull errors (might be up to date)

# Step 8: Check if there are changes
Write-Host "Checking for changes..." -ForegroundColor Yellow
git add LinkedIn/ 2>&1 | Out-Null
$status = git status --porcelain
if ($status) {
    Write-Host "Committing changes..." -ForegroundColor Yellow
    git commit -m "Update LinkedIn folder: infrastructure, flows, and SDLC documents"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Failed to commit!" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
    git push origin main
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Failed to push! Check your git credentials." -ForegroundColor Red
        exit 1
    }
    Write-Host "SUCCESS: LinkedIn folder pushed successfully!" -ForegroundColor Green
} else {
    Write-Host "INFO: No changes to commit. Everything is up to date." -ForegroundColor Cyan
}
