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
        
        return false
    }
    
    @IBAction func onLongin(_ sender: UIButton) {
        let json = ["username": loginField.text, "password": passwordField.text]
        let data = JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let request = NSMutableURLRequest(url: NSURL(string:"http://104.236.33.228:8000/usuarios/login/")! as URL)
        request.httpMethod = "POST"
        
        let body = NSMutableData()
        body.append(data)
        
        request.httpBody = body as Data
        
        let task =  URLSession.shared.dataTask(with: request as URLRequest,
                                               completionHandler: {
                                                (data, response, error) -> Void in
                                                if let data = data {
                                                    
                                                    // You can print out response object
                                                    print("******* response = \(String(describing: response))")
                                                    
                                                    print(data.count)
                                                    // you can use data here
                                                    
                                                    // Print out reponse body
                                                    let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                                                    print("****** response data = \(responseString!)")
                                                    
                                                    
                                                    
                                                    DispatchQueue.main.async(execute: {
                                                        //self.activityIndicator.stopAnimating()
                                                        //self.reportButton.isEnabled = true
                                                        //let alert = UIAlertController(title: "Reporte de basurero", message: "Reporte enviado con exito", preferredStyle: UIAlertControllerStyle.alert)
                                                        //alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default, handler: nil))
                                                        //self.present(alert, animated: true, completion: nil)
                                                        //UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                                    });
                                                    
                                                } else if let error = error {
                                                    print(error.localizedDescription)
                                                }
        })
        task.resume()
    }
}