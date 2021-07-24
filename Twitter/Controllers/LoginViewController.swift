//
//  LoginViewController.swift
//  Twitter
//
//  Created by Alex Roman on 7/22/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.usernameTextField.addBottomBorder()
        self.passwordTextField.addBottomBorder()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
        let isAuthenticated = self.defaults.object(forKey: "isAuthenticated") as? Bool ?? false
        
        if isAuthenticated {
            performSegue(withIdentifier: "loginToHome", sender: self)
        } else {
            let reqTokenBaseUrl = "https://api.twitter.com/oauth/request_token"
            TwitterAPICaller.client?.login(url: reqTokenBaseUrl, success: {
                self.performSegue(withIdentifier: "loginToHome", sender: self)
                self.defaults.setValue(true, forKey: "isAuthenticated")
            }, failure: { Error in
                self.showLoginError(err: Error)
            })
        }
        
    }
    
    func showLoginError(err: Error){
        let alert = UIAlertController(title: "Error Connecting with Twitter", message: err.localizedDescription, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
        
        self.present(alert, animated: true)
        
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UITextField {
    func addBottomBorder() {
        let bottomborder = CALayer()
        bottomborder.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomborder.backgroundColor = UIColor.lightGray.cgColor
        borderStyle = .none
        layer.addSublayer(bottomborder)
    }
}
