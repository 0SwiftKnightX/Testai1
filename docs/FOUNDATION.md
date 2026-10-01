# TESTAI1 XR Foundation Contract

## Ownership

| Layer | Owner |
|---|---|
| XR runtime and interface | Godot OpenXR |
| Vendor extensions | OpenXR Vendors when installed and verified |
| Higher-level XR framework | GXDK / XR Tools 2 only when a verified release is suitable |
| Player, locomotion, interaction, diagnostics | TESTAI1 |
| Gameplay | Future TESTAI1 systems |

## Foundation domains

### Runtime
OpenXR is enabled at startup. The boot service verifies the OpenXR interface, enables XR rendering, and exposes session lifecycle state.

### Player
The player is a CharacterBody3D with XROrigin3D, XRCamera3D, and left/right XRController3D children. The player owns collision, locomotion, and snap turning.

### Input
The project has a dedicated OpenXRActionMap resource. The runtime consumes named actions rather than vendor-specific button APIs.

### Interaction
The interaction service supports controller ray selection, proximity fallback, grab, hold, and release for RigidBody3D objects in the xr_grabbable group.

### Presentation
The sample uses lightweight tracked controller markers and a world-space diagnostic label. Production hand meshes and UI can be substituted without changing player ownership.

### Spatial and platform capabilities
Capability detection is centralized. Hand trackers and body trackers are detected through XRServer. Vendor-only features are not claimed until the corresponding extension is installed and verified on the target device.

### Performance
The project uses the Godot Mobile renderer and a 90 Hz physics tick target. Additional Quest-specific performance instrumentation is a later verification layer, not a fabricated acceptance claim.

## GXDK position

The supplied research identified GXDK/XR Tools 2 as the intended higher-level framework direction. Current official source material also states that it is still under active development, has not reached feature parity with XR Tools, has no stable releases, and is not production-ready.

Therefore TESTAI1 does not make an unverified GXDK API a hard runtime dependency. The project-owned foundation follows the verified Godot 4.7 OpenXR contract and leaves a clean integration boundary for GXDK once an appropriate release is verified.

## Verification states

DESIGN -> IMPLEMENTED -> STATIC VERIFIED -> BUILD VERIFIED -> RUNTIME VERIFIED -> QUEST VERIFIED -> ACCEPTED

No later state may be claimed without evidence.
