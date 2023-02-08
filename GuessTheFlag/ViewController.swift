//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Amr El-Fiqi on 01/01/2023.
//

import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    let defaults = UserDefaults.standard
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var count = 0
    var oldScore = 0 {
        didSet{
            let savedScore = defaults.integer(forKey: "score")
            oldScore = savedScore
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Add countries in Assets folder to countries array
        countries += ["us", "france", "italy", "uk", "estonia", "germany", "ireland", "monaco", "spain", "poland", "russia", "nigeria"]
        // Add a border around each button to show the button limit
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        
        // Set border color
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestions(action: nil)
        let savedScore = defaults.integer(forKey: "score")
        oldScore = savedScore
        

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Score",style: .plain ,target: self, action: #selector(shareButton))
    }
    
    // Shuffle the order of items in countries array and set each button with a random image
    func askQuestions(action: UIAlertAction!){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        
        button1.setImage(UIImage (named: countries[0]), for: .normal)
        button2.setImage(UIImage (named: countries[1]), for: .normal)
        button3.setImage(UIImage (named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
        
    }

    @IBAction func buttontabbed(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score  += 1
            count += 1
        }
        else {
            title = "Wrong, this is the flag of \(countries[correctAnswer].capitalizingFirstLetter())!"
            score -= 1
            count += 1
        }
        
//        let ac = UIAlertController(title: title, message: "Your score is: \(score)", preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestions))
        let ac = UIAlertController(title: title, message: "Your score is: \(score)", preferredStyle: .alert)
        if count == 10{
            let ac = UIAlertController(title: title, message: "You have Answered 10 Questions, Your final score is: \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Start Over", style: .default, handler: askQuestions))
            present(ac, animated: true)
            
            score = 0
        }
        else{
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestions))
            present(ac, animated: true)
        }
        
        if (score > oldScore){
            let ac2 = UIAlertController(title: "Good job!", message: "You managed to beat the previous high score!", preferredStyle: .alert)
            ac2.addAction(UIAlertAction(title: "Yay!", style: .default))
            if self.presentedViewController==nil{
                
                self.present(ac, animated: true)
            }else{
                self.presentedViewController!.present(ac2, animated: true, completion: nil)
            }
        }
        
        defaults.set(score, forKey: "score")
        print(score)
        print(oldScore)
        
    }
    
    
    @objc func shareButton(){
        
        let savedScore = defaults.integer(forKey: "score")
        let vc = UIAlertController(title: "Old Score: \(savedScore)\n New Score: " , message: "\(score)", preferredStyle: .alert)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        vc.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(vc, animated: true)
    }
    
}

