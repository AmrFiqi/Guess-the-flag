//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Amr El-Fiqi on 01/01/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Add countries in Assets folder to countries array
        countries += ["estonia", "france", "italy", "uk", "us", "germany", "ireland", "monaco", "spain", "poland", "russia", "nigeria"]
        askQuestions()
        
    }
    func askQuestions(){
        button1.setImage(UIImage (named: countries[0]), for: .normal)
        button2.setImage(UIImage (named: countries[1]), for: .normal)
        button3.setImage(UIImage (named: countries[3]), for: .normal)
    }


}

