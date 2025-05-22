// Import UIKit, the core component for user interface operations in iOS applications.
import UIKit
// Import SpriteKit, Apple's framework for 2D game development.
import SpriteKit

// Define a new class `GameScreenController` that inherits from `UIViewController`.
class GameScreenController: UIViewController {
    
    // Override the `loadView` method to customize the main view of the view controller.
    override func loadView() {
        // Set the main view of the view controller to an instance of `SKView`, which is the view used to display SpriteKit content.
        // The view occupies the entire screen's bounds.
        self.view = SKView(frame: UIScreen.main.bounds)
    }
    
    // Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a new `GameScene` with the same size as the view's bounds.
        let scene = GameScene(size: view.bounds.size)
        // Cast the view controller's main view to an SKView.
        let skView = view as! SKView
        // Set the scale mode of the scene to `resizeFill`, which causes the scene to scale to fill the SKView entirely.
        scene.scaleMode = .resizeFill
        // Present the scene within the SKView.
        skView.presentScene(scene)
    }
    
    // Called just before the view controller's view is added to a view hierarchy.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar when the view appears. This is common in games to use the full screen.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

