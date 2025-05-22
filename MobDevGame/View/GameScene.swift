import SpriteKit

// Define a custom category for collisions
enum CollisionType: UInt32 {
    case spaceship = 1
    case planet = 2
    case asteroid = 4
}

// GameScene class that conforms to SKScene and SKPhysicsContactDelegate protocols
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Properties for planet names, images, sun, and spaceship
    let planetNames = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
    let planetImages = ["mercury.png", "venus.png", "earth.png", "mars.png", "jupiter.png", "saturn.png", "uranus.png", "neptune.png"]
    let sun = SKSpriteNode(imageNamed: "sun.png")
    let spaceship = Spaceship()

    // Setup method called when the scene is presented
    override func didMove(to view: SKView) {
        setUpParticles()
        addSpaceship()
        spawnPlanets()
        spawnAsteroids()
        physicsWorld.contactDelegate = self
    }

    // Method to set up particle effects
    func setUpParticles() {
        if let particles = SKEmitterNode(fileNamed: "stars") {
            particles.position = CGPoint(x: 0, y: 0)
            particles.advanceSimulationTime(200)
            particles.zPosition = -1
            addChild(particles)
        }
    }

    // Method to add the spaceship to the scene
    func addSpaceship() {
        spaceship.position = CGPoint(x: frame.midX, y: frame.minY + 5)
        addChild(spaceship)
    }

    // Method to spawn planets in the scene
    func spawnPlanets() {
        let planetFacts = [
            "Mercury is the smallest planet in our solar system.",
            "Venus is the hottest planet in our solar system.",
            "Earth is the only planet known to support life.",
            "Mars is known as the red planet.",
            "Jupiter is the largest planet in our solar system.",
            "Saturn has the most beautiful ring system.",
            "Uranus rotates on its side.",
            "Neptune is known for its intense blue color."
        ]
        let planetSizes = [0.5, 0.75, 1.00, 0.5, 2, 1.75, 1.5, 1.25]
        let baseSize: CGFloat = 40

        let verticalSpacing = size.height / CGFloat(planetNames.count + 1)

        for (index, _) in planetNames.enumerated() {
            let scaleFactor = planetSizes[index]
            let planetSize = CGSize(width: baseSize * scaleFactor, height: baseSize * scaleFactor)
            let planet = Planet(imageNamed: planetImages[index], size: planetSize, fact: planetFacts[index])

            let yPosition = size.height - verticalSpacing * CGFloat(index + 1)
            let xPosition = CGFloat(arc4random_uniform(UInt32(size.width)))

            let leftEndPoint = planet.size.width / 2
            let rightEndPoint = size.width - planet.size.width / 2

            planet.position = CGPoint(x: xPosition, y: yPosition)
            planet.startMoving(leftEndPoint: leftEndPoint, rightEndPoint: rightEndPoint)
            addChild(planet)
        }
    }

    // Method to handle user touches and move the spaceship
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveSpaceship(to: touches)

        if let touch = touches.first,
           let _ = nodes(at: touch.location(in: self)).first(where: { $0.name == "nextButton" }) {
            goToQuizScreen()
        }
   }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveSpaceship(to: touches)
    }

    // Method to move the spaceship to the user's touch location
    private func moveSpaceship(to touches: Set<UITouch>) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)

        let moveAction = SKAction.move(to: touchLocation,duration: 0.1)
        moveAction.timingMode = .easeOut
        spaceship.run(moveAction)
    }

    // Method to handle collisions between objects
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody: SKPhysicsBody
        let secondBody: SKPhysicsBody

        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        // Handle collision between spaceship and asteroid
        if (firstBody.categoryBitMask == CollisionType.spaceship.rawValue && secondBody.categoryBitMask == CollisionType.asteroid.rawValue) ||
           (firstBody.categoryBitMask == CollisionType.asteroid.rawValue && secondBody.categoryBitMask == CollisionType.spaceship.rawValue) {
            handleCollisionBetweenSpaceshipAndAsteroid(spaceshipBody: firstBody.categoryBitMask == CollisionType.spaceship.rawValue ? firstBody : secondBody,
                                                       asteroidBody: firstBody.categoryBitMask == CollisionType.asteroid.rawValue ? firstBody : secondBody)
        }

        // Handle collision between spaceship and planet
        if (firstBody.categoryBitMask == CollisionType.spaceship.rawValue && secondBody.categoryBitMask == CollisionType.planet.rawValue) ||
           (firstBody.categoryBitMask == CollisionType.planet.rawValue && secondBody.categoryBitMask == CollisionType.spaceship.rawValue) {
            handleCollisionBetweenSpaceshipAndPlanet(spaceshipBody: firstBody.categoryBitMask == CollisionType.spaceship.rawValue ? firstBody : secondBody,
                                                     planetBody: firstBody.categoryBitMask == CollisionType.planet.rawValue ? firstBody : secondBody)
        }
    }

    // Method to handle collision between spaceship and planet
    private func handleCollisionBetweenSpaceshipAndPlanet(spaceshipBody: SKPhysicsBody, planetBody: SKPhysicsBody) {
        if let planet = planetBody.node as? Planet {
            let popup = PopupNode(message: planet.fact, image: planet.image)
            popup.position = CGPoint(x: frame.midX, y: frame.midY)
            addChild(popup)

            planet.removeFromParent()
            if children.compactMap({ $0 as? Planet }).isEmpty {
                showNextButton()
            }
        }
    }

    // Method to handle collision between spaceship and asteroid
    private func handleCollisionBetweenSpaceshipAndAsteroid(spaceshipBody: SKPhysicsBody, asteroidBody: SKPhysicsBody) {
        if let asteroid = asteroidBody.node as? SKSpriteNode {
            // Directly use the velocity without optional binding
            let velocity = asteroid.physicsBody?.velocity ?? CGVector(dx: 0, dy: 0)
            let impulseVector = CGVector(dx: velocity.dx * 0.5, dy: velocity.dy * 0.5)  // Adjust the impulse factor as needed

            spaceshipBody.applyImpulse(impulseVector)
            
        }
        // Additional effects or game logic following a collision
    }

    // Method to show the "Next" button on the screen
    func showNextButton() {
        let nextButton = SKSpriteNode(color: .blue, size: CGSize(width: 150, height: 50))
        nextButton.position = CGPoint(x: frame.midX,y: frame.midY)
        nextButton.name = "nextButton"

        let buttonText = SKLabelNode(text: "Go to Quiz")
        buttonText.fontName = "Arial-BoldMT"
        buttonText.fontSize = 20
        buttonText.fontColor = .white
        buttonText.position = CGPoint(x: 0, y: -10)
        nextButton.addChild(buttonText)

        addChild(nextButton)
    }

    // Method to present the quiz screen
    func goToQuizScreen() {
        if let view = self.view,
            let quizVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuizViewController") as? QuizViewController {
            view.window?.rootViewController?.present(quizVC, animated: true, completion: nil)
        }
    }

    // Method to spawn asteroids in the scene
    func spawnAsteroids() {
        let createAsteroidAction = SKAction.run {
            let asteroidSize = CGSize(width: 50, height: 50)
            let asteroid = Asteroid(size: asteroidSize)

            // Calculate random start position
            let randomX = CGFloat.random(in: 0...self.frame.width)
            asteroid.position = CGPoint(x: randomX, y: self.frame.height + asteroidSize.height / 2)

            // Define the falling action
            let moveDownAction = SKAction.moveBy(x: 0, y: -self.frame.height - asteroidSize.height, duration: 5)
            let removeAction = SKAction.removeFromParent()
            asteroid.run(SKAction.sequence([moveDownAction, removeAction]))
            
            self.addChild(asteroid)
        }

        // Spawn an asteroid every 2 seconds
        let spawnAction = SKAction.repeatForever(SKAction.sequence([createAsteroidAction, SKAction.wait(forDuration: 2)]))
        run(spawnAction)
    }

}
