extends Panel

enum ProductTiers {free, basic, premium}
var Tier = ProductTiers.premium

onready var savemanager = get_node("../SaveManager")
onready var LineEdits = {
	"Application": $VBoxContainer/App_Edit,
	"Email": $VBoxContainer/Email_Edit,
	"User": $VBoxContainer/User_Edit,
	"Pass": $VBoxContainer/Pass_Edit,
	"Desc": $VBoxContainer/Desc_Edit
}

var KeyBinds = {
	"exit": "ui_cancel",
	"close_acc": "ui_left",
	"nextline": "ui_focus_next",
	"enter":"ui_accept"
}

var Settings = {
	"Themes":"light",
	"Wallpaper":0,
	"EncryptKey":null
}

func _ready():
	randomize()
	check_tier()
	#Add Loading Settings
	pass

func check_tier():
	$"../PurchaseEmbed".hide()
	pass

func _process(delta):
	if Input.is_action_just_pressed(KeyBinds.exit):
		Settings.Wallpaper = savemanager.WallList.get_selected_items()
		
		savemanager.save_settings(Settings)
		#Add Saving This Setting as well as others
		get_tree().quit()
		pass
	if Input.is_action_just_pressed(KeyBinds.close_acc):
		if self.visible:
			self.hide()
		else:
			self.show()
		pass
	if Input.is_action_just_pressed(KeyBinds.enter):
		savemanager.clearboxes()
		savemanager.save_account(LineEdits.Application.text, LineEdits.Email.text, LineEdits.User.text, LineEdits.Pass.text, LineEdits.Desc.text)
		pass
	pass


func _on_PasswordCheck_toggled(button_pressed):
	if (button_pressed):
		LineEdits.Pass.secret = true
	else:
		LineEdits.Pass.secret = false
	pass


func _on_PasswordCheck2_toggled(button_pressed):
	
	pass


func _on_Purchase_pressed():
	OS.shell_open("https://neofrags.itch.io/offpass-manager")
	pass


func _on_PasswordCheck2_pressed():
	#print("yes")
	savemanager.clearboxes()
	savemanager.save_account(LineEdits.Application.text, LineEdits.Email.text, LineEdits.User.text, LineEdits.Pass.text, LineEdits.Desc.text)
	pass # Replace with function body.
