extends Node

var itemData: Dictionary

func _ready():
	itemData = LoadData("res://Data/ItemData.json")
	
func LoadData(filePath):
	var jsonData
	var fileData = File.new()
	
	fileData.open(filePath, File.READ)
	jsonData = JSON.parse(fileData.get_as_text())
	fileData.close()
	return jsonData.result
