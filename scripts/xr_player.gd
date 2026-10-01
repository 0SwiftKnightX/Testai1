extends CharacterBody3D
class_name TESTAI1XRPlayer

@export var move_speed := 2.0
@export var snap_turn_degrees := 30.0
@export var snap_turn_deadzone := 0.65

@onready var camera: XRCamera3D = $XROrigin3D/XRCamera3D
@onready var left_hand: XRController3D = $XROrigin3D/LeftHand
@onready var right_hand: XRController3D = $XROrigin3D/RightHand

var _turn_ready := true

func _physics_process(delta: float) -> void:
    var left_input := left_hand.get_vector2("primary")
    var right_input := right_hand.get_vector2("primary")

    _apply_locomotion(left_input, delta)
    _apply_snap_turn(right_input.x)

    if not is_on_floor():
        velocity.y -= 9.8 * delta
    else:
        velocity.y = 0.0

    move_and_slide()

func _apply_locomotion(input: Vector2, delta: float) -> void:
    var magnitude := input.length()
    if magnitude < 0.15:
        velocity.x = move_toward(velocity.x, 0.0, move_speed * 6.0 * delta)
        velocity.z = move_toward(velocity.z, 0.0, move_speed * 6.0 * delta)
        return

    var forward := -camera.global_transform.basis.z
    var right := camera.global_transform.basis.x
    forward.y = 0.0
    right.y = 0.0
    forward = forward.normalized()
    right = right.normalized()

    var direction := right * input.x + forward * input.y
    direction.y = 0.0
    if direction.length_squared() > 1.0:
        direction = direction.normalized()

    var speed := move_speed * min(magnitude, 1.0)
    velocity.x = direction.x * speed
    velocity.z = direction.z * speed

func _apply_snap_turn(axis: float) -> void:
    if abs(axis) < snap_turn_deadzone:
        _turn_ready = true
        return
    if not _turn_ready:
        return

    rotate_y(deg_to_rad(-sign(axis) * snap_turn_degrees))
    _turn_ready = false
