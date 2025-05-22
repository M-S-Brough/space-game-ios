// Import SpriteKit for access to SpriteKit classes and functionalities.
import SpriteKit

// Define a class named `Planet` which inherits from `SKSpriteNode`.
class Planet: SKSpriteNode {
    
    // Properties of the planet.
    var fact: String  // A fact about the planet.
    var image: SKTexture  // The texture representing the planet.
    
    // Custom initializer to create a planet object.
    init(imageNamed name: String, size: CGSize, fact: String) {
        self.fact = fact
        self.image = SKTexture(imageNamed: name)
        // Call the designated initializer of the superclass (`SKSpriteNode`).
        super.init(texture: self.image, color: .clear, size: size)
        self.name = name
        // Set up physics properties for the planet.
        setupPhysics()
    }
    
    // Required initializer when subclassing with custom initializers.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Private method to set up physics properties for the planet.
    private func setupPhysics() {
        // Create a physics body for the planet using its texture and size.
        physicsBody = SKPhysicsBody(texture: self.image, size: size)
        // Assign a category bitmask to the planet to identify it for collisions.
        physicsBody?.categoryBitMask = CollisionType.planet.rawValue
        // Define which categories of physics bodies this planet will collide with.
        physicsBody?.collisionBitMask = 0  // Planets do not need to collide with each other.
        // Define which categories of physics bodies will trigger contact events with this planet.
        physicsBody?.contactTestBitMask = CollisionType.spaceship.rawValue
        // Set whether the planet is dynamic (movable) in response to physics simulations.
        physicsBody?.isDynamic = false  // Planets do not move in response to physics.
    }
    
    // Method to make the planet start moving back and forth horizontally.
    func startMoving(leftEndPoint: CGFloat, rightEndPoint: CGFloat) {
        // Create an action that moves the planet to the left end point.
        let moveLeft = SKAction.moveTo(x: leftEndPoint, duration: Double(arc4random_uniform(5) + 5))
        let waitLeft = SKAction.wait(forDuration: 1.0) // A short wait before moving back.
        
        // Create an action that moves the planet to the right end point.
        let moveRight = SKAction.moveTo(x: rightEndPoint, duration: Double(arc4random_uniform(5) + 5))
        let waitRight = SKAction.wait(forDuration: 1.0) // A short wait before moving back.
        
        // Combine the actions into a sequence that moves left, then right, then repeat.
        let moveSequence = SKAction.sequence([moveLeft, waitLeft, moveRight, waitRight])
        let repeatAction = SKAction.repeatForever(moveSequence)
        
        // Run the repeating movement action on the planet.
        run(repeatAction)
    }
}

