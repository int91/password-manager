extends Panel

onready var AppText = $VBoxContainer2/Label_App
onready var EmailText = $VBoxContainer2/Label_Email
onready var UserText = $VBoxContainer2/Label_User
onready var AccText = $VBoxContainer2/Label_Acc

var account_data = {
	"application":"",
	"email":"",
	"user":"",
	"pass":"",
}

func _ready():
	pass 
	
func _process(delta):
	AppText.text = "Application: " + account_data.application
	EmailText.text = "Email: " + account_data.email
	UserText.text = "Username: " + account_data.user
	AccText.text = "Password: " + account_data.pass
	pass
