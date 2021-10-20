Import-Module ActiveDirectory

#Prompt user for csv file path
$filepath = Read-Host -Prompt "Enter path for .csv file"

#Import file into variable
$users = Import-Csv $filepath

#Loop through each row and gather user information by column
ForEach ($record in $users) {
    #Gather User Specific Information
    $fName = $record.firstname
    $fInitial = $fName.SubString(0,1)
    $lName = $record.lastname
    $uName = $($fInitial + $lName)
    $emailAddr = $uName + "[insert email]"
    $strAddr = $record.streetaddress
    $city = $record.city
    $zipCode = $record.zipcode
    $state = $record.state
    $country = $record.county
    $department = $record.department
    $password = $record.password
    $telephone = $record.telephone
    $jTitle = $record.jobtitle
    $company = $record.company
    $ou = $record.ou

    #Check to see if the user already exists
    if (Get-ADUser -F {SamAccountName -eq $uName})
    {
        Write-Warning "A user account with the username $uName already exists in AD"
    }
    else
    {       
    #Create new AD users with the gathered information from the .csv file
    
    New-ADUser `
        -Name "$fName $lName" `
        -SamAccountName $uName `
        -Title $jTitle `
        -Department $department `
        -EmailAddress $emailAddr `
        -GivenName $fName `
        -Surname $lName `
        -UserPrincipalName $uName@[dc name].local `
        -Path $ou `
        -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) `
        -ChangePasswordAtLogon $False `
        -Enabled $True 


    echo "Account created for $fName $lName in $ou"
    }
}

