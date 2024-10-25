# Execute Below given command in your terminal before running the script else script will won't work
# Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
# Function to prompt the user for confirmation
function Confirm-Action {
    param (
        [string]$appName
    )
    $confirmation = Read-Host "Do you want to remove $appName (y/n)"
    return $confirmation -eq 'y'
}

# Function to remove a given app
function Remove-App {
    param (
        [string]$AppName
    )
    
    $app = Get-AppxPackage -Name $AppName -ErrorAction SilentlyContinue
    
    if ($null -eq $app) {
        Write-Output "$AppName is not installed or already removed!"
        return
    }
    
   if (Confirm-Action -AppName $AppName) {
        Remove-AppxPackage -Package $app.PackageFullName
        Write-Output "$AppName removed."
    } else {
        Write-Output "Skipped removing $AppName."
    }
}

# List of apps to remove
$appsToRemove = @(
    "Microsoft.Windows.DevHome",  
    "Microsoft.3DBuilder",
    "Microsoft.BingWeather",
    "Microsoft.GetHelp",
    "Microsoft.Getstarted",
    "Microsoft.Microsoft3DViewer",
    "Microsoft.MicrosoftOfficeHub",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.MixedReality.Portal",
    "Microsoft.MSPaint",
    "Microsoft.Office.OneNote",
    "Microsoft.People",
    "Microsoft.Print3D",
    "Microsoft.SkypeApp",
    "Microsoft.WindowsAlarms",
    "Microsoft.WindowsCamera",
    "Microsoft.WindowsFeedbackHub",
    "Microsoft.WindowsMaps",
    "Microsoft.WindowsSoundRecorder",
    "Microsoft.XboxApp",
    "Microsoft.XboxGameOverlay",
    "Microsoft.XboxGamingOverlay",
    "Microsoft.XboxIdentityProvider",
    "Microsoft.XboxSpeechToTextOverlay",
    "Microsoft.YourPhone"
)

# Loop through app list and prompt for removal
foreach ($app in $appsToRemove) {
    Remove-App -AppName $app
}

# Check for a custom package removal
$Message = "Do you want to remove your custom package?"
$confirmation = Read-Host "$Message (y/n)"

if ($confirmation -eq 'y') {
    $AppName = Read-Host "Enter the name of your custom package"
    Remove-App -AppName $AppName
} else {
    $Message = "Do you want to see installed packages?"
    $confirmation = Read-Host "$Message (y/n)"
    
    if ($confirmation -eq 'y') {
        Get-AppxPackage | Select-Object Name | Format-Table
    }
}

Write-Output "Windows Debloat completed."
