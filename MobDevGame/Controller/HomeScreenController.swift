// Import the UIKit framework which is crucial for designing and managing the user interface in iOS apps.
import UIKit

// Define a class `HomeScreenController` that inherits from `UIViewController`.
// `UIViewController` manages a view, typically the screen you see in an app.
class HomeScreenController: UIViewController {
    
    // MARK: - Outlets
    
    // Outlet for the play button on the home screen.
    @IBOutlet weak var playButton: UIButton! {
        didSet {
            // This block will run immediately after the play button is connected to the IBOutlet.
            // Set the corner radius of the play button to make it circular based on its height.
            self.playButton.layer.cornerRadius = self.playButton.frame.height / 2
        }
    }
    
    // MARK: - Lifecycle Methods
    
    // Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        // This function is typically used for additional setup, although it's empty in this case.
    }
    
    // MARK: - Actions
    
    // Action triggered when the play button is clicked.
    @IBAction func onClickPlay(_ sender: Any) {
        // Safely unwrap the view controller identified by "GameScreenController" from the storyboard.
        // Use 'guard let' to attempt to instantiate `GameScreenController`. If nil, exit this function.
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "GameScreenController") as? GameScreenController else { return }
        
        // If instantiation is successful, push the view controller onto the navigation controller's stack.
        // This changes the screen to show the `GameScreenController`.
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

