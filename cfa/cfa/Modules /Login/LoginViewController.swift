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
    
    func showDataView() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dataViewController = storyBoard.instantiateViewController(withIdentifier: "EditDataViewController") as! EditDataViewController
        self.navigationController?.pushViewController(dataViewController, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func authenticationWithBiometricID(completion: ((String?) -> Void)? = nil) {
            let localAuthenticationContext = LAContext()
            localAuthenticationContext.localizedFallbackTitle = "Ввести 5-значный пароль"

            var authorizationError: NSError?
            let reason = "Приложите палец чтобы войти в приложение"

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
                    self.showDataView()
                }
            }
        }
    }
}
