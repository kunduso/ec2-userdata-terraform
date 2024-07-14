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
    } | Export-Csv -Path "$LogFolderPath\UserDataLogFile.log" -Append -NoTypeInformation
}

#Function to install AWS CloudWatch Agent
function Install-AWS-CloudWatchAgent {
    $CWAgentDownloadURL = "https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi"
    Write-Log -Message "Getting ready to download Amazon CloudWatch agent."

    $CloudWatchInstallerPath = $InstallerFolderPath + "\\amazon-cloudwatch-agent.msi"

    #Check if the installer is there else download it
    if ((Test-Path $CloudWatchInstallerPath) -eq $true) {
        Write-Log -Message "The Amazon CloudWatch installer exists."
    } else {
            if (-not(Test-Path $InstallerFolderPath))
                {
                    New-Item -ItemType directory -Path $InstallerFolderPath
                    Write-Log -Message "Created folder to store the Amazon CloudWatch Agent installer."
                } else {
                    Write-Log -Message "Folder to store the Amazon CloudWatch Agent installer already exists."
                }
            Invoke-WebRequest $CWAgentDownloadURL -OutFile $CloudWatchInstallerPath
            Write-Log -Message "Downloaded the Amazon CloudWatch Agent installers."
    }
    #Install Amazon CloudWatch Agent
    $arguments = "/i `"$CloudWatchInstallerPath`" /quiet"
    Start-Process msiexec.exe -ArgumentList $arguments -Wait
    Write-Log -Message "Amazon CloudWatch installation completed."

    #Delete installer
}

#Function to install aws-cli
function Install-AWS-CLI {
    Try
    {
        Write-Log -Message "Getting ready to download AWS CLI installer."

        $AWSCLIInstallerPath = $InstallerFolderPath + "\awscliv2.msi"

        if (-not(Test-Path $InstallerFolderPath))
        {
            New-Item -ItemType directory -Path $InstallerFolderPath
            Write-Log -Message "Created folder to store the AWS CLI installer."
        } else {         
            Write-Log -Message "Folder to store the AWS CLI installer already exists."
        }
        if (-not(Test-Path "$AWSCLIInstallerPath" -PathType Leaf))
        {
            $WebClient = New-Object System.Net.WebClient
            $WebClient.DownloadFile("https://awscli.amazonaws.com/AWSCLIV2.msi","$AWSCLIInstallerPath")
            Write-Log -Message "Downloaded the AWS CLI installer."
        }
        $arguments = "/i `"$AWSCLIInstallerPath`" /quiet /l*v $InstallerFolderPath\aws-cli-install.log"
        Start-Process msiexec.exe -ArgumentList $arguments -Wait
        #Start-Process msiexec.exe -Wait -ArgumentList '/i $InstallerFolderPath\awscliv2.msi /qn /l*v $InstallerFolderPath\aws-cli-install.log'
        Write-Log -Message "Successfully installed aws cli."

        Write-Log -Message "Restarting the machine."
        Restart-Computer -Force
    }
    Catch{}
}

#Function to configure Amazon CloudWatch agent
function Configure-Amazon-CloudWatch-Agent {
    $CWAgentPath = "C:\Program Files\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-ctl.ps1"
    try {
        if ((Test-Path $CWAgentPath))
        {
        Write-Log -Message "The $CWAgentPath file exists."
        } else {
        Write-Log -Message "Configure file does not exist. Cannot configure Amazon CloudWatch agent."
        }
        &"$CWAgentPath" -a fetch-config -m ec2 -c file:$LogFolderPath\config.json -s
    }
    catch {
    Write-Log -Message "An error occurred:"
    Write-Log -Message $_
    Write-Log -Message "Could not configure Amazon CloudWatch Agent."
    break
    }
}

##############################################

# Execution begins from here

##############################################
$LogFolderPath = "C:\UserDataLog"
$InstallerFolderPath = $LogFolderPath+"\Installer"
$UserName = "User03"

