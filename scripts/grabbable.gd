extends RigidBody3D
class_name TESTAI1Grabbable

@export var interaction_id := "sample_object"

func _ready() -> void:
    add_to_group("xr_grabbable")
