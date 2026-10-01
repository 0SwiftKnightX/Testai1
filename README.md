# TESTAI1 — XR Foundation

Target: Godot 4.7.2, Meta Quest 3S, Android, OpenXR.

TESTAI1 is being built as a reusable XR foundation rather than a disposable demo. The sample room is intentionally small, but the runtime architecture is organized so future systems can consume the foundation without replacing it.

## Foundation currently implemented

- OpenXR startup and session lifecycle reporting.
- XROrigin3D, XRCamera3D, and left/right XRController3D player rig.
- CharacterBody3D player body and collision.
- OpenXR action map with Oculus Touch controller bindings.
- Smooth locomotion from the left thumbstick.
- Snap turning from the right thumbstick.
- Ray selection, proximity fallback, grab, hold, and release for physics interactables.
- XR capability diagnostics.
- Mobile renderer and XR shader configuration.
- Runtime detection of OpenXR hand trackers.
- Explicit ownership boundaries between engine XR and project-owned systems.

## Architecture boundary

Godot/OpenXR owns engine-level XR.

OpenXR Vendors owns optional vendor extensions when the addon is installed and verified for the target engine.

GXDK/XR Tools 2 is treated as an optional higher-level framework while its current source remains pre-release. TESTAI1 does not copy the external repository or create duplicate systems merely to imitate it. A verified adapter can be added later if the exact release/API is suitable.

TESTAI1 owns the project-level player, locomotion, interaction, diagnostics, and future service contracts.

## Sample acceptance path

1. Import with Godot 4.7.2.
2. Validate project settings and resources.
3. Start OpenXR.
4. Confirm stereo HMD tracking.
5. Confirm left/right controller tracking.
6. Confirm left-stick locomotion.
7. Confirm right-stick snap turning.
8. Confirm trigger grab and release on sample objects.
9. Confirm diagnostics.
10. Export Android ARM64.
11. Verify on physical Quest 3S.

A desktop launch is not Quest acceptance evidence.

## Verification status

DESIGN: COMPLETE

IMPLEMENTED: COMPLETE

STATIC VERIFIED: PENDING Godot 4.7.2 runtime validation

BUILD VERIFIED: PENDING Android export

RUNTIME VERIFIED: PENDING runtime evidence

QUEST VERIFIED: PENDING physical Quest 3S evidence

ACCEPTED: NOT YET CLAIMED
