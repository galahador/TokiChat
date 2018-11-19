//
//  RegisterViewController.swift
//  TokiChat
//
//  Created by Petar Lemajic on 8/24/18.
//  Copyright © 2018 Metalic_archaea. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextFIeld: UITextField!
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        RoundedButton().buttonCornerRadiusSetup(button: registerButton)
    }

    fileprivate func showAlert(title: String, message: String, buttonTittle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonTittle, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    fileprivate func registerUser() {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextFIeld.text!) { (user, error) in
            if error != nil {
                self.showAlert(title: "Error", message: error?.localizedDescription ?? "Error", buttonTittle: "Ok")
                self.emailTextField.text = ""
                self.passwordTextFIeld.text = ""
            } else {
                self.showChatViewContorller()
                ProgressHUD.showSuccess("Successful registration!")
            }
        }
    }
    
    fileprivate func showChatViewContorller() {
        let chatVC = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        navigationController?.pushViewController(chatVC, animated: true)
    }

    @IBAction func registerButtonTapped(_ sender: UIButton) {
        registerUser()
    }

}
