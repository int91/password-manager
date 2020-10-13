extends Node

var Directories = []
var AccFiles = []
var Wallpapers = []
onready var LineEdits = {
	"Application": $"../AccountCreator/VBoxContainer/App_Edit",
	"Email": $"../AccountCreator/VBoxContainer/Email_Edit",
	"User": $"../AccountCreator/VBoxContainer/User_Edit",
	"Pass": $"../AccountCreator/VBoxContainer/Pass_Edit"
}
onready var Creator = $"../AccountCreator"
onready var Viewer = $"../AccountViewer"
onready var WallList = $"../Selectors/ItemList"
onready var AccList = $"../Selectors/ItemList2"
onready var AppList = $"../Selectors/ItemList3"
onready var Background = $"../Background"
#Finish working on the PurchaseEmbed Button
func _ready():
	make_wallpaper()
	list_wallpapers()
	list_accounts()
	load_settings()
	pass

var SelectedCategory = 0

func clearboxes():
	AccList.clear()
	AppList.clear()
	WallList.clear()
	pass

func list_accounts():
	Directories = list_files_in_directory("user://")
	pass

func make_wallpaper():
	var saveDirectory = Directory.new()
	saveDirectory.open("user://")
	saveDirectory.make_dir("Wallpapers")

func set_background(index):
	var tex = ImageTexture.new()
	var img = Image.new()
	img.load("user://Wallpapers/" + Wallpapers[index])
	tex.create_from_image(img)
	return tex

func list_wallpapers():
	var files = []
	var dir = Directory.new()
	dir.open("user://Wallpapers")
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif !file.begins_with(".") && file.ends_with(".png") or !file.begins_with(".") && file.ends_with(".jpg"):
			Wallpapers.append(file)
			WallList.add_item(file, null, true)
	dir.list_dir_end()
	#Background.texture = set_background(0)
	return files

func list_files_folder(path):
	AccList.clear()
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif !file.begins_with(".") && !file.begins_with("..") && !".png" in file && !".jpg" in file && file.ends_with(".acc"):
			files.append(file)
			AccList.add_item(file, null, true)
	dir.list_dir_end()
	return files

func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif !file.begins_with(".") && !".png" in file && !".jpg" in file && !"Wallpapers" in file && !".acc" in file && !".cfg" in file:
			files.append(file)
			AppList.add_item(file, null, true)
	dir.list_dir_end()
	return files

func save_account(app, email, user, passw):
	save_settings(Creator.Settings)
	list_wallpapers()
	print("Making")
	var account_data = {
		"application":app,
		"email":email,
		"user":user,
		"pass":passw
	}
	if (account_data.application != "" && account_data.email != "" && account_data.user != "" && account_data.pass != ""):
		var saveDirectory = Directory.new()
		var saveFile = File.new()
		saveDirectory.open("user://")
		saveDirectory.make_dir(account_data.application)
		saveFile.open("user://"+account_data.application+"/" + account_data.user + ".acc", File.WRITE)
		saveFile.store_line(to_json(account_data))
		saveFile.close()
		Creator.LineEdits.Application.clear()
		Creator.LineEdits.Email.clear()
		Creator.LineEdits.User.clear()
		Creator.LineEdits.Pass.clear()
	else:
		print("Fill out all boxes pls")
	list_accounts()
	pass

func save_settings(settings):
	var Data = settings
	var saveDirectory = Directory.new()
	var saveFile = File.new()
	saveDirectory.open("user://")
	saveFile.open("user://settings.cfg", File.WRITE)
	saveFile.store_line(to_json(Data))
	saveFile.close()
	pass

func load_account(User):
	var Viewer = $"../AccountViewer"
	var saveFile = File.new()
	saveFile.open("user://" + SelectedCategory + "/" + AccFiles[User], File.READ)
	var result_json = JSON.parse(saveFile.get_as_text())
	var result = {}
	if result_json.error == OK:
		var data = result_json.result
		Viewer.account_data = data
	else:
		print("Error: ", result_json.error)
		print("Error Line: ", result_json.error_line)
		print("Error String: ", result_json.error_string)
	saveFile.close()

func load_settings():
	Creator = $"../AccountCreator"
	var saveFile = File.new()
	saveFile.open("user://settings.cfg", File.READ)
	var result_json = JSON.parse(saveFile.get_as_text())
	var result = {}
	if result_json.error == OK:
		var data = result_json.result
		Creator.Settings = data
		if data.Wallpaper != []:
			Background.texture = set_background(int(data.Wallpaper[0]))
			pass
	else:
		print("Error: ", result_json.error)
		print("Error Line: ", result_json.error_line)
		print("Error String: ", result_json.error_string)
	saveFile.close()

func _on_ItemList_item_selected(index):
	Background.texture = set_background(index)
	pass


func _on_ItemList3_item_selected(index):
	AccFiles = list_files_folder("user://"+Directories[index])
	SelectedCategory = Directories[index]
	pass


func _on_ItemList2_item_selected(index):
	if SelectedCategory != null:
		load_account(index)
		Viewer.AppText.text = Viewer.account_data.application
		Viewer.EmailText.text = Viewer.account_data.email
		Viewer.UserText.text = Viewer.account_data.user
		Viewer.AccText.text = Viewer.account_data.pass
	pass


func _on_TextureButton_pressed():
	OS.shell_open("https://neofrags.itch.io/offpass-manager")
	pass
