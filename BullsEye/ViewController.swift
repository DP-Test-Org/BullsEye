//
//  ViewController.swift
//  BullsEye
//
//  Created by dpcamerino on 9/23/20.
//

import UIKit

class ViewController: UIViewController {

    var currentValue: Int = 0
    var targetValue: Int = 0
    var difference: Int = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startOver()
    }

    @IBAction func showAlert() {
        print("Hello!")
        let message = "The value of the slider is now: \(currentValue)\n"
            + "The target value is: \(targetValue)\n"
            + "The difference is: \(getDifference())\n"
            + "Points scored: \(getPoints())"
        let alert = UIAlertController(title: getTitle(), message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome!", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        score = score + getPoints()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        print("The value of the slider is now: \(slider.value)")
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
    }

    func startNewRound() {
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        round = round + 1
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func getDifference() -> Int {
        abs(targetValue - currentValue)
    }
    
    func getPoints() -> Int {
        let bonus: Int
        if getDifference() == 1 {
            bonus = 50
        } else if getDifference() == 0 {
            bonus = 100
        } else {
            bonus = 0
        }
        return 100 - getDifference() + bonus
    }
    
    func getTitle() -> String {
        let title: String
        difference = getDifference()
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Do you even title bro?"
        }
        return title
    }
    
    
    @IBAction func startOver() {
        score = 0
        round = 0
        startNewRound()
    }
}

