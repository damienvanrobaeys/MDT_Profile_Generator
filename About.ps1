<!--
#========================================================================
#
# Tool Name	: MDT Profile Generator
# Version:	: 1.1	
# Author 	: Damien VAN ROBAEYS
# Date 		: 01/06/2016
# Website	: http://www.systanddeploy.com/
# Twitter	: https://twitter.com/syst_and_deploy
#
#========================================================================
-->

[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')  | out-null
[System.Reflection.Assembly]::LoadWithPartialName('System.ComponentModel') | out-null
[System.Reflection.Assembly]::LoadWithPartialName('System.Data')           | out-null
[System.Reflection.Assembly]::LoadWithPartialName('System.Drawing')        | out-null
[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') | out-null
[System.Reflection.Assembly]::LoadWithPartialName('PresentationCore')      | out-null
[System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.dll')       | out-null
[System.Reflection.Assembly]::LoadFrom('assembly\System.Windows.Interactivity.dll') | out-null

Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"

function LoadXml ($global:filename)
{
    $XamlLoader=(New-Object System.Xml.XmlDocument)
    $XamlLoader.Load($filename)
    return $XamlLoader
}

# Load MainWindow
$XamlMainWindow=LoadXml("About.xaml")
$Reader=(New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form=[Windows.Markup.XamlReader]::Load($Reader)

$Website = $Form.findname("Website") 
$Facebook = $Form.findname("Facebook") 
$Twitter = $Form.findname("Twitter") 
$Mail = $Form.findname("Mail") 

$Author_Mail = "damien.vanrobaeys@gmail.com"
$Author_Website = "http://www.systanddeploy.com"
$Author_Facebook = "https://www.facebook.com/systanddeploy"
$Author_Twitter = "https://twitter.com/syst_and_deploy"


$Website.Add_Click({	
	[System.Diagnostics.Process]::Start("$Author_Website")
})	

$Facebook.Add_Click({	
	[System.Diagnostics.Process]::Start("$Author_Facebook")
})	

$Twitter.Add_Click({	
	[System.Diagnostics.Process]::Start("$Author_Twitter")
})	

$Mail.Add_Click({	
	[System.Diagnostics.Process]::Start("mailto:$Author_Mail")
})	



$Form.ShowDialog() | Out-Null
