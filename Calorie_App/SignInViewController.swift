//
//  SignInViewController.swift
//  Calorie_App
//
//  Created by student on 10/29/21.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var rememberAccountBool: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signInButton(_ sender: Any) {
    }
    
//    @IBAction func signUpButton(_ sender: Any) {
//        performSegue(withIdentifier: "seg_signup", sender: <#T##Any?#>)
//    }
}
