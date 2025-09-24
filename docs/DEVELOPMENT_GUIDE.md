# Development Guide for Mobile 3D Runner

## Getting Started

### Prerequisites
- Godot 4.4 or later
- Android Studio (for Android export)
- Xcode (for iOS export, macOS only)

### Project Setup
1. Clone this repository
2. Open the project in Godot 4.4+
3. Install export templates via Project → Export → Manage Export Templates
4. Configure export presets for your target platforms

## Mobile Development Best Practices

### Performance Optimization
- **Use Mobile Renderer**: The project is configured to use the mobile-optimized renderer
- **Limit Draw Calls**: Batch similar objects to reduce draw calls
- **Optimize Textures**: Use ASTC compression for Android, PVRTC for iOS
- **LOD System**: Implement level-of-detail for distant objects
- **Culling**: Objects outside camera view are automatically culled

### Touch Controls Implementation
- TouchScreenButton nodes for on-screen controls
- Gesture detection for swipe-based movement
- Accelerometer support for tilt controls
- Haptic feedback for better user experience

### Screen Size Adaptation
- Viewport size: 480x854 (9:16 aspect ratio)
- Stretch mode: canvas_items with keep aspect
- Responsive UI scaling
- Safe area handling for notched displays

## Architecture Overview

### Scene Structure
```
Main (Node3D)
├── Environment/
│   ├── DirectionalLight3D
│   ├── WorldEnvironment
│   └── Ground/
├── Player (CharacterBody3D)/
│   ├── PlayerMesh
│   ├── PlayerCollision
│   └── Camera3D
└── GameUI (CanvasLayer)/
    └── Control/
        ├── ScoreLabel
        └── TouchControls/
```

### Script Organization
- **Main.gd**: Game loop, spawning logic, score management
- **Player.gd**: Player movement, input handling, mobile optimization
- **Obstacle.gd**: Obstacle behavior and collision
- **Collectible.gd**: Collectible items and scoring
- **GameManager.gd**: Global state, save/load system

## Mobile Export Configuration

### Android Export
1. Install OpenJDK 17
2. Install Android Studio and SDK
3. Configure paths in Editor Settings
4. Create debug keystore
5. Set up export preset with:
   - Target SDK: 34
   - Min SDK: 21
   - Architecture: arm64-v8a

### iOS Export
1. Install Xcode (macOS required)
2. Configure iOS export preset
3. Set up provisioning profiles
4. Configure bundle identifier

## Adding New Features

### Creating New Obstacles
1. Duplicate `scenes/Obstacle.tscn`
2. Modify mesh and collision shape
3. Adjust script behavior in `scripts/Obstacle.gd`
4. Add to spawn pool in `scripts/Main.gd`

### Implementing Power-ups
1. Create new scene inheriting from Area3D
2. Add visual effects and animation
3. Implement collection logic
4. Add to player behavior

### Audio Integration
1. Import audio files to `assets/audio/`
2. Add AudioStreamPlayer nodes to scenes
3. Trigger sounds via script
4. Implement audio settings

## Testing on Mobile

### Device Testing
1. Enable Developer Options on Android device
2. Enable USB Debugging
3. Connect device via USB
4. Use "Remote Debug" or "One-Click Deploy"

### Performance Profiling
1. Enable Remote Profiler
2. Monitor FPS, memory usage, draw calls
3. Use Godot's built-in profiler
4. Test on various device specifications

## Common Issues and Solutions

### Performance Issues
- **Problem**: Low FPS on mobile devices
- **Solution**: Reduce polygon count, optimize textures, use mobile renderer

### Input Problems
- **Problem**: Touch controls not responsive
- **Solution**: Check TouchScreenButton collision shapes and input actions

### Export Errors
- **Problem**: Android export fails
- **Solution**: Verify JDK and Android SDK paths, check keystore configuration

## Contributing

1. Fork the repository
2. Create feature branch
3. Follow existing code style
4. Test on mobile devices
5. Submit pull request with detailed description

## Resources

- [Godot Mobile Development](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html)
- [Mobile Performance Tips](https://docs.godotengine.org/en/stable/tutorials/performance/general_optimization.html)
- [Touch Input Handling](https://docs.godotengine.org/en/stable/tutorials/inputs/input_examples.html)