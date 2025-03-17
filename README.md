LAPS Password Retriever

This PowerShell script provides a graphical user interface (GUI) to retrieve the LAPS password for a specified server. The server must be LAPS-enabled and part of the domain.

Prerequisites
Ensure that the server you want to retrieve the LAPS password for is LAPS-enabled and part of the domain.
You need to have the necessary permissions to retrieve LAPS passwords.
How to Use
Download the Script:

Save the LAPS.ps1 script to a location on your computer.
Run the Script:

Open PowerShell with administrative privileges.
Navigate to the directory where the script is saved.
Execute the script by typing .\LAPS.ps1 and pressing Enter.

Using the GUI:

A window titled "LAPS Retriever" will appear.
Enter the name of the server for which you want to retrieve the LAPS password in the "Server" input field.
Click the "Get Password" button.

Retrieve the Password:
The script will check the server's operating system.
If the server is running an OS other than Windows Server 2016, it will use the Get-LapsADPassword cmdlet to retrieve the password.
If the server is running Windows Server 2016, it will use the Get-AdmPwdPassword cmdlet.
The retrieved LAPS password will be displayed in the "LAPS Password" field.

Error Handling
If the server is not found, a message box will appear indicating a possible typo.
If LAPS is not enabled on the server or the password is not available, a message box will inform you.

Example
Open PowerShell as an administrator.
Navigate to the script location:
cd C:\path\to\script

Run the script:
.\LAPS.ps1

In the GUI, enter the server name and click "Get Password".
