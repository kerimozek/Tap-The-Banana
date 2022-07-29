//
//  ViewController.swift
//  TapTheBanana
//
//  Created by Mehmet Kerim ÖZEK on 27.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var joeArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var joe1: UIImageView!
    @IBOutlet weak var joe2: UIImageView!
    @IBOutlet weak var joe3: UIImageView!
    @IBOutlet weak var joe4: UIImageView!
    @IBOutlet weak var joe5: UIImageView!
    @IBOutlet weak var joe6: UIImageView!
    @IBOutlet weak var joe7: UIImageView!
    @IBOutlet weak var joe8: UIImageView!
    @IBOutlet weak var joe9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        
        
        joe1.isUserInteractionEnabled = true
        joe2.isUserInteractionEnabled = true
        joe3.isUserInteractionEnabled = true
        joe4.isUserInteractionEnabled = true
        joe5.isUserInteractionEnabled = true
        joe6.isUserInteractionEnabled = true
        joe7.isUserInteractionEnabled = true
        joe8.isUserInteractionEnabled = true
        joe9.isUserInteractionEnabled = true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        joe1.addGestureRecognizer(recognizer1)
        joe2.addGestureRecognizer(recognizer2)
        joe3.addGestureRecognizer(recognizer3)
        joe4.addGestureRecognizer(recognizer4)
        joe5.addGestureRecognizer(recognizer5)
        joe6.addGestureRecognizer(recognizer6)
        joe7.addGestureRecognizer(recognizer7)
        joe8.addGestureRecognizer(recognizer8)
        joe9.addGestureRecognizer(recognizer9)
        
        joeArray = [joe1, joe2, joe3, joe4, joe5, joe6, joe7, joe8, joe9]
        
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(hideJoe), userInfo: nil, repeats: true)
        
        hideJoe()
        
        
    }
    
    
    @objc func hideJoe() {
        
        for joe in joeArray {
            joe.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(joeArray.count - 1)))
        joeArray[random].isHidden = false
        
    }

    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }

    
    @objc func countDown() {
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for joe in joeArray {
                joe.isHidden = true
            }
            
            
            if self.score > self.highScore {
                self.highScore = self.score
                highscoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            let alert = UIAlertController(title: "Time's Up!", message: "Play Again!", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { [self] UIAlertAction in
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.hideJoe), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func playAgain(_ sender: Any) {
        
        self.score = 0
        self.scoreLabel.text = "Score: \(self.score)"
        self.counter = 10
        self.timeLabel.text = String(self.counter)
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        self.hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.hideJoe), userInfo: nil, repeats: true)
    }
    
}

