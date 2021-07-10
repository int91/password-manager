# password-manager
The Password Manager for all made in Godot (Most Secure)

This is a basic account manager I made in the Godot game engine with gdscript just to see if I could do it.
It was made over the course of around 4 days. I did update it but keeping up with source without github is just impossible for me. So this was the project where I learned to upload all my sources to github.

The account manager takes in a few variables from the user.
A username for the account.
An email for the account.
The application the account is for.
And the password for the account.
NOT IN THIS ORDER.

It essentailly saves the accounts to folders with the same application name.
So if you create an account for "Minecraft" it will look for the folder named "Minecraft" and if it doesn't exist it will create it then save the account information to that folder. Account information is named as accountName + ".acc". With ".acc" being the custom file extension (it's just a simple text file that doesn't use encryption or anything).

The user can access their accounts through clicking on the app they want to retrieve their account for eg. "Minecraft" then the account name "MyAwesomeAccountName" and it will load the data.
