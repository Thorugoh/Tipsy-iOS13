//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var pctValue: Float = 0.1
    var buttonTips: [UIButton?] = []
    var totalWithTip: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonTips = [zeroPctButton, tenPctButton, twentyPctButton]
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        let selectedButtonLabel = sender.titleLabel
        
        buttonTips.forEach { button in
            button?.isSelected = selectedButtonLabel == button?.titleLabel
            if(sender.titleLabel?.text == "0%"){
                pctValue = 0.0
            }else if(sender.titleLabel?.text == "10%"){
                pctValue = 0.1
            }else{
                pctValue = 0.2
            }
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(Int(sender.value))
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        if let totalBillLabel = billTextField.text {
            let totalBill = Float(totalBillLabel) ?? 0.0
            guard let splitNumber = Float(splitNumberLabel.text ?? "2") else { return }
            print(totalBill)
            print(splitNumber)
            print(pctValue)
            
            let total = totalBill / splitNumber
            totalWithTip = total + (total * pctValue)
            
            
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let resultVC = segue.destination as! ResultsViewController
            resultVC.totalPerPerson = String(format: "%.2f", totalWithTip)
            let numberOfPeople = splitNumberLabel.text ?? "2"
            let tip = Int(pctValue * 100)
            resultVC.settings = "splits between \(numberOfPeople) with \(tip)% tip"
        }
    }
}

