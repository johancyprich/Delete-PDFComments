# Delete-PDFComments
#
# See Settings.xml for application, user, and license information.
#
# SUMMARY:
# Deletes comments from a PDF with GhostScript.
#
# USAGE:
# ./Delete-PDFComments input output
# where input - filename and path to PDF to modify
#		output - filename and path to save modified PDF
#
# REQUIREMENTS:
# PowerShell 5.x or higher

param
(
	[string] $cmd,					# input file (filename and path)
	[string] $output				# output file (filename and path)
)


#=[ APPINFO ]======================================================================================

# Example for accessing data: $xml.Settings.Application.Name

$xml = [xml](get-content $PSScriptRoot\Settings.xml)    # Settings.xml located in the script folder.


#=[ LIBRARIES ]=====================================================================================

[string] $lib = "$PSScriptRoot\lib\"

."$lib\AppInfo.ps1"


#=[ GLOBALS ]=======================================================================================

#[string] $global:st = "A string."


#=[ FUNCTIONS ]=====================================================================================


function DeleteComments
{
	Write-Host  "Deleting comments from PDF ..."

	[string] $cmd = "gswin64c -sDEVICE=pdfwrite -sOutputFile='$output' -dShowAnnots=false -dNOPAUSE -dBATCH '$cmd'"

	Invoke-Expression $cmd
}


####################################################################################################
# PURPOSE:
# Display help screen.
####################################################################################################

function HelpScreen
{
	Write-Host "Usage:" $xml.Settings.Application.Name
	Write-Host 
}

#=[ MAIN ]==========================================================================================

# Display application info and help.

$app = New-Object -TypeName AppInfo ($cmd, $xml)
if ($app.ExitScript) { exit }

# Main

DeleteComments

# Quit the program.

$app.QuitProgram($true, $true)