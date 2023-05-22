extends StaticBody2D
var close
onready var emmitter = get_tree().get_root().get_node("Game").get_node("Stage").get_node("BossCue")

func _ready():
	emmitter.connect("rawr", self, "_on_Boss_rawr")
	
func _physics_process(_delta):
	var alive = get_tree().get_nodes_in_group("Enemy").size()
	if close == true:
		self.show()
		$CollisionShape2D.disabled = false
	else:
		if alive <= 4:
			self.hide()
			$CollisionShape2D.disabled = true
		
func _on_Boss_rawr():
	close = true
