extends Node3D
class_name TESTAI1XRInteraction

@export var ray_length := 8.0
@export var grab_distance := 1.5
@export var grab_action := "trigger_click"

@onready var left_hand: XRController3D = $"../XRPlayer/XROrigin3D/LeftHand"
@onready var right_hand: XRController3D = $"../XRPlayer/XROrigin3D/RightHand"

var _held_left: RigidBody3D
var _held_right: RigidBody3D

func _physics_process(_delta: float) -> void:
    _process_hand(left_hand, true)
    _process_hand(right_hand, false)

func _process_hand(hand: XRController3D, left: bool) -> void:
    var held: RigidBody3D = _held_left if left else _held_right
    var pressed := hand.is_button_pressed(grab_action)

    if pressed and held == null:
        held = _try_grab(hand)
        if left:
            _held_left = held
        else:
            _held_right = held
        if held:
            hand.trigger_haptic_pulse("haptic", 0.0, 0.55, 0.08, 0.0)
    elif not pressed and held != null:
        held.freeze = false
        held.linear_velocity = Vector3.ZERO
        held.angular_velocity = Vector3.ZERO
        hand.trigger_haptic_pulse("haptic", 0.0, 0.35, 0.05, 0.0)
        if left:
            _held_left = null
        else:
            _held_right = null

    if held:
        held.global_transform = hand.global_transform

func _try_grab(hand: XRController3D) -> RigidBody3D:
    var space := get_world_3d().direct_space_state
    var origin := hand.global_position
    var target := origin + (-hand.global_transform.basis.z * ray_length)
    var query := PhysicsRayQueryParameters3D.create(origin, target)
    query.collision_mask = 4
    query.collide_with_areas = false
    query.collide_with_bodies = true

    var hit := space.intersect_ray(query)
    if not hit.is_empty():
        var body := hit.get("collider") as RigidBody3D
        if body and body.is_in_group("xr_grabbable"):
            body.freeze = true
            return body

    return _find_nearby(origin)

func _find_nearby(position: Vector3) -> RigidBody3D:
    var best: RigidBody3D
    var best_distance := grab_distance

    for node in get_tree().get_nodes_in_group("xr_grabbable"):
        if node is RigidBody3D:
            var distance := position.distance_to(node.global_position)
            if distance <= best_distance:
                best = node
                best_distance = distance

    if best:
        best.freeze = true
    return best
