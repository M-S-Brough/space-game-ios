
import Foundation
import UIKit

struct QuizBrain {
    
    let questions = [
        Question(text: "Neptune is the smallest planet in the Solar System.",
                 answer: "FALSE",
                 color: UIColor.white,
                 image: UIImage(named: "neptune") ?? UIImage()),
        Question(text: "Uranus is tipped on its side, possibly due to a collision with an Earth-sized object.",
                 answer: "TRUE",
                 color: UIColor.white,
                 image: UIImage(named: "uranus") ?? UIImage()),
        Question(text: "Saturn's most famous feature is its great rings made of dust, rock, and ice particles.",
                 answer: "TRUE",
                 color: UIColor.white,
                 image: UIImage(named: "saturn") ?? UIImage()),
        Question(text: "Jupiter is known for its Great Red Spot, a storm that has been ongoing for hundreds of years.",
                 answer: "TRUE",
                 color: UIColor.white,
                 image: UIImage(named: "jupiter") ?? UIImage()),
        Question(text: "Mars is distinguished by its ring system and numerous moons.",
                 answer: "FALSE",
                 color: UIColor.white,
                 image: UIImage(named: "mars") ?? UIImage()),
        Question(text: "Earth is the only planet with a surface completely covered in water.",
                 answer: "FALSE",
                 color: UIColor.white,
                 image: UIImage(named: "earth") ?? UIImage()),
        Question(text: "Venus is the only inner planet to rotate in a clockwise direction on its axis.",
                 answer: "TRUE",
                 color: UIColor.white,
                 image: UIImage(named: "venus") ?? UIImage()),
        Question(text: "Mercury has a thick atmosphere that produces a colorful sky.",
                 answer: "FALSE",
                 color: UIColor.white,
                 image: UIImage(named: "mercury") ?? UIImage()),
        
    ]
    
    var numQuestions = 0
    var score = 0
    
    mutating func checkAnswer(userAnswer: String) -> Bool {
        if userAnswer == questions[numQuestions].answer {
            score += 1
            return true
        } else {
            return false
        }
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getTextQuestion() -> String {
        return questions[numQuestions].text
    }
    
    func getProgress() -> Float {
        let progress = Float(numQuestions + 1) / Float(questions.count)
        return progress
    }
    
    func getColor() -> UIColor {
        return questions[numQuestions].color
    }
    
    func getImage() -> UIImage {
        return questions[numQuestions].image
    }
    
    mutating func nextQuestion() -> Bool {
        if numQuestions + 1 < questions.count {
            numQuestions += 1
            return false
        } else {
            numQuestions = 0
            return true
        }
    }

    
}
