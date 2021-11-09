//
//  CustomAlertSettingsHistoryViewController.swift
//  Calorie_App
//
//  Created by student on 11/8/21.
//

import UIKit

protocol CustomAlertSettingsHistoryDelegate {
    func okButton()
    func cancelButton()
}

class CustomAlertSettingsHistoryViewController: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var alertBody: UILabel!
    
    var delegate: CustomAlertSettingsHistoryDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        delegate?.okButton()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        delegate?.cancelButton()
        self.dismiss(animated: true, completion: nil)
    }
}
