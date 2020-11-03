extends Control

var player:Node2D = null
var text:Label = null

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $"../Player"
	text = $Panel/Label

func _process(_delta):
	text.text = "State: " + str(player.my_state) + "\nLast anim: " + player.anim.assigned_animation
