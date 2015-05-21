﻿
[string]$username = 'leixu'
[string]$password = 'P2ssw0rd'
[string]$svcName = 'dscdemo-lx'
[string]$vmName = "dsc-$($username)"

$workingdir = split-path $myinvocation.mycommand.path

Import-AzurePublishSettingsFile -PublishSettingsFile "$($workingdir)\Microsoft Azure Enterprise 试用版-5-21-2015-credentials.publishsettings"
Select-AzureSubscription -SubscriptionName 'Microsoft Azure Enterprise 试用版'

$secPassword = ConvertTo-SecureString $password -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential($username, $secPassword)

# Generate unique identifier to use in names
    AllNodes = @(     
                    @{  
                        NodeName = 'localhost' 
                        #CertificateFile = Join-Path $workingdir 'publicKey.cer'
                        #Thumbprint = ''
                        PSDscAllowPlainTextPassword=$true
                        AffinityGroup = "TestVMWestUS$Instance"
                        AffinityGroupLocation = 'China North'
                        AffinityGroupDescription = 'Affinity Group for Test Virtual Machines'
                        StorageAccountName = "testvmstorage$Instance"
                        ScriptExtensionsFiles = 'scriptextensionfiles'
                        ServiceName = "testvmservice$Instance"
                        ServiceDescription = 'Service created for Test Virtual Machines'
                    }
                )
} 

#Get-AzureRemoteDesktopFile -ServiceName $SvcName -Name $vmName -LocalPath "$($workingdir)\$($vmName)-connection.rdp"