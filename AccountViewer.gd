extends Panel

onready var AppText = $VBoxContainer2/Label_App
onready var EmailText = $VBoxContainer2/Label_Email
onready var UserText = $VBoxContainer2/Label_User
onready var AccText = $VBoxContainer2/Label_Acc
onready var DescText = $VBoxContainer2/Label_Desc

var account_data = {
	"application":"",
	"email":"",
	"user":"",
	"pass":"",
	"desc":""
}

func _ready():
	pass 
	
func _process(delta):
	
	pass
