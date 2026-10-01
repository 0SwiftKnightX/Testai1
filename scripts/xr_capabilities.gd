extends Node
class_name TESTAI1XRCapabilities

signal capabilities_changed(capabilities: Dictionary)

var capabilities: Dictionary = {}

func _ready() -> void:
    _refresh()

func _process(_delta: float) -> void:
    _refresh()

func _refresh() -> void:
    var xr := XRServer.primary_interface
    var next := {
        "openxr_available": XRServer.find_interface("OpenXR") != null,
        "openxr_initialized": xr != null and xr.is_initialized(),
        "left_controller": XRServer.get_tracker("left_hand") != null,
        "right_controller": XRServer.get_tracker("right_hand") != null,
        "left_optical_hand": XRServer.get_tracker("/user/hand_tracker/left") != null,
        "right_optical_hand": XRServer.get_tracker("/user/hand_tracker/right") != null,
        "body_tracker": XRServer.get_tracker("/user/body_tracker") != null
    }

    if next != capabilities:
        capabilities = next
        capabilities_changed.emit(capabilities)
