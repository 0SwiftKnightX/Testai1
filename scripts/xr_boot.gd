extends Node
class_name TESTAI1XRBoot

signal xr_state_changed(state: String, detail: String)

var xr_interface: XRInterface
var state := "starting"
var detail := "Waiting for OpenXR"

func _ready() -> void:
    xr_interface = XRServer.find_interface("OpenXR")
    if xr_interface == null:
        _set_state("error", "OpenXR interface was not registered.")
        return

    if not xr_interface.is_initialized():
        _set_state("error", "OpenXR is enabled but was not initialized at startup.")
        return

    get_viewport().use_xr = true
    DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

    xr_interface.session_begun.connect(_on_session_begun)
    xr_interface.session_visible.connect(_on_session_visible)
    xr_interface.session_focussed.connect(_on_session_focused)
    xr_interface.session_stopping.connect(_on_session_stopping)
    xr_interface.pose_recentered.connect(_on_pose_recentered)

    _set_state("initialized", "OpenXR initialized.")
    _emit_capability_report()

func _emit_capability_report() -> void:
    var hand_left := XRServer.get_tracker("/user/hand_tracker/left")
    var hand_right := XRServer.get_tracker("/user/hand_tracker/right")
    print("TESTAI1 XR capabilities: ", {
        "openxr": xr_interface != null and xr_interface.is_initialized(),
        "left_hand_tracker": hand_left != null,
        "right_hand_tracker": hand_right != null,
        "engine": Engine.get_version_info().string
    })

func _set_state(new_state: String, new_detail: String) -> void:
    state = new_state
    detail = new_detail
    print("TESTAI1 XR state: ", state, " — ", detail)
    xr_state_changed.emit(state, detail)

func _on_session_begun() -> void:
    _set_state("running", "OpenXR session begun.")

func _on_session_visible() -> void:
    _set_state("visible", "OpenXR session visible.")

func _on_session_focused() -> void:
    _set_state("focused", "OpenXR session focused.")

func _on_session_stopping() -> void:
    _set_state("stopping", "OpenXR session stopping.")

func _on_pose_recentered() -> void:
    print("TESTAI1 XR pose recentered.")
