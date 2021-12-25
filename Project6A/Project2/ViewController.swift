//
//  ViewController.swift
//  Project2
//
//  Created by Chandran, Sudha on 24/12/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!

    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()


        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderWidth = 1
        button3.layer.borderColor = UIColor.lightGray.cgColor

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

        askQuestion(action: nil)
    }

    func askQuestion(action: UIAlertAction! = nil) {
        if questionsCount == 10 {
            let ac = UIAlertController(title: "Game Completed!",
                                       message: "Your score is \(score)",
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK",
                                       style: .default))
            present(ac, animated: true, completion: nil)
        }
        countries.shuffle()

        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)

        correctAnswer = Int.random(in: 0...2)
        updateTitle()
        questionsCount += 1
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var alertTitle:String

        if sender.tag == correctAnswer {
            alertTitle = "Correct!"
            score += 1
        } else {
            alertTitle = "Wrong! That’s the flag of \(countries[sender.tag])"
            score -= 1
        }

        if score < 0 {
            score = 0
        }

        updateTitle()

        let ac = UIAlertController(title: alertTitle,
                                   message: "Your score is \(score)",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue",
                                   style: .default,
                                   handler: askQuestion))
        present(ac, animated: true, completion: nil)
    }

    func updateTitle()  {
        title = countries[correctAnswer].uppercased() + " - \(score)"

    }
}

