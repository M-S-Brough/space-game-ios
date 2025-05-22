// Import SpriteKit for access to SpriteKit classes and functionalities.
import SpriteKit

// Define a class named `PopupNode` which inherits from `SKSpriteNode`.
class PopupNode: SKSpriteNode {
    
    // Custom initializer to create a popup node.
    init(message: String, image: SKTexture?) {
        // Call the designated initializer of the superclass (`SKSpriteNode`).
        // Set the color of the popup background to black with some transparency.
        super.init(texture: nil, color: .black, size: CGSize(width: 300, height: 250)) // Increased height to accommodate image
        // Enable user interaction with the popup node.
        self.isUserInteractionEnabled = true
        // Set the transparency level of the popup.
        self.alpha = 0.9

        // If an image is provided, create an image view node and add it to the popup node.
        if let image = image {
            let imageView = SKSpriteNode(texture: image)
            imageView.size = CGSize(width: 100, height: 100)
            imageView.position = CGPoint(x: 0, y: 50)
            addChild(imageView)
        }

        // Create a label node to display the message.
        let label = SKLabelNode(fontNamed: "Arial-BoldMT")
        label.text = message
        label.fontSize = 14
        label.fontColor = UIColor.white
        label.position = CGPoint(x: 0, y: -40) // Adjust position based on image
        label.zPosition = 1
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = 280
        addChild(label)

        // Create a close button node to allow the user to close the popup.
        let closeButton = SKSpriteNode(color: .red, size: CGSize(width: 30, height: 30))
        closeButton.position = CGPoint(x: 140, y: 110) // Adjusted for new layout
        closeButton.name = "closeButton"
        addChild(closeButton)
    }

    // Required initializer when subclassing with custom initializers.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Override the touchesBegan method to handle touch events.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Check if there is a touch event.
        guard let touch = touches.first else { return }
        // Get the location of the touch within the popup node.
        let location = touch.location(in: self)
        // Get the nodes at the touch location.
        let nodes = self.nodes(at: location)
        
        // Check if any of the nodes at the touch location have the name "closeButton".
        if nodes.contains(where: { $0.name == "closeButton" }) {
            // If the close button is touched, remove the popup node from its parent.
            self.removeFromParent()
        }
    }
}

