//
//  CustomAlertSettingsViewController.swift
//  Calorie_App
//
//  Created by student on 10/28/21.
//

import UIKit

protocol CustomAlertSettingsDelegate {
    func okButton(targetDeficitInput:Int)
    func cancelButton()
}

class CustomAlertSettingsViewController: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var alertInput: UITextField!
    @IBOutlet weak var alertBody: UILabel!
    
    var delegate: CustomAlertSettingsDelegate? = nil
    
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
    
    @IBAction func okButton(_ sender: Any) {
        if alertInput.text != "" {
            delegate?.okButton(targetDeficitInput: Int(alertInput.text!)!)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
}
