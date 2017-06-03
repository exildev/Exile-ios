//
//  LoginViewController.swift
//  Exile
//
//  Created by Exile Soluciones Tecnológicas on 1/06/17.
//  Copyright © 2017 Exile Soluciones. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var loginContainer: UIView!
    @IBOutlet weak var passwordContainer: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginField.delegate = self
        passwordField.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.loginField) {
            self.passwordField.becomeFirstResponder()
        }else {
            self.view.endEditing(true)
        }
        errorLabel.isHidden = true
        
        return false
    }
    
    @IBAction func onLongin(_ sender: UIButton) {
        loginContainer.isHidden = true
        passwordContainer.isHidden = true
        usernameLabel.isHidden = true
        passwordLabel.isHidden = true
        loginButton.isHidden = true
        errorLabel.isHidden = true
        indicator.startAnimating()
        do{
            let json = ["username": loginField.text, "password": passwordField.text]
            let data = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        
            let request = NSMutableURLRequest(url: NSURL(string:"http://104.236.33.228:8000/usuarios/login/")! as URL)
            request.httpMethod = "POST"
        
            let body = NSMutableData()
            body.append(data)
        
            request.httpBody = body as Data
        
            let task =  URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
                (data, response, error) -> Void in
                if let data = data {
                    print(data.count)
                    let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    print("****** response data = \(responseString!)")
                    DispatchQueue.main.async(execute: {
                        self.indicator.stopAnimating()
                        if let httpResponse = response as? HTTPURLResponse {
                            if(httpResponse.statusCode == 200){
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                let resultViewController = storyBoard.instantiateViewController(withIdentifier: "MainView") as! BottomBarViewController
                                self.present(resultViewController, animated:true, completion:nil)
                            }else{
                                self.loginContainer.isHidden = false
                                self.passwordContainer.isHidden = false
                                self.usernameLabel.isHidden = false
                                self.passwordLabel.isHidden = false
                                self.loginButton.isHidden = false
                                self.errorLabel.isHidden = false
                            }
                        }
                    });
            } else if let error = error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        } catch{
            print("error en el json")
        }
    }
}
