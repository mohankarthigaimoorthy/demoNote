//
//  loginViewController.swift
//  demoNotes
//
//  Created by Mohan K on 14/04/23.
//

import Foundation
import UIKit

class LoginVC: BaseVC {
    
    @IBOutlet weak var emailID: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var icon: UIButton!
    
    private var loginvm = LoginVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        if Application.isInDevelopmenet {
            emailID.text = ""
            passwordTextField.text = ""
            
        }
    }
    
    private func loginAuth() {
        ShowLoaderOnView()
        loginvm.email = emailID.text ?? ""
        loginvm.password = passwordTextField.text ?? ""
        loginvm.loginAuth{ (success, msg) in
            HideLoaderOnView()
            if success{
                self.gotodashBoard()
                
            }
            else {
                self.alert(message: msg)
            }
        }
    }
    
    private func gotodashBoard() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "dashBoardVC") as? dashBoardVC
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func buttonLogin(_ sender: Any) {
        loginAuth()
    }
    
    @IBAction func  buttonSignUp(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "signUPVC") as? signUPVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func actionIcon(_ sender: UIButton) {
        if  sender.isSelected {
            passwordTextField.isSecureTextEntry = false
        
        } else {
            
            passwordTextField.isSecureTextEntry = true
            sender.isSelected = !sender.isSelected
        }
    }
}
