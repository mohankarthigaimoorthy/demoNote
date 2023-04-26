//
//  signUpViewController.swift
//  demoNotes
//
//  Created by Mohan K on 14/04/23.
//

import Foundation
import UIKit

class signUPVC: BaseVC {
    
    @IBOutlet weak var nametext: UITextField!
    @IBOutlet weak var emailtext: UITextField!
    @IBOutlet weak var passwordtext : UITextField!
    @IBOutlet weak var titletext : UITextField!
    @IBOutlet weak var contenttext : UITextView!
    
    private let signUpvM = signUpVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    private func signupAuth() {
        signUpvM.email = emailtext.text ?? ""
        signUpvM.password = passwordtext.text ?? ""
        signUpvM.name = nametext.text ?? ""
        signUpvM.title = titletext.text ?? ""
        signUpvM.content = contenttext.text ?? ""
        
        ShowLoaderOnView()
        signUpvM.signupAuth{ (success, msg) in
            HideLoaderOnView()
            if success {
                self.alert(message: msg)
            }
            else {
                self.alert(message: msg)
            }
        }
    }
    
    @IBAction func butonSignUp(_ sender: UIButton) {
        signupAuth()
    }
    
    @IBAction func eyeAction(_ sender: UIButton) {
        if  sender.isSelected {
            passwordtext.isSecureTextEntry = false
        
        } else {
            
            passwordtext.isSecureTextEntry = true
            sender.isSelected = !sender.isSelected
        }
    
    }
}
