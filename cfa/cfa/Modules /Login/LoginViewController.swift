//
//  SignUp.swift
//  cfa
//
//  Created by Sofiia Kruglikova on 29.01.2021.
//

import UIKit
import AuthenticationServices
import LocalAuthentication

class LoginViewController: UIViewController {
    
    let viewModel = LoginViewModel()
    let authenticationLimit: Int = 3
    
    var wrongAuthenticationCount: Int = 0
    var laPolicy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
    }
    
    func showMainGraphView() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let mainGraphViewController = storyBoard.instantiateViewController(withIdentifier: "MainGraphViewController") as! MainGraphViewController
        self.navigationController?.pushViewController(mainGraphViewController, animated: true)
    }
    
    func authenticationWithBiometricID(completion: ((String?) -> Void)? = nil) {
            let localAuthenticationContext = LAContext()
            localAuthenticationContext.localizedFallbackTitle = "Please enter a 5-character long password"

            var authorizationError: NSError?
            let reason = "Use touch ID to log in"

            if localAuthenticationContext.canEvaluatePolicy(laPolicy, error: &authorizationError) {
                
                localAuthenticationContext.evaluatePolicy(laPolicy, localizedReason: reason) { success, evaluateError in
                    
                    completion?(success ? nil : evaluateError?.localizedDescription ?? "Unknown reason")
                    
                }
            } else {
                completion?(authorizationError?.localizedDescription ?? "Unknown auth error")
            }
        }
    
    @IBAction func signUpButtonPress(_ sender: UIButton) {
        //showDataView()
        authenticationWithBiometricID { (errorText) in
            DispatchQueue.main.async() {
                if let text = errorText {
                    self.showAlert(title: "Authentication error", message: text)
                    //self.wrongAuthenticationCount += 1
                    //if self.wrongAuthenticationCount > (self.authenticationLimit - 1) {
                        //self.laPolicy = .deviceOwnerAuthentication
//                    }
                } else {
                    self.showMainGraphView()
                }
            }
        }
    }
}
