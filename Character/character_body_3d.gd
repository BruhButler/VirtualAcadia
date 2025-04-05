extends CharacterBody3D


const SPEED = 15.0
const JUMP_VELOCITY = 4.5



@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var skin := $Sketchfab_Scene
@onready var anim_player := $Sketchfab_Scene/AnimationPlayer

func _ready():
	SimpleGrass.set_interactive(true)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	
	SimpleGrass.set_player_position(global_position)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction.length() > 0:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		skin.rotation.y = lerp_angle(skin.rotation.y, atan2(direction.x, direction.z), 0.1)  # Rotate skin with movement
		
		if anim_player.current_animation != "Runing":
			anim_player.play("Runing", 0.2)  # Play running animation
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
		if anim_player.current_animation != "idle":
			anim_player.play("idle", 0.2)  # Play idle animation when not moving  # Rotate to face movement direction
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
