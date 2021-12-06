<powershell>
#Function to store log data
function Write-Log {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$Message
    )
    [pscustomobject]@{
        Time = (Get-Date -f g)
        Message = $Message
    } | Export-Csv -Path "c:\UserDataLog\UserDataLogFile.log" -Append -NoTypeInformation
 }
#Read input variables
$ServerName = "${ServerName}"
$SecureVariable = "${SecureVariable}"
#----------------------------------
#Create log file location
if (-not(Test-Path "C:\UserDataLog"))
{
    New-Item -ItemType directory -Path "C:\UserDataLog"
    Write-Log -Message "Created folder to store log file."
} else {
    Write-Log -Message "Folder already exists."
}
#----------------------------------
#Userdata location
Write-Log -Message "-------------------------"
Write-Log -Message "Userdata script is stored at : $PSScriptRoot"
Write-Log -Message "Execution Beginning now..."
#----------------------------------
#Check Computer ServerName
if ($env:COMPUTERNAME -eq $ServerName)
{
    Write-Log -Message "The name of the machine is correct: $env:COMPUTERNAME"
} else {
    Write-Log -Message "The name of the machine is incorrect and needs to change from $env:COMPUTERNAME to $ServerName."
    Rename-Computer -NewName $ServerName -Restart -Force
    Write-Log -Message "The machine will be renamed and restarted."
}
#----------------------------------
#Read from ssm-parameter store
#This way a secure variable can be passed into a user data script such that its value does not persist in the file
$ASecureVariable = (get-ssmparameter -Name "$SecureVariable" -WithDecryption $true).value
#The below step is only to demonstrate that the above step actually worked. Secure values should not be printed.
Write-Log -Message "The value of the secure variable that was read from ssm-parameter store is: $ASecureVariable"
#----------------------------------
# Install AWS CLI
Try
{
    $InstalledAwsVersion = $(aws --version) | Out-String -ErrorAction SilentlyContinue
}
Catch{}

#$InstalledawsVersion
if (($InstalledAwsVersion -match "aws-cli/") -and (Test-Path "C:\UserDataLog\InstallAWSFlag.txt" -PathType Leaf))
{
    Write-Log -Message "aws cli is installed. Version: $InstalledAwsVersion"
} else {
    Write-Log -Message "aws cli is not installed and will be installed."
    if (-not(Test-Path "C:\UserDataLog\awscliv2.msi" -PathType Leaf))
    {
        $WebClient = New-Object System.Net.WebClient
        $WebClient.DownloadFile("https://awscli.amazonaws.com/AWSCLIV2.msi","C:\UserDataLog\awscliv2.msi")
        Write-Log -Message "Downloaded the cli installer."
    }
    Start-Process msiexec.exe -Wait -ArgumentList '/i C:\UserDataLog\awscliv2.msi /qn /l*v C:\UserDataLog\aws-cli-install.log'
    Write-Log -Message "aws cli installed."
    if(Test-Path "C:\UserDataLog\InstallAWSFlag.txt" -PathType Leaf)
    {
        Remove-Item -Path "C:\UserDataLog\InstallAWSFlag.txt" -Force
    }
    Set-Content C:\UserDataLog\InstallAWSFlag.txt "true"
    Write-Log -Message "Restarting the machine."
    Restart-Computer -Force
}
</powershell>
<persist>true</persist>