#Create log file location
if (-not(Test-Path $LogFolderPath))
{
New-Item -ItemType directory -Path $LogFolderPath
Write-Log -Message "Created folder to store log file."
} else {
Write-Log -Message "Folder already exists."
}
#Userdata location
Write-Log -Message "Userdata script is stored at : $PSScriptRoot"

#Create a new user if does not exist.
$CheckIfUserExists = (Get-LocalUser).Name -Contains $UserName
if ($CheckIfUserExists -eq $false) {
Write-Host "$UserName does not exist and will be created."
try {
    Write-Log -Message "Adding the user: $UserName"
    $Secure_String_Password = ConvertTo-SecureString "${Password}" -AsPlainText -Force

        $params = @{
            Name        = $UserName
            Password    = $Secure_String_Password
            FullName    = 'Third User'
            Description = 'Description of this account.'
        }
        New-LocalUser @params
}
catch {
        Write-Log -Message "An error occurred:"
        Write-Log -Message $_
        Write-Log -Message "Could not create a local user."
        break
    }
} ElseIf ($CheckIfUserExists -eq $true) {
    Write-Log -Message "$UserName Exists."

}

#Add user to Administrators group
Write-Log -Message "Checking if $UserName belongs to the Administrators group already."
$CheckIfUserBelongsToAdministrator = (Get-LocalGroupMember -Group "Administrators").Name -Contains $UserName
if ($CheckIfUserBelongsToAdministrator -eq $false) {
    Write-Log -Message "$UserName does not belong to Administrators group and will be added."
    try {
    Add-LocalGroupMember -Group "Administrators" -Member "$UserName"
    }
    catch {
    $"An error occurred:"
    Write-Log -Message $_
    Write-Log -Message "Could not add user to Administrators group."
    break
    }
} ElseIf ($CheckIfUserBelongsToAdministrator -eq $true) {
    Write-Log -Message "$UserName is in Administrators group already."
}
Write-Log -Message "$UserName added to Administrators."

# check if CW Agent is installed
$CheckSoftware = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -match "Amazon CloudWatch Agent"}
if([string]::IsNullOrEmpty($CheckSoftware.Name)){
    Write-Log -Message "Amazon CloudWatch is not installed."
    Install-AWS-CloudWatchAgent
}
else {
    Write-Log -Message "Amazon CloudWatch is already installed."
}

$CheckSoftware = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -match "AWS Command Line Interface"}
if([string]::IsNullOrEmpty($CheckSoftware.Name)){
    Write-Log -Message "AWS Command Line Interface is not installed."
    Install-AWS-CLI
}
else {
    try {
        $InstalledAwsVersion = $(aws --version) | Out-String -ErrorAction SilentlyContinue
    }
    catch {
        $"An error occurred:"
        Write-Log -Message $*
        Write-Log -Message "Could not check aws cli version."
        break
    }
    Write-Log -Message "AWS Command Line Interface is already installed. Version: $InstalledAwsVersion"
}
Write-Log -Message "The SSM Paramete name is: ${Parameter_Name}"
#Read CW
<#
$FileContent =  $(aws ssm get-parameter --name "${Parameter_Name}" --query "Parameter.Value" --output text)
Write-Host "The content are:"
Set-Content C:\UserDataLog\config.json "$FileContent"
Configure-Amazon-CloudWatch-Agent

#Check Status of Amazon CloudWatch Agent service
$CloudWatchAgentStatus = (Get-Service -Name "Amazon CloudWatch Agent")
try {
    if ($CloudWatchAgentStatus.Status -eq "Running")
    {
        Write-Log -Message "The Amazon CloudWatch Agent service started successfully."
    }
}
catch {
    Write-Log -Message "An error occurred:"
    Write-Log -Message $_
    Write-Log -Message "The Amazon CloudWatch Agent is not running."
    break
}
#>
</powershell>
<persist>true</persist>