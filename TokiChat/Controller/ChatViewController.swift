//
//  ChatViewController.swift
//  TokiChat
//
//  Created by Petar Lemajic on 8/24/18.
//  Copyright © 2018 Metalic_archaea. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ChatViewController: UIViewController {
    @IBOutlet weak var messageViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    
    var messageArray: [MessageModel] = [MessageModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        messageTextField.delegate = self
        registerNib()
        configTableView()
        configureTapGestureRegoniser()
        retriveMessages()
    }

    fileprivate func registerNib() {
        tableView.register(UINib(nibName: "CustomCellTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }

    fileprivate func configureTapGestureRegoniser() {
        let tapGesture = UIGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTextField.addGestureRecognizer(tapGesture)
    }

    @objc fileprivate func tableViewTapped() {
        messageTextField.endEditing(true)
    }

    fileprivate func configTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120.0
    }

    fileprivate func hightForView(hight: CGFloat) {
        self.messageViewHightConstraint.constant = hight
        self.view.layoutIfNeeded()
    }

    fileprivate func logoutUser() {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            ProgressHUD.showError("Faild to logout user -.-")
        }
    }
    
    fileprivate func retriveMessages() {
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshodValue = snapshot.value as! Dictionary<String,String>
            let text = snapshodValue["MessageBody"]!
            let sender = snapshodValue["Sender"]!
            let messageModel = MessageModel()
            messageModel.messageBody = text
            messageModel.senderName = sender
            self.messageArray.append(messageModel)
            self.configTableView()
            self.tableView.reloadData()
        }
    }
    
    fileprivate func sendTappedLogic() {
        messageTextField.endEditing(true)
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        let messageDB = Database.database().reference().child("Messages")
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email, "MessageBody": messageTextField.text!]
        messageDB.childByAutoId().setValue(messageDictionary) {
            (error, reference) in
            if error != nil {
                print("We have a problem")
            } else {
                self.messageTextField.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextField.text = ""
            }
        }
    }

    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        logoutUser()
    }
    
    @IBAction func sendTapped(_ sender: UIButton) {
        sendTappedLogic()
    }
}

extension ChatViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCellTableViewCell
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderName.text = messageArray[indexPath.row].senderName
        cell.avatar.image = UIImage(named: "senderImage")
        if cell.senderName.text == Auth.auth().currentUser?.email {
            cell.messageView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        } else {
            cell.messageView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        return cell
    }
}

extension ChatViewController: UITableViewDelegate {
    
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.hightForView(hight: 280)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.hightForView(hight: 60)
        }
    }
}
