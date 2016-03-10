//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var resultDisplayLabel: UILabel!
    @IBOutlet weak var guessBotton: UIButton!
    @IBOutlet weak var userInputTextField: UITextField!
    @IBOutlet weak var wrongGuessLabel: UITextView!
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var startOverButton: UIButton!
    var phrase: String = ""
    var alreadyRight: String = ""
    var alreadyWrong: String = ""
    var overRound = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        resultDisplayLabel.text = ""
        for _ in phrase.characters {
            resultDisplayLabel.text =  resultDisplayLabel.text! + "_ "
        }
        userInputTextField.backgroundColor = UIColor(hue: 0.5667, saturation: 0.29, brightness: 0.84, alpha: 1.0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        resultDisplayLabel.text = ""
        for _ in phrase.characters {
            resultDisplayLabel.text =  resultDisplayLabel.text! + "_ "
        }
        userInputTextField.backgroundColor = UIColor(hue: 0.5667, saturation: 0.29, brightness: 0.84, alpha: 1.0)
        alreadyRight = ""
        alreadyWrong = ""
        overRound = false
        hangmanImage.image = UIImage(named: "hangman1.gif")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func detectInput(sender: AnyObject) {
        if overRound {
            guessBotton.enabled = false
            guessBotton.backgroundColor = UIColor.clearColor()
            return
        }
        let input = sender as! UITextField
        if (input.text?.characters.count != 1 || alreadyWrong.rangeOfString(userInputTextField.text!) != nil || alreadyRight.rangeOfString(userInputTextField.text!) != nil){
            guessBotton.enabled = false
            guessBotton.backgroundColor = UIColor.clearColor()
        } else {
            guessBotton.enabled = true
            if phrase.rangeOfString(input.text!) != nil {
                guessBotton.backgroundColor = UIColor.greenColor()
            } else {
                guessBotton.backgroundColor = UIColor.redColor()
            }
        }
    }
    
    @IBAction
    func guess() {
        if overRound {
            return;
        }
        if phrase.rangeOfString(userInputTextField.text!) != nil {
            alreadyRight = alreadyRight + userInputTextField.text!
            resultDisplayLabel.text = ""
            var success = true
            for word in phrase.characters {
                if alreadyRight.characters.indexOf(word) != nil {
                    resultDisplayLabel.text = resultDisplayLabel.text! + String(word) + " "
                } else {
                    resultDisplayLabel.text = resultDisplayLabel.text! + "_ "
                    success = false
                }
            }
            if success {
                overRound = true
                let alert = UIAlertController(title: "You win!", message: "U have finished this game", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "LOL Grreat", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        } else {
            alreadyWrong = alreadyWrong + userInputTextField.text!
            wrongGuessLabel.text = "Incorrect Guesses: "
            for word in alreadyWrong.characters {
                wrongGuessLabel.text = wrongGuessLabel.text! + String(word) + " "
            }
        }
        hangmanImage.image = UIImage(named: "hangman" + "\(alreadyWrong.characters.count + 1)" + ".gif")
        guessBotton.enabled = false
        guessBotton.backgroundColor = UIColor.clearColor()
        userInputTextField.text = ""
        if alreadyWrong.characters.count == 6 {
            overRound = true
            let alert = UIAlertController(title: "You lose!", message: "T^T You used up your lucky points, and your man is dead now. Plz try again!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "GGWP", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction
    func startOver() {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
