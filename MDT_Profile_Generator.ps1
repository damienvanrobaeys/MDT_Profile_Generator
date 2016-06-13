#========================================================================
#
# Tool Name	: MDT Profile Generator
# Author 	: Damien VAN ROBAEYS
# Date 		: 01/06/2016
# Website	: http://www.systanddeploy.com/
# Twitter	: https://twitter.com/syst_and_deploy
#
#========================================================================
Param
    (
		[Parameter(Mandatory=$true)]
		[AllowEmptyString()]						
		[String]$deploymentshare # Import the deployment share from the first GUI		        
    )

[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')  				| out-null
[System.Reflection.Assembly]::LoadWithPartialName('System.ComponentModel') 				| out-null
[System.Reflection.Assembly]::LoadWithPartialName('System.Data')           				| out-null
[System.Reflection.Assembly]::LoadWithPartialName('System.Drawing')        				| out-null
[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') 				| out-null
[System.Reflection.Assembly]::LoadWithPartialName('PresentationCore')      				| out-null
[System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.dll')       				| out-null
[System.Reflection.Assembly]::LoadFrom('assembly\System.Windows.Interactivity.dll') 	| out-null

Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"

function LoadXml ($global:filename)
{
    $XamlLoader=(New-Object System.Xml.XmlDocument)
    $XamlLoader.Load($filename)
    return $XamlLoader
}

# Load MainWindow
$XamlMainWindow=LoadXml("MDT_Profile_Generator.xaml")
$Reader=(New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form=[Windows.Markup.XamlReader]::Load($Reader)

[System.Windows.Forms.Application]::EnableVisualStyles()

########################################################################################################################################################################################################	
#*******************************************************************************************************************************************************************************************************
# 																		BUTTONS AND LABELS INITIALIZATION 
#*******************************************************************************************************************************************************************************************************
########################################################################################################################################################################################################

#************************************************************************** DETAILS TAB ***********************************************************************************************
$Profile_Name = $Form.findname("Profile_Name")
$Profile_Name_Info = $Form.findname("Profile_Name_Info")
$Profile_Path = $Form.findname("Profile_Path")
$Profile_Path_TextBox = $Form.findname("Profile_Path_TextBox")
$Profile_Path_Info = $Form.findname("Profile_Path_Info")
$Choose_TS = $Form.findname("Choose_TS") 
$Choose_TS_Info = $Form.findname("Choose_TS_Info") 
$Deployment_Type_Newcomputer = $Form.findname("Deployment_Type_Newcomputer") 
$Deployment_Type_Refresh = $Form.findname("Deployment_Type_Refresh") 
$Deployment_Type_NoSet = $Form.findname("Deployment_Type_NoSet") 
$Choose_deploy_type = $Form.findname("Choose_deploy_type") 
$Choose_OSLanguage = $Form.findname("Choose_OSLanguage") 
$OS_Language_Info = $Form.findname("OS_Language_Info") 
$Choose_second_OSLanguage = $Form.findname("Choose_second_OSLanguage") 
$Second_language_none = $Form.findname("Second_language_none") 
$Second_OS_Language_Info = $Form.findname("Second_OS_Language_Info") 
$Choose_Timezone = $Form.findname("Choose_Timezone")
$timezone = $Form.findname("timezone") 
$Choose_Keyboard_Layout = $Form.findname("Choose_Keyboard_Layout") 
#************************************************************************** DOMAIN TAB ***********************************************************************************************
$Org_name = $Form.findname("Org_name") 
$Computer_Name = $Form.findname("Computer_Name") 
$Computer_Name_SN = $Form.findname("Computer_Name_SN") 
$Local_Admin_PWD = $Form.findname("Local_Admin_PWD") 
$Mode_Workgroup = $Form.findname("Mode_Workgroup") 
$Mode_Domain = $Form.findname("Mode_Domain")
$Choose_mode = $Form.findname("Choose_mode") 
$Domaine_Wkg_Label = $Form.findname("Domaine_Wkg_Label") 
$Domaine_Wkg_txtbox = $Form.findname("Domaine_Wkg_txtbox") 
$OU_name = $Form.findname("OU_name") 
$UserName = $Form.findname("UserName") 
$Domain_Admin_Pwd = $Form.findname("Domain_Admin_Pwd") 
#************************************************************************** NETWORK TAB ***********************************************************************************************
$Choose_DHCP = $Form.findname("Choose_DHCP") 
$Choose_Static = $Form.findname("Choose_Static") 
$Choose_Network_Type = $Form.findname("Choose_Network_Type") 
$IPAddress = $Form.findname("IPAddress") 
$Gateway = $Form.findname("Gateway") 
$SubnetMask = $Form.findname("SubnetMask") 
$DNS_Server = $Form.findname("DNS_Server") 
$IE_home_page = $Form.findname("IE_home_page") 
#************************************************************************** BACKUP TAB ***********************************************************************************************
###### Capture Part ######
$computerbackup_location_label = $Form.findname("computerbackup_location_label") 
$Capture_computer = $Form.findname("Capture_computer") 
$Capture_yes = $Form.findname("Capture_yes") 
$Capture_no = $Form.findname("Capture_no") 
$capture_computer_no = $Form.findname("capture_computer_no") 
$capture_computer_yes = $Form.findname("capture_computer_yes") 
$sysprep_this_computer = $Form.findname("sysprep_this_computer") 
$prepare_to_capture = $Form.findname("prepare_to_capture") 
$Choose_capture = $Form.findname("Choose_capture") 
$Combo_Capture_Computer = $Form.findname("Combo_Capture_Computer") 
$Capture_Location = $Form.findname("Capture_Location") 
$Capture_Name = $Form.findname("Capture_Name") 
$Capture_User_Name = $Form.findname("Capture_User_Name") 
$Capture_User_Password = $Form.findname("Capture_User_Password") 
$Capture_User_Domain = $Form.findname("Capture_User_Domain") 
$Capture_backup_location_textbox = $Form.findname("Capture_backup_location_textbox") 
$Capture_backup_location_info = $Form.findname("Capture_backup_location_info") 
$Capture_file_name = $Form.findname("Capture_file_name") 
$Combo_Backup_Type = $Form.findname("Combo_Backup_Type") 
$VHD_File = $Form.findname("VHD_File") 
$WIM_file = $Form.findname("WIM_file") 
$Capture_location_user = $Form.findname("Capture_location_user") 
$Capture_location_password = $Form.findname("Capture_location_password") 
$Capture_location_domain = $Form.findname("Capture_location_domain") 
####### Backup computer Part ########
$Computer_Backup_type = $Form.findname("Computer_Backup_type") 
$Computer_Backup_Location = $Form.findname("Computer_Backup_Location") 
$Backup_Computer_No = $Form.findname("Backup_Computer_No") 
$Backup_Computer_Auto = $Form.findname("Backup_Computer_Auto") 
$Backup_Computer_Specify = $Form.findname("Backup_Computer_Specify") 
$Computer_Backup_Location_TextBox = $Form.findname("Computer_Backup_Location_TextBox") 
####### Save and restore User data and Settings Part ########
$user_data_backup_type = $Form.findname("user_data_backup_type") 
$Restore_Location = $Form.findname("Restore_Location") 
$Backup_Location = $Form.findname("Backup_Location") 
$Combo_restore_UserData = $Form.findname("Combo_restore_UserData") 
$restore_user_data_no = $Form.findname("restore_user_data_no") 
$UserData_Backup_location_textbox = $Form.findname("UserData_Backup_location_textbox") 
$Combox_Computer_Backup_Type = $Form.findname("Combox_Computer_Backup_Type")
$Combox_UserData_Backup_Type = $Form.findname("Combox_UserData_Backup_Type")
$move_userdata = $Form.findname("move_userdata") 
$restore_user_data = $Form.findname("restore_user_data") 
$restore_user_data_specify_location = $Form.findname("restore_user_data_specify_location") 
$move_data_yes = $Form.findname("move_data_yes") 
$move_data_no = $Form.findname("move_data_no") 
$move_data_apply = $Form.findname("move_data_apply") 
$UserData_restore_location_textbox = $Form.findname("UserData_restore_location_textbox") 
$UserDataLocation_Label = $Form.findname("UserDataLocation_Label") 
#************************************************************************** WIZARD TAB ***********************************************************************************************
$Skip_All = $Form.findname("Skip_All")
$Skip_TS = $Form.findname("Skip_TS")
$Skip_ProductKey = $Form.findname("Skip_ProductKey")
$Skip_move_user_data = $Form.findname("Skip_move_user_data")
$Skip_DomainMemberShip = $Form.findname("Skip_DomainMemberShip")
$Skip_restore_UserData = $Form.findname("Skip_restore_UserData")
$Skip_AdminPWD = $Form.findname("Skip_AdminPWD")
$Skip_Applications = $Form.findname("Skip_Applications")
$Skip_Capture = $Form.findname("Skip_Capture")
$Skip_Bitlocker = $Form.findname("Skip_Bitlocker")
$Skip_Summary = $Form.findname("Skip_Summary")
$Skip_Locale_time = $Form.findname("Skip_Locale_time")
$Skip_Language_packs = $Form.findname("Skip_Language_packs")
$Skip_Computer_name = $Form.findname("Skip_Language_packs")
#************************************************************************** APPLICATIONS TAB ***********************************************************************************************
$DataGrid_Applis = $Form.findname("DataGrid_Applis")
$Create_Profile = $Form.findname("Create_Profile")
$Clear_All_Button = $Form.findname("Clear_All_Button")
$about = $Form.findname("about")
$Tab_Control = $form.FindName("Tab_Control")
#************************************************************************** OTHER TAB ***********************************************************************************************
$Finish_Action = $form.FindName("Finish_Action")
$Finish_Action_DoNothing = $form.FindName("Finish_Action_DoNothing")
$Finish_Action_Reboot = $form.FindName("Finish_Action_Reboot")
$Finish_Action_Shutdown = $form.FindName("Finish_Action_Shutdown")
$Finish_Action_LogOff = $form.FindName("Finish_Action_LogOff")
$GPO_Pack_path = $form.FindName("GPO_Pack_path")
$GPO_Pack_DoNothing = $form.FindName("GPO_Pack_DoNothing")
$GPO_Pack_Info = $form.FindName("GPO_Pack_Info")
$Set_WSUS_Server = $form.FindName("Set_WSUS_Server")
$Event_Service = $form.FindName("Event_Service")
$Hide_Shell = $form.FindName("Hide_Shell")
$Not_extra_partition = $form.FindName("Not_extra_partition")
$Logs_SLShareDynamicLogging = $form.FindName("Logs_SLShareDynamicLogging")
$Logs_SLShare = $form.FindName("Logs_SLShare")
$SLShare_Deployroot = $form.FindName("SLShare_Deployroot")

########################################################################################################################################################################################################	
#*******************************************************************************************************************************************************************************************************
# 																		VARIABLES INITIALIZATION 
#*******************************************************************************************************************************************************************************************************
########################################################################################################################################################################################################

$object = New-Object -comObject Shell.Application  
$Profile_Name.Text = "Customsettings_MDT.ini" # Default profile name
$Global:Current_Folder =(get-location).path 

$Mode_Workgroup.IsSelected = $true 
$Domaine_Wkg_Label.Content = "Workgroup name:"
$UserName.IsEnabled = $false 
$Domain_Admin_Pwd.IsEnabled = $false 	
$OU_name.IsEnabled = $false 	
$IPAddress.IsEnabled = $false 
$Gateway.IsEnabled = $false 
$SubnetMask.IsEnabled = $false 		
$DNS_Server.IsEnabled = $false 	
$Profile_Path_TextBox.IsEnabled = $false
$Global:Row_List = $DataGrid_Applis.items
$UserName.IsEnabled = $false 	
#************************************************************************** Capture part ***************************************************************************************
$computerbackup_location_label.Content = "Capture"
$capture_computer_no.IsSelected = $true
$Capture_backup_location_textbox.IsEnabled = $false 	
$Capture_file_name.IsEnabled = $false 	
$Combo_Backup_Type.IsEnabled = $false 
$Backup_location_user.IsEnabled = $false 	
$Backup_location_password.IsEnabled = $false 	
$Backup_location_domain.IsEnabled = $false 
$Capture_location_user.IsEnabled = $false 
$Capture_location_password.IsEnabled = $false 
$Capture_location_domain.IsEnabled = $false 
#************************************************************************** Move and restore User data part ***************************************************************************************
$move_data_no.IsChecked = $true
$Combo_restore_UserData.IsEnabled = $true 	
$UserData_restore_location_textbox.IsEnabled = $true 				
$restore_user_data_no.IsSelected = $true
$Deployment_Type_NoSet.IsSelected = $true
$UserDataLocation_Label.Content = "Move and Restore User Data"	

# Part for Capture or Computer Backup
$Capture_computer.Visibility = "Visible"
$Capture_Location.Visibility = "Visible"
$Capture_Name.Visibility = "Visible"
$Capture_User_Name.Visibility = "Visible"
$Capture_User_Password.Visibility = "Visible"
$Capture_User_Domain.Visibility = "Visible"
$Computer_Backup_type.Visibility = "Collapsed"
$Computer_Backup_Location.Visibility = "Collapsed"	

# Part for Move and restore user data
$user_data_backup_type.Visibility = "Collapsed"
$Backup_Location.Visibility = "Collapsed"
$move_userdata.Visibility = "Visible"
$restore_user_data.Visibility = "Visible"
$Restore_Location.Visibility = "Visible"	

########################################################################################################################################################################################################	
#*******************************************************************************************************************************************************************************************************
# 																		FUNCTIONS INITIALIZATION 
#*******************************************************************************************************************************************************************************************************
########################################################################################################################################################################################################

#************************************************************************** Populate the Keyboard Layout ListBox ***************************************************************************************
Function Populate_KeyBoard 
	{		
		$LanguageUI = "MDT_LanguageUI.xml"						
		$Global:my_LanguageUI_xml = [xml] (Get-Content $LanguageUI)	
		foreach ($data in $my_LanguageUI_xml.selectNodes("LanguageUI/KeyboardLocale/option"))			
			{
				$Choose_Keyboard_Layout.Items.Add($data.innerxml)	| out-null	
			}					
	}	
	
$Choose_Keyboard_Layout.add_SelectionChanged({
	$Global:My_Keyboard_Layout = $Choose_Keyboard_Layout.SelectedItem
	foreach ($data in $my_LanguageUI_xml.selectNodes("LanguageUI/KeyboardLocale/option"))			
		{
			If ($My_Keyboard_Layout -eq $data.innerxml)
				{
					$Global:My_Keyboard = $data.value	
				}
		}		
})	
	
	
#************************************************************************** Populate the OS Language ListBox ***********************************************************************************************
Function Populate_OSLanguage
		{
			$Lang_Packages = "$deploymentshare\Control\Packages.xml"						
			$my_Language_xml = [xml] (Get-Content $Lang_Packages)	
			$Global:MUI_packages = $my_Language_xml.packages.package | Where {$_.PackageType -match "LanguagePack"}			
			foreach ($data in $MUI_packages)						
				{
					$Choose_OSLanguage.Items.Add($data.Language)	| out-null						
				}					
		}
$Choose_OSLanguage.add_SelectionChanged({
	$Global:MY_OSLanguage = $Choose_OSLanguage.SelectedItem
	foreach ($data in $MUI_packages)		
		{
			If ($MY_OSLanguage -eq $data.Language)
				{
					$Global:My_Language_Pack_GUID = $data.guid	
					$Global:My_Language_Pack_Language = $data.language													
				}
		}			
})


#************************************************************************** Populate the second OS Language ListBox ***********************************************************************************************
Function Populate_Second_OSLanguage
		{
			$Lang_Packages = "$deploymentshare\Control\Packages.xml"						
			$my_Language_xml = [xml] (Get-Content $Lang_Packages)	
			$Global:MUI_packages = $my_Language_xml.packages.package | Where {$_.PackageType -match "LanguagePack"}			
			foreach ($data in $MUI_packages)						
				{
					$Choose_second_OSLanguage.Items.Add($data.Language)	| out-null	
				}					
		}
$Choose_second_OSLanguage.add_SelectionChanged({
	$Global:MY_Second_OSLanguage = $Choose_second_OSLanguage.SelectedItem
	foreach ($data in $MUI_packages)		
		{
			If ($MY_Second_OSLanguage -eq $data.Language)
				{
					$Global:My_Second_Language_Pack_GUID = $data.guid	
					$Global:My_Second_Language_Pack_Language = $data.language						
				}
		}			
})

#************************************************************************** Populate the TimeZone ListBox ***********************************************************************************************
Function Populate_TimeZone
	{		
		$LanguageUI = "MDT_LanguageUI.xml"										
		$Global:my_LanguageUI_xml = [xml] (Get-Content $LanguageUI)	
		foreach ($data in $my_LanguageUI_xml.selectNodes("LanguageUI/TimeZone/option"))				
			{
				$Choose_Timezone.Items.Add($data.innerxml)	| out-null	
			}					
	}	
	
$Choose_Timezone.add_SelectionChanged({
	$Global:My_Selected_TimeZone = $Choose_Timezone.SelectedItem
	foreach ($data in $my_LanguageUI_xml.selectNodes("LanguageUI/TimeZone/option"))				
		{
			If ($My_Selected_TimeZone -eq $data.innerxml)
				{
					$Global:My_Timezone = $data.value	
				}
		}		
})	
			
			
#************************************************************************** Populate the TaskSequence ListBox ***********************************************************************************************
Function Populate_TaskSequence
	{		
		$TS_xml = "$deploymentshare\Control\TaskSequences.xml"
		$Global:my_TS_xml = [xml] (Get-Content $TS_xml)	
		foreach ($data in $my_TS_xml.selectNodes("tss/ts"))
			{
				$Choose_TS.Items.Add($data.name)	| out-null	
			}					
	}	
	
$Choose_TS.add_SelectionChanged({
    $Global:My_Selected_TS = $Choose_TS.SelectedItem
	foreach ($data in $my_TS_xml.selectNodes("tss/ts"))
		{
			If ($My_Selected_TS -eq $data.name)
				{
					$Global:My_TaskSequence = $data.ID	
				}
		}		
})		
	

#************************************************************************** Populate the Applications DataGrid ***********************************************************************************************
Function Populate_Applis_Datagrid
	{
		$Global:list_applis = ""
		$Global:Input_Applications = ""
					
		$Global:list_applis = "$deploymentshare\Control\Applications.xml"						
		$Input_Applications = [xml] (Get-Content $list_applis)			
		foreach ($data in $Input_Applications.selectNodes("applications/application"))
			{
				$Applis_values = New-Object PSObject
				$Applis_values = $Applis_values | Add-Member NoteProperty Name $data.Name –passthru
				$Applis_values = $Applis_values | Add-Member NoteProperty GUID $data.GUID –passthru				
				$DataGrid_Applis.Items.Add($Applis_values) > $null
			}			
	}
	
	
#************************************************************************** Populate the GPO Pack ListBox ***********************************************************************************************
Function Populate_GPOPack
	{
		$Global:GPOPacks_Folder = "$deploymentshare\Templates\GPOPacks"	
		$Global:List_GPOPack_Folder = Get-ChildItem $GPOPacks_Folder | where {$_.Attributes -eq 'Directory'}
		foreach ($GPOPack in $List_GPOPack_Folder)
			{
				$GPO_Pack_path.Items.Add($GPOPack)	| out-null	
			}
			
		$GPO_Pack_path.add_SelectionChanged({
			$Global:My_Selected_GPOPack = $GPO_Pack_path.SelectedItem		
			write-host $My_Selected_GPOPack						
		})			
		
	}

########################################################################################################################################################################################################	
#*******************************************************************************************************************************************************************************************************
# 																		SCRIPT INITIALIZATION 
#*******************************************************************************************************************************************************************************************************
########################################################################################################################################################################################################
	
Populate_TimeZone 			# Run the Populate_TimeZone Function
Populate_KeyBoard 			# Run the Populate_KeyBoard Function
Populate_OSLanguage 		# Run the Populate_OSLanguage Function
Populate_Second_OSLanguage  # Run the Populate_Second_OSLanguage Function
Populate_TaskSequence		# Run the Populate_TaskSequence Function
Populate_Applis_Datagrid 	# Run the Populate_Applis_Datagrid Function
Populate_GPOPack      		# Run the Populate_GPOPack Function

$Global:OSDProfile_Name = $Profile_Name.Text.ToString()

If ($deploymentshare -eq "")
	{
		$Profile_Path_Info.Content = "Select a path for your profile file"
		$Profile_Path_Info.Foreground = "red"		
		
		$OS_Language_Info.Content = "No Deployment Share. This field can't be populated."
		$OS_Language_Info.Foreground = "red"	
		
		$Second_OS_Language_Info.Content = "No Deployment Share. This field can't be populated."
		$Second_OS_Language_Info.Foreground = "red"			
		
		$Choose_TS_Info.Content = "No Deployment Share. This field can't be populated."
		$Choose_TS_Info.Foreground = "red"			
		
		$GPO_Pack_Info.Content = "No Deployment Share. This field can't be populated."
		$GPO_Pack_Info.Foreground = "red"		
	}
Else
	{
		$Global:Profile_Location = "Deploymentshare"
		$Profile_Path_Info.Content = "It'll be saved by default in your deploymentshare"
		$Second_OS_Language_Info.Content = "Second language to apply to your OS"
		$GPO_Pack_Info.Content = "List GPO Packs found in the templates folder."
		
	}

########################################################################################################################################################################################################	
#*******************************************************************************************************************************************************************************************************
# 																		BUTTONS ACTIONS 
#*******************************************************************************************************************************************************************************************************
########################################################################################################################################################################################################


#************************************************************************** Profile path Button ***********************************************************************************************	
$Profile_Path.Add_Click({	
    $folder = $object.BrowseForFolder(0, $message, 0, 0) 
    If ($folder -ne $null) 
		{ 		
			$global:Profile_Folder = $folder.self.Path 
			$Profile_Path_TextBox.Text =  $Profile_Folder		
			$Profile_Path_Info.Content = "Profile will be saved in $Profile_Folder"
			$Profile_Path_Info.Foreground = "black"			
			$Global:Profile_Location = "Choose"			
		}
})	



#************************************************************************** Choose Deployment type Button ***********************************************************************************************	
$Choose_deploy_type.Add_Click({	
	If ($Deployment_Type_NoSet.IsSelected -eq $true)
		{
			$computerbackup_location_label.Content = "Capture"	
			$UserDataLocation_Label.Content = "Move and Restore User Data"	

			# Part for Capture or Computer Backup
			$Capture_computer.Visibility = "Visible"
			$Capture_Location.Visibility = "Visible"
			$Capture_Name.Visibility = "Visible"
			$Capture_User_Name.Visibility = "Visible"
			$Capture_User_Password.Visibility = "Visible"
			$Capture_User_Domain.Visibility = "Visible"
			$Computer_Backup_type.Visibility = "Collapsed"
			$Computer_Backup_Location.Visibility = "Collapsed"	
			
			# Part for Move and restore user data
			$user_data_backup_type.Visibility = "Collapsed"
			$Backup_Location.Visibility = "Collapsed"
			$move_userdata.Visibility = "Visible"
			$restore_user_data.Visibility = "Visible"
			$Restore_Location.Visibility = "Visible"	
		}
	ElseIf ($Deployment_Type_Newcomputer.IsSelected -eq $true)
		{
			$computerbackup_location_label.Content = "Capture"	
			$UserDataLocation_Label.Content = "Move and Restore User Data"	

			# Part for Capture or Computer Backup
			$Capture_computer.Visibility = "Visible"
			$Capture_Location.Visibility = "Visible"
			$Capture_Name.Visibility = "Visible"
			$Capture_User_Name.Visibility = "Visible"
			$Capture_User_Password.Visibility = "Visible"
			$Capture_User_Domain.Visibility = "Visible"
			$Computer_Backup_type.Visibility = "Collapsed"
			$Computer_Backup_Location.Visibility = "Collapsed"				
			
			# Part for Move and restore user data
			$user_data_backup_type.Visibility = "Collapsed"
			$Backup_Location.Visibility = "Collapsed"
			$move_userdata.Visibility = "Visible"
			$restore_user_data.Visibility = "Visible"
			$Restore_Location.Visibility = "Visible"	
		}	
	ElseIf ($Deployment_Type_Refresh.IsSelected -eq $true)
		{
			$computerbackup_location_label.Content = "Computer backup"	
			$computerbackup_location_label.ToolTip = "Specify where to save a complete computer backup"					
			$UserDataLocation_Label.Content = "User Data"
			$UserDataLocation_Label.ToolTip = "Specify where to save your data and settings"
			
			# Part for Capture or Computer Backup
			$Capture_computer.Visibility = "Collapsed"
			$Capture_Location.Visibility = "Collapsed"
			$Capture_Name.Visibility = "Collapsed"
			$Capture_User_Name.Visibility = "Collapsed"
			$Capture_User_Password.Visibility = "Collapsed"
			$Capture_User_Domain.Visibility = "Collapsed"		
			$Computer_Backup_type.Visibility = "Visible"
			$Computer_Backup_Location.Visibility = "Visible"	
			
			# Part for Move and restore user data			
			$user_data_backup_type.Visibility = "Visible"
			$Backup_Location.Visibility = "Visible"
			$move_userdata.Visibility = "Collapsed"
			$restore_user_data.Visibility = "Collapsed"
			$Restore_Location.Visibility = "Collapsed"
		}		
})	



#************************************************************************** Choose Domain/Workgroup Button ***********************************************************************************************	
$Choose_mode.Add_Click({	
	If ($Mode_Domain.IsSelected -eq $True)		
		{
			$UserName.IsEnabled = $true 
			$Domain_Admin_Pwd.IsEnabled = $true 	
			$OU_name.IsEnabled = $true 	
			$Domaine_Wkg_Label.Content = "Domain name"			
		}
	Else
		{
			$UserName.IsEnabled = $false 
			$Domain_Admin_Pwd.IsEnabled = $false 	
			$OU_name.IsEnabled = $false 	
			$Domaine_Wkg_Label.Content = "Workgroup name"						
		}
})	
	
	
#************************************************************************** Choose Network type Button ***********************************************************************************************		
$Choose_Network_Type.Add_Click({	
	If ($Choose_DHCP.IsSelected -eq $True)		
		{			
			$IPAddress.IsEnabled = $false 
			$Gateway.IsEnabled = $false 
			$SubnetMask.IsEnabled = $false 				
		}
	Else
		{
			$IPAddress.IsEnabled = $true 
			$Gateway.IsEnabled = $true 
			$SubnetMask.IsEnabled = $true 	
		}	
})		
	
	
#************************************************************************** Do capture Button ***********************************************************************************************	
$Choose_capture.Add_Click({			
	If ($capture_computer_no.IsSelected -eq $true)
		{
			$Capture_backup_location_textbox.IsEnabled = $false 	
			$Capture_file_name.IsEnabled = $false 		
			$Combo_Backup_Type.IsEnabled = $false 		
			$Capture_location_user.IsEnabled = $false 	
			$Capture_location_password.IsEnabled = $false 	
			$Capture_location_domain.IsEnabled = $false 				
		}		
	ElseIf ($capture_computer_yes.IsSelected -eq $true)
		{
			$Capture_backup_location_textbox.IsEnabled = $true 	
			$Capture_file_name.IsEnabled = $true 		
			$Combo_Backup_Type.IsEnabled = $true 	
			$Capture_location_user.IsEnabled = $true 	
			$Capture_location_password.IsEnabled = $true 	
			$Capture_location_domain.IsEnabled = $true 			
		}		
	ElseIf ($sysprep_this_computer.IsSelected -eq $true)
		{
			$Capture_backup_location_textbox.IsEnabled = $false 	
			$Capture_file_name.IsEnabled = $false 		
			$Combo_Backup_Type.IsEnabled = $false 		
			$Capture_location_user.IsEnabled = $false 	
			$Capture_location_password.IsEnabled = $false 	
			$Capture_location_domain.IsEnabled = $false 	
		}	
	ElseIf ($prepare_to_capture.IsSelected -eq $true)
		{
			$Capture_backup_location_textbox.IsEnabled = $false 	
			$Capture_file_name.IsEnabled = $false 		
			$Combo_Backup_Type.IsEnabled = $false 		
			$Capture_location_user.IsEnabled = $false 	
			$Capture_location_password.IsEnabled = $false 	
			$Capture_location_domain.IsEnabled = $false 		
		}			
	
})		
	

#************************************************************************** About Button ***********************************************************************************************	
$about.Add_Click({	
	powershell "$Current_Folder\About.ps1" 
})		
	
#************************************************************************** Clear Button ***********************************************************************************************	
$Clear_All_Button.Add_Click({	
	$Profile_Name.Text = ""
	$Profile_Path_TextBox.Text = ""
	$Computer_Name.Text = ""
	$Local_Admin_PWD.Text = ""
	$Domaine_Wkg_txtbox.Text = ""
	$OU_name.Text = ""
	$UserName.Text = ""
	$Domain_Admin_Pwd.Text = ""
	$IPAddress.Text = ""
	$Gateway.Text = ""
	$SubnetMask.Text = ""
	$Org_name.Text = ""
	$DNS_Server.Text = ""
	$IE_home_page.Text = ""
	$Capture_file_name.Text = ""
	$Capture_backup_location_textbox.Text = ""
	$UserData_restore_location_textbox.Text = ""
	$restore_user_data_no.IsSelected = $true
	$Capture_no.IsSelected = $true
	
	$UserName.IsEnabled = $false 
	$Capture_backup_location_textbox.IsEnabled = $false 	
	$Capture_file_name.IsEnabled = $false 		
	
	$Skip_All.IsSelected = $false
	$Skip_TS.IsSelected = $false
	$Skip_ProductKey.IsCkecked = $false
	$Skip_move_user_data.IsCkecked = $false
	$Skip_DomainMemberShip.IsCkecked = $false
	$Skip_restore_UserData.IsCkecked = $false
	$Skip_AdminPWD.IsCkecked = $false
	$Skip_Applications.IsCkecked = $false
	$Skip_Capture.IsCkecked = $false
	$Skip_Bitlocker.IsCkecked = $false
	$Skip_Summary.IsCkecked = $false
	$Skip_Locale_time.IsCkecked = $false
	$Skip_Language_packs.IsCkecked = $false
	$Skip_Computer_name.IsCkecked = $false	
})

	
#************************************************************************** Create profile Button ***********************************************************************************************		
$Create_Profile.Add_Click({	

	$OSDProfile_Name = $Profile_Name.Text.ToString()

	If ($Profile_Location -eq "deploymentshare")
		{
			$Global:Profile_File = "$deploymentshare\Control\$OSDProfile_Name"			
		}
	
	ElseIf ($Profile_Location = "choose")
		{
			$Global:Profile_File = "$Profile_Folder\$OSDProfile_Name"	
		}

	$OSD_ComputerName = $Computer_Name.Text.ToString()
	$OSD_Local_Password = $Local_Admin_PWD.Text.ToString()
	$OSD_IPAddress = $IPAddress.Text.ToString()
	$OSD_Gateway = $Gateway.Text.ToString()
	$OSD_SubnetMask = $SubnetMask.Text.ToString()
	$OSD_DNSServer = $DNS_Server.Text.ToString()
	$OSD_HomePage = $IE_home_page.Text.ToString()
	$OSD_OrgName = $Org_name.Text.ToString()	
	
	$OSD_Domain_Wkg_Name = $Domaine_Wkg_txtbox.Text.ToString()
	$OSD_OU_name = $OU_name.Text.ToString()
	$OSD_UserName = $UserName.Text.ToString()
	$OSD_Domain_Admin_Pwd = $Domain_Admin_Pwd.Text.ToString()
	$OSD_Capture_File_name = $Capture_file_name.Text.ToString()
	$OSD_WSUS_Server = $Set_WSUS_Server.Text.ToString()
	$OSD_Capture_Location = $Capture_backup_location_textbox.Text.ToString()
	$OSD_Event_Service = $Event_Service.Text.ToString()
	$OSD_Logs_SLShareDynamicLogging = $Logs_SLShareDynamicLogging.Text.ToString()
	$OSD_Logs_SLShare = $Logs_SLShare.Text.ToString()
	
	$OSD_Capture_location_user = $Capture_location_user.Text.ToString()	
	$OSD_Capture_location_password = $Capture_location_password.Text.ToString()	
	$OSD_Capture_location_domain = $Capture_location_domain.Text.ToString()	
	
	$OSD_UserData_restore_location = $UserData_restore_location_textbox.Text.ToString()	

	$OSD_Computer_Backup_Location_TextBox = $Computer_Backup_Location_TextBox.Text.ToString()
	$OSD_UserData_Backup_location_textbox = $UserData_Backup_location_textbox.Text.ToString()
	
	$Test_Profile_File = Test-Path $Profile_File
	If ($Test_Profile_File -eq $true)
		{		
			$Profile_Name_Info.Content = "The file $OSDProfile_Name already exists"
			$Profile_Name_Info.Foreground = "red"
			[System.Windows.Forms.MessageBox]::Show("The file $OSDProfile_Name already exists") 			
		}
	Else
		{
			New-Item $Profile_File -type file
			Add-Content $Profile_File ";------------------------------------------------------------------------------------------"			
			Add-Content $Profile_File ";$OSDProfile_Name - This file has been generated with MDT Profile Generator"
			Add-Content $Profile_File ";------------------------------------------------------------------------------------------"		
					
			Add-Content $Profile_File "[Settings]"
			Add-Content $Profile_File "Priority=Default"
			Add-Content $Profile_File "Properties=MyCustomProperty"
			If ($OSD_OrgName -ne "")
				{
					Add-Content $Profile_File "_SMSTSORGNAME=$OSD_OrgName"							
				}
			Add-Content $Profile_File ""
			Add-Content $Profile_File "[Default]"
			
			If($Computer_Name_SN.IsChecked -eq $true)
				{
					Add-Content $Profile_File "OSDComputername=%SerialNumber%"					
				}
			Else	
				{
					Add-Content $Profile_File "OSDComputername=$OSD_ComputerName"				
				}

			Add-Content $Profile_File "AdminPassword=$OSD_Local_Password"	
			Add-Content $Profile_File "TaskSequenceID=$My_TaskSequence"	

			Add-Content $Profile_File ""						
			Add-Content $Profile_File ";------------------------------------------------------------------------------------------"			
			Add-Content $Profile_File ";NETWORK SELECTION"					
			Add-Content $Profile_File ";------------------------------------------------------------------------------------------"		
			If ($OSD_HomePage -ne "")
				{
					Add-Content $Profile_File "Home_Page=$OSD_HomePage"			
				}
			
			If ($Choose_DHCP.IsSelected -eq $true)
				{
					Add-Content $Profile_File "OSDAdapterCount=1"	
					Add-Content $Profile_File "OSDAdapter0EnableDHCP=TRUE"		
				}
				
			Else
				{			
					Add-Content $Profile_File "OSDAdapterCount=1"	
					Add-Content $Profile_File "OSDAdapter0EnableDHCP=FALSE"	
					Add-Content $Profile_File "OSDAdapter0IPAddressList=$OSD_IPAddress"	
					Add-Content $Profile_File "OSDAdapter0Gateways=$OSD_Gateway"	
					Add-Content $Profile_File "OSDAdapter0SubnetMask=$OSD_SubnetMask"	
					Add-Content $Profile_File "OSDAdapter0DNSServerList=$OSD_DNSServer"							
				}	

				
			Add-Content $Profile_File ""						
			Add-Content $Profile_File ";------------------------------------------------------------------------------------------"			
			Add-Content $Profile_File ";BACKUP SELECTION - CAPTURE AND COMPUTER BACKUP PART"					
			Add-Content $Profile_File ";------------------------------------------------------------------------------------------"			

#---------------------------------------------------------  Deployment Type PART ---------------------------------------------------------				
			
			If (($Deployment_Type_Newcomputer.IsSelected -eq $true) -or ($Deployment_Type_NoSet.IsSelected -eq $true))
				{
					Add-Content $Profile_File "DeploymentType=NEWCOMPUTER"		
#---------------------------------------------------------  Capture PART ---------------------------------------------------------				
					If ($VHD_File.IsSelected -eq $true)
						{
							$Backup_File_extension = "vhd"
						}
					ElseIf ($WIM_file.IsSelected -eq $true)
						{
							$Backup_File_extension = "wim"				
						}	

					If ($capture_computer_no.IsSelected -eq $true)
						{
							Add-Content $Profile_File "DoCapture=NO"	
							Add-Content $Profile_File "ComputerBackupLocation=NONE"	
						}					
					ElseIf ($capture_computer_yes.IsSelected -eq $true)
						{
							Add-Content $Profile_File "DoCapture=YES"	
							Add-Content $Profile_File "ComputerBackupLocation=$OSD_Capture_Location"		
							Add-Content $Profile_File "BackupFile=$OSD_Capture_File_name.$Backup_File_extension"	
							Add-Content $Profile_File "UserID=$OSD_Capture_location_user"		
							Add-Content $Profile_File "UserDomain=$OSD_Capture_location_domain"		
							Add-Content $Profile_File "UserPassword=$OSD_Capture_location_password"							
						}					
					ElseIf ($sysprep_this_computer.IsSelected -eq $true)
						{
							Add-Content $Profile_File "DoCapture=SYSPREP"							
						}						
					ElseIf ($prepare_to_capture.IsSelected -eq $true)
						{
							Add-Content $Profile_File "DoCapture=PREPARE"							
						}			
#---------------------------------------------------------  Move User Data and Settings PART ---------------------------------------------------------				
					Add-Content $Profile_File ""						
					Add-Content $Profile_File ";------------------------------------------------------------------------------------------"			
					Add-Content $Profile_File ";BACKUP SELECTION - RESTORE USER DATA PART"					
					Add-Content $Profile_File ";------------------------------------------------------------------------------------------"		

					If ($move_data_yes.IsChecked -eq $True)	
						{
							Add-Content $Profile_File "USMTOfflineMigration=True"	
						}
#---------------------------------------------------------  Restore User Data and Settings PART ---------------------------------------------------------				
					Add-Content $Profile_File ""						
					Add-Content $Profile_File ";------------------------------------------------------------------------------------------"			
					Add-Content $Profile_File ";BACKUP SELECTION - RESTORE USER DATA PART"					
					Add-Content $Profile_File ";------------------------------------------------------------------------------------------"					
				
					If ($restore_user_data_no.IsSelected -eq $true)
						{
							Add-Content $Profile_File "UserDataLocation=NONE"	
						}		
					ElseIf ($restore_user_data_specify_location.IsSelected -eq $true)
						{
							Add-Content $Profile_File "UserDataLocation=NETWORK"	
							Add-Content $Profile_File "UserDataLocation=$OSD_UserData_restore_location"							
						}						
				}
				
			ElseIf ($Deployment_Type_Refresh.IsSelected -eq $true)   # REFRESH PART
				{
					Add-Content $Profile_File "DeploymentType=REFRESH"	
#---------------------------------------------------------  Computer Backup PART ---------------------------------------------------------				
					If ($Backup_Computer_No.IsSelected -eq $true)
						{
							Add-Content $Profile_File "ComputerBackupLocation=NONE"	
						}	
					ElseIf ($Backup_Computer_Auto.IsSelected -eq $true)
						{
							Add-Content $Profile_File "ComputerBackupLocation=AUTO"	
						}					
					ElseIf ($Backup_Computer_Specify.IsSelected -eq $true)
						{
							Add-Content $Profile_File "ComputerBackupLocation=$OSD_Computer_Backup_Location_TextBox"							
						}					
		
#---------------------------------------------------------  Move User Data and Settings PART ---------------------------------------------------------				
					Add-Content $Profile_File ""						
					Add-Content $Profile_File ";------------------------------------------------------------------------------------------"			
					Add-Content $Profile_File ";BACKUP SELECTION - BACKUP USER DATA PART"					
					Add-Content $Profile_File ";------------------------------------------------------------------------------------------"		

					If ($Backup_Computer_No.IsSelected -eq $true)
						{
							Add-Content $Profile_File "UserDataLocation=NONE"								
						}	
					ElseIf ($Backup_Computer_Auto.IsSelected -eq $true)
						{
							Add-Content $Profile_File "UserDataLocation=AUTO"	
						}					
					ElseIf ($Backup_Computer_Specify.IsSelected -eq $true)
						{
							Add-Content $Profile_File "UserDataLocation=$OSD_UserData_Backup_location_textbox"							
						}				
				}		
		
			
			
			Add-Content $Profile_File ""							
			Add-Content $Profile_File ";------------------------------------------------------------------------------------------"			
			Add-Content $Profile_File ";DOMAIN/WORKGROUP SELECTION"					
			Add-Content $Profile_File ";------------------------------------------------------------------------------------------"			
				
			If ($Mode_Workgroup.IsSelected -eq $true)
				{
					Add-Content $Profile_File "JoinWorkGroup=WorkGroup"	
				}
				
			Else
				{			
					Add-Content $Profile_File "JoinDomain=$OSD_Domain_Wkg_Name"	
					Add-Content $Profile_File "DomainAdminDomain=$OSD_Domain_Wkg_Name"						
					Add-Content $Profile_File "MachineObjectOU=$OSD_OU_name"	
					Add-Content $Profile_File "DomainAdmin=$OSD_UserName"	
					Add-Content $Profile_File "DomainAdminPassword=$OSD_Domain_Admin_Pwd"	
				}			
			Add-Content $Profile_File ""					
			Add-Content $Profile_File ";------------------------------------------------------------------------------------------"			
			Add-Content $Profile_File ";LOCALE AND TIME SELECTION"					
			Add-Content $Profile_File ";------------------------------------------------------------------------------------------"			
				
			Add-Content $Profile_File "LanguagePacks1=$My_Language_Pack_GUID"	
			
			If ($Second_language_none.IsSelected -ne $true)
				{
					Add-Content $Profile_File "LanguagePacks2=$My_Second_Language_Pack_GUID"								
				}
				
			Add-Content $Profile_File "UILanguage=$My_Language_Pack_Language"		
			Add-Content $Profile_File "TimeZoneName=$My_Timezone"	
			Add-Content $Profile_File "KeyboardLocale=$My_Keyboard"	# Keyboard Layout
			Add-Content $Profile_File "UserLocale=$My_Language_Pack_Language"	 # Time and currency format
		
			Add-Content $Profile_File ""							
			Add-Content $Profile_File ";------------------------------------------------------------------------------------------"			
			Add-Content $Profile_File ";APPLICATION SELECTION"					
			Add-Content $Profile_File ";------------------------------------------------------------------------------------------"			
					
			If ($DataGrid_Applis.SelectedIndex -ne "-1") # Check if a row is selected in the datagrid
				{
					$Global:Selected_Applications = $DataGrid_Applis.SelectedItems # All selected applications
					$All_Row_count = $DataGrid_Applis.items.count					
					$Global:Selected_Applis_count = $Selected_Applications.count	

					$i=0
					While ($i -lt $Selected_Applis_count)
						{			
							ForEach ($Global:Appli in $Selected_Applications)
								{						
									foreach ($data in $Appli)
										{
											$Global:My_Values = New-Object -TypeName PSObject -Property @{
												GUID = $data.guid} 
												$Global:appli_values = $My_Values | select guid
												$Global:guid = $appli_values.guid
											$i++													
											Add-Content $Profile_File "MandatoryApplications$i=$guid"	
										}
								}
						}									
				}
			Else
				{
					Add-Content $Profile_File ";No applications selected"						
				}					
			
			Add-Content $Profile_File ""						
			Add-Content $Profile_File ";------------------------------------------------------------------------------------------"			
			Add-Content $Profile_File ";WIZARD SELECTION"					
			Add-Content $Profile_File ";------------------------------------------------------------------------------------------"			
			Add-Content $Profile_File "SkipBDDWelcome=YES"			

			If ($Skip_All.IsChecked -eq $true)
				{
					Add-Content $Profile_File "SkipWizard=YES"			
				}
			
			If ($Skip_TS.IsChecked -eq $true)
				{
					Add-Content $Profile_File "SkipTaskSequence=YES"			
				}
				
			If ($Skip_ProductKey.IsChecked -eq $true)
				{
					Add-Content $Profile_File "SkipProductKey=YES"			
				}	
				
			If ($Skip_move_user_data.IsChecked -eq $true)
				{
					Add-Content $Profile_File "SkipComputerBackup=YES"			
				}	
				
			If ($Skip_DomainMemberShip.IsChecked -eq $true)
				{
					Add-Content $Profile_File "SkipDomainMembership=YES"			
				}
				
			If ($Skip_restore_UserData.IsChecked -eq $true)
				{
					Add-Content $Profile_File "SkipUserData=YES"			
				}

			If ($Skip_AdminPWD.IsChecked -eq $true)
				{
					Add-Content $Profile_File "SkipAdminPassword=YES"			
				}		
				
			If ($Skip_Applications.IsChecked -eq $true)
				{
					Add-Content $Profile_File "SkipApplications=YES"			
				}	

			If ($Skip_Capture.IsChecked -eq $true)
				{
					Add-Content $Profile_File "SkipCapture=YES"			
				}				
			
			If ($Skip_Bitlocker.IsChecked -eq $true)
				{
					Add-Content $Profile_File "SkipBitLocker=YES"			
				}

			If ($Skip_Summary.IsChecked -eq $true)
				{
					Add-Content $Profile_File "SkipFinalSummary=YES"			
				}
				
			If ($Skip_Locale_time.IsChecked -eq $true)
				{
					Add-Content $Profile_File "SkipLocaleSelection=YES"		
					Add-Content $Profile_File "SkipTimeZone=YES"					
				}
				
			If ($Skip_Language_packs.IsChecked -eq $true)
				{
					Add-Content $Profile_File "SkipPackageDisplay=YES"			
				}	
				
			If ($Skip_Language_packs.IsChecked -eq $true)
				{
					Add-Content $Profile_File "SkipComputerName=YES"			
				}				

			Add-Content $Profile_File ""						
			Add-Content $Profile_File ";------------------------------------------------------------------------------------------"			
			Add-Content $Profile_File ";OTHER PART"					
			Add-Content $Profile_File ";------------------------------------------------------------------------------------------"	
			
			If ($GPO_Pack_DoNothing.IsSelected -eq $true)
				{
					Add-Content $Profile_File "ApplyGPOPack=NO"															
				}
			Else
				{
					Add-Content $Profile_File "ApplyGPOPack=YES"										
					Add-Content $Profile_File "GPOPackPath=$My_Selected_GPOPack"						
				}			
			
			If ($Finish_Action_Reboot.IsSelected -eq $true)
				{
					Add-Content $Profile_File "FinishAction=REBOOT"										
				}
			ElseIf ($Finish_Action_Shutdown.IsSelected -eq $true)
				{
					Add-Content $Profile_File "FinishAction=SHUTDOWN"										
				}
				
			ElseIf ($Finish_Action_LogOff.IsSelected -eq $true)
				{
					Add-Content $Profile_File "FinishAction=LOGOFF"										
				}			

			If ($Set_WSUS_Server.Text -ne "")
				{
					Add-Content $Profile_File "WSUSServer=$OSD_WSUS_Server"														
				}
				
			If ($Event_Service.Text -ne "")
				{
					Add-Content $Profile_File "EventService=$OSD_Event_Service"														
				}		

			If ($Logs_SLShareDynamicLogging.Text -ne "")
				{
					Add-Content $Profile_File "SLShareDynamicLogging=$OSD_Logs_SLShareDynamicLogging"														
				}		
		
			If($SLShare_Deployroot.IsChecked -eq $true)
				{
					Add-Content $Profile_File "SLShare=%DeployRoot%\Logs\$OSD_ComputerName"					
				}
			Else	
				{
					If ($Logs_SLShare.Text -ne "")		
						{
							Add-Content $Profile_File "SLShare=$OSD_Logs_SLShare"														
						}			
				}			
			
			If ($Hide_Shell.IsChecked -eq $true)
				{
					Add-Content $Profile_File "HideShell=YES"			
				}				
				
			If ($Not_extra_partition.IsChecked -eq $true)
				{
					Add-Content $Profile_File "DoNotCreateExtraPartition=YES"			
				}			
	
			invoke-item $Profile_File			
		}	
})	

# Show FORM
$Form.ShowDialog() | Out-Null	