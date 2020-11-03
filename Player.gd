extends Node2D

var anim: AnimationPlayer = null

var my_state = state.ready

enum state {
	ready,
	punching,
	powerpunch,
	blocking,
	dodging_left,
	dodging_right,
	hit,
	hit_hard
}

var last_punch = null

# Called when the node enters the scene tree for the first time.
func _ready():
	anim = $AnimationPlayer

#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
	#print(event.as_text())
	if event is InputEventKey and my_state == state.ready:
		# to make this super pro, i'd want to add a command queue system
		# see word doc
		if event.is_action_pressed("punch"):
			# if the last punch was a jab, throw a straight
			if last_punch == "jab":
				straight()
			else:
				jab()
		if event.is_action_pressed("uppercut"):
			uppercut()
		if event.is_action_pressed("block"):
			block()
		if event.is_action_pressed("dodge_left"):
			dodge_left()
		if event.is_action_pressed("dodge_right"):
			dodge_right()
	
	if event is InputEventKey:
		if event.is_action_pressed("debug_get_hit"):
			get_hit()
		elif event.is_action_pressed("debug_get_hit_hard"):
			get_hit_hard()

func jab():
	anim.play("jab")
	my_state = state.punching
	last_punch = "jab"

func straight():
	anim.play("straight")
	my_state = state.punching
	last_punch = "straight"

func uppercut():
	anim.play("uppercut")
	my_state = state.powerpunch

func block():
	anim.play("block")
	my_state = state.blocking

func dodge_left():
	anim.play("dodge_left")
	my_state = state.dodging_left

func dodge_right():
	anim.play("dodge_right")
	my_state = state.dodging_right

func get_hit():
	if my_state == state.hit or my_state == state.hit_hard:
		return
	anim.play("get_hit")
	my_state = state.hit

func get_hit_hard():
	if my_state == state.hit or my_state == state.hit_hard:
		return
	anim.play("get_hit_hard")
	my_state = state.hit_hard

# When the current animation finishes, return to Ready state 
func _on_AnimationPlayer_animation_finished(_anim_name):
	my_state = state.ready
	if anim.assigned_animation != "ready":
		anim.play("ready")
