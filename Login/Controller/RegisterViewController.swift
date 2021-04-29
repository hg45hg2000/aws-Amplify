//
//  RegisterViewController.swift
//  Login
//
//  Created by student on 2021/4/29.
//

import UIKit
import Amplify

class RegisterViewController: UIViewController {

    @IBOutlet weak var userTextfield: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerButtonPress(_ sender: UIButton) {
        if let username = userTextfield.text , let email = emailTextField.text ,let passowrd = passwordTextfield.text{
            signUp(username: username, password: passowrd, email: email)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func signUp(username: String, password: String, email: String) {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        
        
        Amplify.Auth.signUp(username: username, password: password, options: options) { result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                } else {
                    print("SignUp Complete")
                }
            case .failure(let error):
                
                print("An error occurred while registering a user \(error.errorDescription)")
            }
        }
    }

}
