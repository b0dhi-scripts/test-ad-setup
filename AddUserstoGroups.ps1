### Bulk add users to a group ###

### Path to list of groups
$GroupList = Get-Content "C:\Users\Administrator\Desktop\powershell\addADUsersToGroups\Groups.txt"			#CHANGE THIS ADDRESS

### Iterate through list of groups
ForEach ($GroupName in $GroupList)
{

	### For each group in the list, use this list of users
	$UserList = Get-Content "C:\Users\Administrator\Desktop\powershell\addADUsersToGroups\$($GroupName).txt"	#CHANGE THIS ADDRESS
	$Members = Get-ADGroupMember -Identity $GroupName -Recursive | Select -ExpandProperty SAMAccountName
 
	### For each user, check if it's already in that group. If not, then add them.
	ForEach ($User in $UserList)
	{
		If ($Members -contains $user)
		{
			Write-Host "$User is member of $GroupName"
		}
		Else
		{
			Write-Host "$User is not a member. Attempting to add now, run script again for verification"
			Add-ADGroupMember -Identity $GroupName -Members $User
		}
	}
}