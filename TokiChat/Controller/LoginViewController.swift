//
//  LoginViewController.swift
//  TokiChat
//
//  Created by Petar Lemajic on 8/24/18.
//  Copyright © 2018 Metalic_archaea. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.becomeFirstResponder()
    }
    
    fileprivate func showAlert(title:String, message: String, buttonTittle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonTittle, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    fileprivate func loginUser() {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print("Error fail to login \(String(describing: error?.localizedDescription))")
                self.showAlert(title: "Error", message: error?.localizedDescription ?? "Error", buttonTittle: "Ok")
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
            } else {
                ProgressHUD.showSuccess("Success! ^_^")
                self.performSegue(withIdentifier: "fromLoginToChat", sender: self)
            }
        }
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        loginUser()
    }
}

