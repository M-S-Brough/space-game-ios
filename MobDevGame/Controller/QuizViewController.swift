
import UIKit

class QuizViewController: UIViewController {
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var imageQuestion: UIImageView!
    
    @IBOutlet weak var textQuestion: UILabel!
    
    @IBOutlet weak var trueButton: UIButton!
    
    @IBOutlet weak var falseButton: UIButton!
    
    
    @IBAction func userAnswer(_ sender: UIButton) {
        let answer = sender.titleLabel?.text ?? "TRUE"
        let rightAnswer = brainQuiz.checkAnswer(userAnswer: answer)
        
        if rightAnswer {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
            
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }
        
        falseButton.isEnabled = false
        trueButton.isEnabled = false
        
        if brainQuiz.nextQuestion() {
            let alert = UIAlertController(title: "End of Quiz", message: "Do you want to try again?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
                self.brainQuiz.score = 0
                Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.changeQuestion), userInfo: nil, repeats: false)
                
            }
            let noAction = UIAlertAction(title: "No", style: .cancel) { _ in
            exit(0)}
            
            alert.addAction(yesAction)
            alert.addAction(noAction)
            present(alert, animated: true)
        } else {
            Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(changeQuestion), userInfo: nil, repeats: false)
        }
        
    }
    
    @objc func changeQuestion() {
        textQuestion.text = brainQuiz.getTextQuestion()
        textQuestion.textColor = brainQuiz.getColor()
        
        imageQuestion.image = brainQuiz.getImage()
        
        progressQuiz.progress = brainQuiz.getProgress()
        
        scoreLabel.text = "Score: \(brainQuiz.getScore()) pts"
        
        trueButton.backgroundColor = UIColor.purple
        falseButton.backgroundColor = UIColor.purple
        
        trueButton.isEnabled = true
        falseButton.isEnabled = true
    }
    
    @IBOutlet weak var progressQuiz: UIProgressView!
    
    var brainQuiz = QuizBrain()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressQuiz.progress = brainQuiz.getProgress()
        
        imageQuestion.image = brainQuiz.getImage()
        imageQuestion.layer.cornerRadius = 20
        imageQuestion.layer.masksToBounds = true
        
        textQuestion.text = brainQuiz.getTextQuestion()
        textQuestion.textColor = brainQuiz.getColor()
        
        scoreLabel.text = "Score : \(brainQuiz.getScore()) pts"
        
        
    }


}

