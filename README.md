Once AD has been configured on winserver..

- bulkUsersAdd needs the email domain and the dc name added to script
- addUsersToGroups needs paths added
- users.csv needs the DC name changed in the OU

1. Create the different users that will be created in AD.
  - Stored in addUSers.csv
    - Change fields if desired
2. Run bulkUsersAdd.ps1 to auto generate the users in AD
3. Open groupsImport and edit the group names if desired
  - To change the group name edit the name of the .txt file
  - If you do change the names of the groups you will need to make the changes in Groups.txt to reflect the new group names
4. Run AddUserstoGroups.ps1 to add all the recently created users to their groups
5. All set!

  - If you ever want to remove all the users that have been created run the removeADUsers.ps1 script
