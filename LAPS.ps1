# Initiate PowerShell Gui
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationCore,PresentationFramework

# required for realtime updating GUI items
[System.Windows.Forms.Application]::DoEvents()

# create new form
$LAPSForm                    = New-Object system.Windows.Forms.Form
$LapsForm.ClientSize         = '500,300'
$LAPSForm.text               = "LAPS Retriever'"
$LapsForm.BackColor          = "#ffffff"


# Set title and properties
$Titel                           = New-Object system.Windows.Forms.Label
$Titel.text                      = "Retrieve LAPS Password"
$Titel.AutoSize                  = $true
$Titel.width                     = 25
$Titel.height                    = 10
$Titel.location                  = New-Object System.Drawing.Point(20,20)
$Titel.Font                      = 'Microsoft Sans Serif,13'

# element properties

# description
$Description                     = New-Object system.Windows.Forms.Label
$Description.text                = "Vraag het LAPS password op voor een server. Server dient LAPS enabled te zijn en in het Domain te staan"
$Description.AutoSize            = $false
$Description.width               = 450
$Description.height              = 50
$Description.location            = New-Object System.Drawing.Point(20,50)
$Description.Font                = 'Microsoft Sans Serif,10'

#label server
$ServerLabel                   = New-Object system.Windows.Forms.Label
$ServerLabel.text              = "Server:"
$ServerLabel.AutoSize          = $true
$ServerLabel.location          = New-Object System.Drawing.Point(20,115)
$ServerLabel.Font              = 'Microsoft Sans Serif,10,style=Bold'

#input field server
$ServerInput                    = New-Object System.Windows.Forms.TextBox
$ServerInput.text               = ""
$ServerInput.AutoSize           = $true
$ServerInput.location           = New-Object System.Drawing.Point(175,115)
$ServerInput.Font               = 'Microsoft Sans Serif,10'

#Laps label
$LAPSLabel                   = New-Object system.Windows.Forms.Label
$LAPSLabel.text              = "LAPS Password:"
$LAPSLabel.AutoSize          = $true
$LAPSLabel.location          = New-Object System.Drawing.Point(20,165)
$LAPSLabel.Font              = 'Microsoft Sans Serif,10,style=Bold'

#laps Output field
$LAPSOutput                    = New-Object System.Windows.Forms.TextBox
$LAPSOutput.text               = ""
$LAPSOutput.AutoSize           = $true
$LAPSOutput.Width = 250
$LAPSOutput.location           = New-Object System.Drawing.Point(175,165)
$LAPSOutput.Font               = 'Microsoft Sans Serif,10'

#passowrd retrieve button
$Lapsbtn                   = New-Object system.Windows.Forms.Button
$Lapsbtn.BackColor         = "#a4ba67"
$Lapsbtn.text              = "Get Password"
$Lapsbtn.width             = 150
$Lapsbtn.height            = 30
$Lapsbtn.location          = New-Object System.Drawing.Point(320,250)
$Lapsbtn.Font              = 'Microsoft Sans Serif,10'
$Lapsbtn.ForeColor         = "#ffffff"


# add all to form
$LAPSForm.controls.AddRange(@($Titel,$Description,$ServerLabel,$ServerInput,$Lapsbtn, $LAPSLabel, $LAPSOutput))


#functions
#functie for retrieving LAPS password
function get-lapspassword()
{
    #retrieve servername
    $servername = $ServerInput.Text

    #check OS
    try{
        
        $srvprops = get-adcomputer $servername -Properties *

        #if OS NOT 2016 is, do magic
        if($srvprops.OperatingSystem -notlike "Windows Server 2016*")
        {
            #retrieve LAPS password and place in variable
            $lapspassword = get-lapsadpassword -Identity $servername -AsPlainText

            if($lapspassword -eq "")
            {
                [System.Windows.MessageBox]::Show('LAPS not enabled yet or N/A','information')
            }

            #show LAPS password in outputfield
            $LAPSoutput.Text = $lapspassword.password
        } 
    
        #if OS IS 2016 is, use legacy cmdlets
        if($srvprops.OperatingSystem -like "Windows Server 2016*")
        {
            $lapspassword = Get-AdmPwdPassword -computername $servername 

            if($lapspassword -eq "")
            {
                [System.Windows.MessageBox]::Show('LAPS not enabled yet or N/A','information')
            }

            #show LAPS password in outputfield
            $LAPSoutput.Text = $lapspassword.password
            
        }
    } catch {
            [System.Windows.MessageBox]::Show('Server not found. Typo?','information')
    }
}


# add eventhandler to button
$Lapsbtn.Add_Click({ Get-lapspassword })


# show the form
[void]$LAPSForm.ShowDialog()