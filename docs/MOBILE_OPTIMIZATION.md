# Mobile Optimization Guidelines

## Rendering Optimizations

### Renderer Configuration
```gdscript
# project.godot settings
renderer/rendering_method="mobile"
renderer/rendering_method.mobile="gl_compatibility"
```

### Texture Optimization
- Use ASTC compression for Android
- Use PVRTC compression for iOS
- Keep texture sizes power of 2
- Use mipmaps for distant objects
- Compress textures aggressively for UI elements

### Geometry Optimization
- Keep polygon count low (< 10k triangles on screen)
- Use LOD (Level of Detail) systems
- Implement frustum culling
- Batch similar objects to reduce draw calls

## Performance Monitoring

### Key Metrics to Watch
- **FPS**: Target 60fps, minimum 30fps
- **Memory Usage**: Keep under 2GB for compatibility
- **Draw Calls**: Minimize to < 100 per frame
- **Battery Usage**: Optimize for longer play sessions

### Profiling Tools
```gdscript
# Enable performance monitoring
func _ready():
    if OS.is_debug_build():
        get_tree().set_debug_collisions_hint(true)
        get_tree().set_debug_navigation_hint(true)
```

## Input Optimization

### Touch Input Best Practices
- Use large touch targets (minimum 44px)
- Implement gesture recognition
- Add visual feedback for touches
- Support multi-touch where appropriate

### Accelerometer Integration
```gdscript
func get_tilt_input() -> Vector2:
    var accel = Input.get_accelerometer()
    # Filter small movements to avoid jitter
    if abs(accel.x) < 0.1:
        accel.x = 0
    return Vector2(-accel.x, 0) # Invert X for natural movement
```

## Memory Management

### Object Pooling
```gdscript
class_name ObjectPool

var pool = []
var scene_template: PackedScene

func get_object():
    if pool.is_empty():
        return scene_template.instantiate()
    return pool.pop_back()

func return_object(obj):
    obj.reset() # Custom reset function
    pool.append(obj)
```

### Automatic Cleanup
```gdscript
func _process(delta):
    # Remove objects that are far from player
    for child in get_children():
        if child.global_position.distance_to(player.global_position) > 50:
            child.queue_free()
```

## UI Optimization

### Responsive Design
- Use anchor-based layouts
- Implement safe area handling
- Scale UI elements based on screen density

### Canvas Layer Management
```gdscript
# Separate UI layers for better performance
GameUI (CanvasLayer, layer = 1)
MenuUI (CanvasLayer, layer = 2)
DebugUI (CanvasLayer, layer = 99)
```

## Audio Optimization

### Audio Settings
- Use OGG Vorbis for music (smaller files)
- Use WAV for short sound effects
- Implement audio streaming for long tracks
- Add audio quality settings

### Dynamic Audio Loading
```gdscript
func load_audio_on_demand(audio_path: String):
    if not audio_cache.has(audio_path):
        var stream = load(audio_path)
        audio_cache[audio_path] = stream
    return audio_cache[audio_path]
```

## Platform-Specific Optimizations

### Android Optimizations
- Use Vulkan on high-end devices
- Implement Android-specific input handling
- Optimize for various screen densities
- Handle Android lifecycle events

### iOS Optimizations
- Use Metal renderer when available
- Implement iOS-specific gestures
- Handle interruptions (calls, notifications)
- Optimize for various iPhone/iPad sizes

## Battery Life Optimization

### Reduce CPU Usage
```gdscript
# Use delta time appropriately
func _process(delta):
    # Heavy calculations only when necessary
    if frame_count % 60 == 0:  # Once per second at 60fps
        update_heavy_calculation()
```

### GPU Optimization
- Reduce shader complexity
- Use simple lighting models
- Avoid transparent overdraw
- Implement automatic quality reduction

## Testing Checklist

### Performance Testing
- [ ] Test on low-end devices
- [ ] Monitor temperature during play
- [ ] Check battery drain over time
- [ ] Verify smooth 60fps gameplay
- [ ] Test with airplane mode (offline)

### Compatibility Testing
- [ ] Test on different screen sizes
- [ ] Verify touch controls work correctly
- [ ] Test rotation handling
- [ ] Check memory usage on extended play
- [ ] Verify save/load functionality

## Automated Optimization

### Build Settings
```gdscript
# export_presets.cfg optimizations
graphics/32_bits_framebuffer=false
screen/immersive_mode=true
architectures/arm64-v8a=true  # 64-bit only for better performance
```

### Quality Presets
```gdscript
class_name QualityManager

enum Quality { LOW, MEDIUM, HIGH }

func set_quality(quality: Quality):
    match quality:
        Quality.LOW:
            get_viewport().msaa_3d = Viewport.MSAA_DISABLED
            get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_DISABLED
        Quality.MEDIUM:
            get_viewport().msaa_3d = Viewport.MSAA_2X
        Quality.HIGH:
            get_viewport().msaa_3d = Viewport.MSAA_4X
```