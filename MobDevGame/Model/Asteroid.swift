// Import SpriteKit for access to SpriteKit classes and functionalities.
import SpriteKit

// Define a class named `Asteroid` which inherits from `SKSpriteNode`.
class Asteroid: SKSpriteNode {
    
    // Custom initializer to create an asteroid object.
    init(size: CGSize, imageNamed: String = "asteroid.png") {
        // Load the texture for the asteroid.
        let texture = SKTexture(imageNamed: imageNamed)
        // Call the designated initializer of the superclass (`SKSpriteNode`).
        super.init(texture: texture, color: .clear, size: size)
        // Set up physics properties for the asteroid.
        setupPhysics()
    }
    
    // Required initializer when subclassing with custom initializers.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Private method to set up physics properties for the asteroid.
    private func setupPhysics() {
        // Create a physics body for the asteroid using its texture and size.
        physicsBody = SKPhysicsBody(texture: texture!, size: size)
        // Assign a category bitmask to the asteroid to identify it for collisions.
        physicsBody?.categoryBitMask = CollisionType.asteroid.rawValue
        // Define which categories of physics bodies this asteroid will collide with.
        physicsBody?.collisionBitMask = CollisionType.spaceship.rawValue
        // Define which categories of physics bodies will trigger contact events with this asteroid.
        physicsBody?.contactTestBitMask = CollisionType.spaceship.rawValue
        // Set whether the asteroid is dynamic (movable) in response to physics simulations.
        physicsBody?.isDynamic = true
        // Set whether the asteroid is affected by gravity (assumed to be false for an asteroid).
        physicsBody?.affectedByGravity = false
    }
}

