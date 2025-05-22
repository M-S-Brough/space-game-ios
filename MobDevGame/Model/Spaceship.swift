// Import SpriteKit for access to SpriteKit classes and functionalities.
import SpriteKit

// Define a class named `Spaceship` which inherits from `SKSpriteNode`.
class Spaceship: SKSpriteNode {
    
    // Initializer method for creating a spaceship object.
    init() {
        // Load the texture for the spaceship.
        let texture = SKTexture(imageNamed: "spaceship.png")
        // Set the size of the spaceship.
        let size = CGSize(width: 25, height: 50) // Set the original size
        // Call the designated initializer of the superclass (`SKSpriteNode`).
        super.init(texture: texture, color: .clear, size: size)
        // Set the name of the spaceship node.
        self.name = "player"
        // Set the z-position of the spaceship to render it above other nodes.
        self.zPosition = 1
        // Configure physics properties for the spaceship.
        setupPhysics()
    }
    
    // Required initializer when subclassing with custom initializers.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Private method to set up physics properties for the spaceship.
    private func setupPhysics() {
        // Create a physics body for the spaceship using its texture and size.
        physicsBody = SKPhysicsBody(texture: texture!, size: size)
        // Assign a category bitmask to the spaceship to identify it for collisions.
        physicsBody?.categoryBitMask = CollisionType.spaceship.rawValue
        // Define which categories of physics bodies this spaceship will collide with.
        physicsBody?.collisionBitMask = CollisionType.planet.rawValue | CollisionType.asteroid.rawValue
        // Define which categories of physics bodies will trigger contact events with this spaceship.
        physicsBody?.contactTestBitMask = CollisionType.planet.rawValue | CollisionType.asteroid.rawValue
        // Allow the spaceship to be moved by physics simulations.
        physicsBody?.isDynamic = true
        // Set whether the spaceship is affected by gravity (assumed to be false for a spaceship).
        physicsBody?.affectedByGravity = false
        // Allow the spaceship to rotate upon collisions.
        physicsBody?.allowsRotation = true
    }
}
