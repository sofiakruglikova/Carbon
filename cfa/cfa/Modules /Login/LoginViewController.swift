//
//  SignUp.swift
//  cfa
//
//  Created by Sofiia Kruglikova on 29.01.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    let viewModel = LoginViewModel()

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlert(title: String, message: String) {
        guard let username = usernameField.text else { return }
        guard let password = passwordField.text else { return }
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

    @IBAction func signUpButtonPress(_ sender: UIButton) {
        showDataView()
    }
}
