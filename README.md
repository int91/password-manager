# Account Manager (Godot)
This program is a simple Account Manager I made in the Godot engine using their built-in UI-Library and GDScript. I made this program over the course of 5 days as a challenge to make something within less than a week that I could use for my whole life.

The account manager takes in a few variables from the user:
* The application the account is for.
* The email for the account.
* The username for the account.
* The password for the account.

The program saves the accounts to folders with the same application name.
If you create an account for "Minecraft" it will look for the folder named "Minecraft" and if it doesn't exist it will create it then save the account information to that folder. Account information is named as (accountName + ".acc"). With ".acc" being the custom file extension to identify it as an account file.
