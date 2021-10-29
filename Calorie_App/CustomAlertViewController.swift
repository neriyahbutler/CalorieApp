//
//  CustomAlertViewController.swift
//  Calorie_App
//
//  Created by student on 10/27/21.
//

import UIKit

protocol CustomAlertDelegate {
    func okButton(title:String, message:String, weightInput:String, repInput:String, setInput:String)
    func cancelButton()
}

class CustomAlertViewController: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var alertBody: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var repLabel: UILabel!
    @IBOutlet weak var setLabel: UILabel!
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repTextField: UITextField!
    @IBOutlet weak var setTextField: UITextField!
    
    var delegate: CustomAlertDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    func setupView() {
        alertView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView() {
        alertView.alpha = 0
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 0
        UIView.animate(withDuration: 0.0, animations: {() -> Void in
            self.alertView.alpha = 1.0
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 0
        })
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButton(_ sender: Any) {
        delegate?.okButton(title: alertTitle.text!, message: alertBody.text!, weightInput: weightTextField.text!, repInput: repTextField.text!, setInput: setTextField.text!)
        self.dismiss(animated: true, completion: nil)
    }
}
