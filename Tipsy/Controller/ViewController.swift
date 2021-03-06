//
//  ViewController.swift
//  Tipsy
//
//  Created by Dixita Bhargava on 11/06/2020.
//  Copyright © 2020 Dixita Bhargava. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"

    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        //Get the current title of the button that was pressed.
        let buttonTitle = sender.currentTitle!
        //Remove the last character (%) from the title then turn it back into a String.
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
        //Turn the String into a Double.
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        //Divide the percent expressed out of 100 into a decimal e.g. 10 becomes 0.1
        tip = buttonTitleAsANumber / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        //Get the text the user typed in the billTextField
               let bill = billTextField.text!
               
               //If the text is not an empty String ""
               if bill != "" {
                   
                   //Turn the bill from a String e.g. "123.50" to an actual String with decimal places.
                   //e.g. 125.50
                   billTotal = Double(bill)!
                   
                   //Multiply the bill by the tip percentage and divide by the number of people to split the bill.
                   let result = billTotal * (1 + tip) / Double(numberOfPeople)
                   
                   //Round the result to 2 decimal places and turn it into a String.
                   finalResult = String(format: "%.2f", result)
               }
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //If the currently triggered segue is the "goToResults" segue.
        if segue.identifier == "goToResults" {
            
            //Get hold of the instance of the destination VC and type cast it to a ResultViewController.
            let destinationVC = segue.destination as! ResultsViewController
            
            //Set the destination ResultsViewController's properties.
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
        }
    }
}

