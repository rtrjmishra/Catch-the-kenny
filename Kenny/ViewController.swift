//
//  ViewController.swift
//  Kenny
//
//  Created by Rituraj Mishra on 25/01/22.
//

import UIKit

class ViewController: UIViewController
{
    //MARK: -Variables
    var score = 0
    var highscore = 0
    var kennyArray = [UIImageView]()
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    
    //MARK: -VIEWS
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")

        if storedHighScore == nil
        {
            highscore = 0
            highscoreLabel.text = "Highscore: \(highscore)"
        }

        if let newScore = storedHighScore as? Int
        {
            highscore = newScore
            highscoreLabel.text = "Highscore: \(highscore)"
        }
        
        //MARK: -Images
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        //MARK: -Gesture Recogniser
        let recog1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        //MARK: -Adding gesture
        kenny1.addGestureRecognizer(recog1)
        kenny2.addGestureRecognizer(recog2)
        kenny3.addGestureRecognizer(recog3)
        kenny4.addGestureRecognizer(recog4)
        kenny5.addGestureRecognizer(recog5)
        kenny6.addGestureRecognizer(recog6)
        kenny7.addGestureRecognizer(recog7)
        kenny8.addGestureRecognizer(recog8)
        kenny9.addGestureRecognizer(recog9)
        
        //MARK: -KENNY ANIMATING
        kennyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        
        
        
        //MARK: -Timers
        counter = 10
        timerLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
    }
    
    //MARK: - HELPER FUNCTIONS
    
    @objc func hideKenny()
    {
        for k in kennyArray{
            k.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }
    
    @objc func increaseScore()
    {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown()
    {
        counter -= 1
        timerLabel.text = String(counter)
        
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            for k in kennyArray{
                k.isHidden = true
            }
            
            if self.score > self.highscore
            {
                self.highscore = self.score
                highscoreLabel.text = "Highscore: \(self.highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "highscore")
            }
            
            //MARK: -ALERT
            let alert = UIAlertController(title: "Time's up!", message: "Wanna play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default)
            {
                //MARK: - REPLAY FUNC
                (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10;
                self.timerLabel.text = String(self.counter)
    
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

