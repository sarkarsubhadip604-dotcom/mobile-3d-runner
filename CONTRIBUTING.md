# Contributing to Mobile 3D Runner

We welcome contributions from the community! This guide will help you get started.

## Getting Started

### Prerequisites
- Godot 4.4 or later
- Basic knowledge of GDScript
- Git and GitHub account
- Android development environment (for mobile testing)

### Setting Up Development Environment

1. **Fork the Repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/mobile-3d-runner.git
   cd mobile-3d-runner
   ```

2. **Open in Godot**
   - Launch Godot 4.4+
   - Import the project
   - Ensure all scenes load correctly

3. **Test the Game**
   - Run the main scene
   - Verify controls work
   - Test on mobile device if possible

## How to Contribute

### Reporting Bugs

1. **Check Existing Issues**
   - Search for similar bug reports
   - Add to existing issues if relevant

2. **Create Detailed Bug Reports**
   - Use the bug report template
   - Include steps to reproduce
   - Specify device/platform information
   - Attach screenshots or videos if helpful

### Suggesting Features

1. **Feature Request Process**
   - Check the roadmap for planned features
   - Open a new issue with the "enhancement" label
   - Describe the feature and its benefits
   - Discuss implementation approaches

### Code Contributions

1. **Before You Start**
   - Comment on the issue you want to work on
   - Wait for maintainer approval
   - Fork the repository

2. **Development Workflow**
   ```bash
   # Create a feature branch
   git checkout -b feature/your-feature-name
   
   # Make your changes
   # Test thoroughly
   
   # Commit with descriptive messages
   git commit -m "Add feature: description of changes"
   
   # Push to your fork
   git push origin feature/your-feature-name
   
   # Create a pull request
   ```

3. **Code Guidelines**

#### GDScript Style Guide

```gdscript
# Use snake_case for variables and functions
var player_speed = 5.0
var is_mobile_device = false

# Use PascalCase for classes and scenes
class_name PlayerController

# Add type hints
func move_player(direction: Vector3) -> void:
    pass

# Comment complex logic
# Calculate spawn position based on player location
var spawn_pos = player.global_position + Vector3(0, 0, -20)

# Use meaningful variable names
var obstacle_spawn_timer = 0.0  # Better than 't' or 'timer'

# Group related variables
# Movement settings
@export var speed = 5.0
@export var jump_velocity = 8.0
@export var move_speed = 3.0

# Audio references
@onready var jump_sound = $JumpSound
@onready var collect_sound = $CollectSound
```

#### File Organization

```
scripts/
├── managers/          # Global managers (GameManager, AudioManager)
├── player/           # Player-related scripts
├── environment/      # Environment and world objects
├── ui/              # User interface scripts
└── utilities/       # Helper functions and utilities
```

### Testing Guidelines

1. **Manual Testing**
   - Test on desktop first
   - Export and test on Android device
   - Verify touch controls work properly
   - Check performance on lower-end devices

2. **Automated Testing**
   ```gdscript
   # Example test function
   func test_player_movement():
       var player = preload("res://scenes/Player.tscn").instantiate()
       add_child(player)
       
       # Test movement input
       Input.action_press("move_right")
       player._physics_process(0.016)  # Simulate one frame
       
       assert(player.velocity.x > 0, "Player should move right")
       
       player.queue_free()
   ```

### Asset Contributions

1. **3D Models**
   - Use Blender or other free 3D software
   - Keep polygon count low (< 1000 for most objects)
   - Export as .glb or .fbx format
   - Include proper UV mapping

2. **Textures**
   - Maximum 1024x1024 for most textures
   - Use power-of-2 dimensions
   - Provide diffuse, normal, and roughness maps
   - Save in PNG or JPG format

3. **Audio**
   - Use OGG Vorbis format
   - Keep sound effects under 5 seconds
   - Normalize audio levels
   - Provide both stereo and mono versions

### Documentation

1. **Code Documentation**
   - Document all public functions
   - Explain complex algorithms
   - Update README when adding features

2. **User Documentation**
   - Update user guides for new features
   - Provide screenshots for UI changes
   - Keep installation instructions current

## Pull Request Process

### Before Submitting

1. **Code Quality Checklist**
   - [ ] Code follows style guidelines
   - [ ] All functions have type hints
   - [ ] Complex logic is commented
   - [ ] No debugging code left in
   - [ ] Performance impact considered

2. **Testing Checklist**
   - [ ] Feature works on desktop
   - [ ] Feature works on mobile
   - [ ] No new bugs introduced
   - [ ] Performance is acceptable
   - [ ] Memory usage is reasonable

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Performance improvement
- [ ] Documentation update

## Testing
- [ ] Tested on desktop
- [ ] Tested on Android
- [ ] Tested on iOS (if applicable)

## Screenshots/Videos
(If applicable)

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
```

### Review Process

1. **Automatic Checks**
   - Code style validation
   - Build verification
   - Basic functionality tests

2. **Manual Review**
   - Code quality assessment
   - Feature functionality review
   - Performance impact evaluation
   - Documentation completeness

3. **Approval and Merge**
   - At least one maintainer approval required
   - All checks must pass
   - Merge to main branch

## Community Guidelines

### Communication

1. **Be Respectful**
   - Treat all contributors with respect
   - Provide constructive feedback
   - Help newcomers learn

2. **Stay On Topic**
   - Keep discussions relevant
   - Use appropriate channels
   - Search before asking questions

### Recognition

We recognize contributors through:
- GitHub contributor stats
- Special mentions in release notes
- Community spotlight posts
- Contributor badge system

### Getting Help

- **Discord**: [Join our Discord server]
- **Forums**: [Godot Community Forums]
- **Issues**: Use GitHub issues for bugs/features
- **Discussions**: Use GitHub discussions for questions

## Development Resources

### Learning Materials
- [Godot Documentation](https://docs.godotengine.org/)
- [GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- [Mobile Development Guide](docs/MOBILE_OPTIMIZATION.md)

### Tools
- [Godot Engine](https://godotengine.org/)
- [Android Studio](https://developer.android.com/studio)
- [Blender](https://www.blender.org/) (for 3D assets)
- [GIMP](https://www.gimp.org/) (for textures)

Thank you for contributing to Mobile 3D Runner! 🚀