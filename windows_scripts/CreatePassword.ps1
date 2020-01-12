# Password Management Tool

# Load Library from .Net Framework
Add-Type -Assembly System.Web

# Create and Encrypt Password
$Plain_Password_String=[System.Web.Security.Membership]::GeneratePassword(20,7)
$Secure_Password_String = ConvertTo-SecureString $Plain_Password_String -AsPlainText -Force
$Encrypted_Password_String = ConvertFrom-SecureString -SecureString $Secure_Password_String

Set-Content $env:USERPROFILE\Documents\Password\Password.txt -Value $Encrypted_Password_String