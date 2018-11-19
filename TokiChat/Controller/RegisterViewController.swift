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
    @IBOutlet weak var mainAnimanitonView: UIView!
    @IBOutlet weak var questionMarkOne: UIImageView!
    @IBOutlet weak var questionMarkTwo: UIImageView!
    @IBOutlet weak var questionMarkThree: UIImageView!
    @IBOutlet weak var questionMarkFour: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RoundedButton().buttonCornerRadiusSetup(button: registerButton)
        mainAnimanitonView.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        nukeAllAnimations()
    }

    fileprivate func showAlert(title: String, message: String, buttonTittle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTittle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    fileprivate func registerUser() {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextFIeld.text!) { (user, error) in
            if error != nil {
                self.mainAnimanitonView.isHidden = false
                self.startAnimation()
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

    fileprivate func startAnimation() {
        UIView.animate(withDuration: 1.0,
            delay: 0.5,
            options: [.autoreverse, .repeat],
            animations: {
                self.repeatAnimation()
                self.errorLabel.text = "We have a problem here... "
            },
            completion: { finished in
                print("Animation is done")
                self.mainAnimanitonView.isHidden = true
            })
    }

    fileprivate func repeatAnimation() {
        UIView.setAnimationRepeatCount(7)

        self.questionMarkOne.alpha = 0.0
        self.questionMarkOne.alpha = 1.0

        self.questionMarkTwo.alpha = 0.0
        self.questionMarkTwo.alpha = 1.0

        self.questionMarkThree.alpha = 0.0
        self.questionMarkThree.alpha = 1.0

        self.questionMarkFour.alpha = 0.0
        self.questionMarkFour.alpha = 1.0
    }

    func nukeAllAnimations() {
        self.view.subviews.forEach({ $0.layer.removeAllAnimations() })
        self.view.layer.removeAllAnimations()
        self.view.layoutIfNeeded()
    }

    @IBAction func registerButtonTapped(_ sender: UIButton) {
        registerUser()
    }
}
