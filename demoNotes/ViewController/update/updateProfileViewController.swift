//
//  updateProfileViewController.swift
//  demoNotes
//
//  Created by Mohan K on 14/04/23.
//

import Foundation
import UIKit

class updateProfileViewController: UIViewController
{
    
    @IBOutlet weak var nametxt: UITextField!
    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var passwordtxt: UITextField!
    @IBOutlet weak var titletxt: UITextField!
    @IBOutlet weak var contenttxt: UITextView!
    
    var userInfo: UsersModel!
    let updateProfileViewM = UpdateProfileVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        emailtxt.text = userInfo.email
        passwordtxt.text = userInfo.password
        nametxt.text = userInfo.name
        titletxt.text = userInfo.title
        contenttxt.text = userInfo.content
        
    }
    
    private func updateUserProfileDocument() {
    let info = UsersModel()
        info.documentId = userInfo.documentId
        info.email = emailtxt.text  ?? ""
        info.password = passwordtxt.text  ?? ""
        info.title = titletxt.text ?? ""
        info.name = nametxt.text ?? ""
        info.content = contenttxt.text ?? ""
        
        updateProfileViewM.userInfo = info
        ShowLoaderOnView()
        updateProfileViewM.updateUserProfileDocument {
             (success,msg) in
            HideLoaderOnView()
            if success {
                self.alert(message: msg)
                NotificationCenter.default.post(Notification.init(name: Notification.Name("UpdateData")))
            } else {
                self.alert(message: msg)
            }
        }
    }
    
    @IBAction func buttonUpdate (_ sender: Any)
    {
        updateUserProfileDocument()
    }
    
    @IBAction func EyeHide(_ sender: UIButton){
        if  sender.isSelected {
            passwordtxt.isSecureTextEntry = false
        
        } else {
            
            passwordtxt.isSecureTextEntry = true
            sender.isSelected = !sender.isSelected
        }
    
    }
}
