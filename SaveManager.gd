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
onready var creator = $"../AccountCreator"
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
	var save_directory = Directory.new()
	save_directory.open("user://")
	save_directory.make_dir("Wallpapers")

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
	save_settings(creator.Settings)
	list_wallpapers()
	print("Making")
	var account_data = {
		"application":app,
		"email":email,
		"user":user,
		"pass":passw
	}
	if (account_data.application != "" && account_data.email != "" && account_data.user != "" && account_data.pass != ""):
		var save_directory = Directory.new()
		var save_file = File.new()
		save_directory.open("user://")
		save_directory.make_dir(account_data.application)
		save_file.open("user://"+account_data.application+"/" + account_data.user + ".acc", File.WRITE)
		save_file.store_line(to_json(account_data))
		save_file.close()
		creator.LineEdits.Application.clear()
		creator.LineEdits.Email.clear()
		creator.LineEdits.User.clear()
		creator.LineEdits.Pass.clear()
	else:
		print("Fill out all boxes pls")
	list_accounts()
	pass

func save_settings(settings):
	var data = settings
	var save_directory = Directory.new()
	var save_file = File.new()
	save_directory.open("user://")
	save_file.open("user://settings.cfg", File.WRITE)
	save_file.store_line(to_json(data))
	save_file.close()
	pass

func load_account(User):
	var viewer = $"../AccountViewer"
	var save_file = File.new()
	save_file.open("user://" + SelectedCategory + "/" + AccFiles[User], File.READ)
	var result_json = JSON.parse(save_file.get_as_text())
	var result = {}
	if result_json.error == OK:
		var data = result_json.result
		viewer.account_data = data
	else:
		print("Error: ", result_json.error)
		print("Error Line: ", result_json.error_line)
		print("Error String: ", result_json.error_string)
	save_file.close()

func load_settings():
	creator = $"../AccountCreator"
	var save_file = File.new()
	save_file.open("user://settings.cfg", File.READ)
	var result_json = JSON.parse(save_file.get_as_text())
	var result = {}
	if result_json.error == OK:
		var data = result_json.result
		creator.Settings = data
		Background.texture = set_background(creator.Settings.Wallpaper[0])
	else:
		print("Error: ", result_json.error)
		print("Error Line: ", result_json.error_line)
		print("Error String: ", result_json.error_string)
	save_file.close()

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
	pass


func _on_TextureButton_pressed():
	OS.shell_open("https://neofrags.itch.io/offpass-manager")
	pass
