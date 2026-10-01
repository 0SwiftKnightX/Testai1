extends Node3D
class_name TESTAI1FoundationDiagnostics

@onready var status_label: Label3D = $Status

func _ready() -> void:
    _refresh()

func _process(_delta: float) -> void:
    _refresh()

func _refresh() -> void:
    var xr := XRServer.primary_interface
    var xr_name := "none" if xr == null else xr.get_name()
    var initialized := false if xr == null else xr.is_initialized()
    var tracking := "unknown" if xr == null else str(xr.get_tracking_status())
    status_label.text = "TESTAI1 XR FOUNDATION\nXR: %s\nInitialized: %s\nTracking: %s\nGodot: %s" % [
        xr_name, initialized, tracking, Engine.get_version_info().string
    ]
