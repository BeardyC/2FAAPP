//
//  StartPointVC.swift
//  2FAiOSApp
//
//  Created by Adrijus Zelinskis on 29/04/2017.
//  Copyright © 2017 BeardyC. All rights reserved.
//

import UIKit
import Alamofire
import CryptoSwift
import Simple_KeychainSwift
import KeychainSwift


class StartPointVC: UIViewController {
    
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    
    @IBAction func runCommand() {
        let username = usernameTextfield.text!
        let password = passwordTextfield.text!
        let kc = KeychainSwift()
        let parameters: Parameters = [
            "username": username,
            "password": password
        ]
        
            Alamofire.request("https://node.jose.nydus.eu/mobileLogin", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            //print(response.result)   // result of response serialization
                   
            
                if let JSON = response.result.value as? [String:Any] {
                //       print(response.metrics)
                print("JSON: \(JSON)")
                    if let x = JSON.first?.value as? [String:Any]{
                        if let z = x.first?.value as? [String:Any]{
                            print("ANOTHER \(z)")
                            
                            let timestamp = z["u_timestamp"]! as! String
                            let salt = z["u_salt"] as! String
                            let secret = z["u_secret"] as! String
                            let name = z["u_name"] as! String
                            
                            kc.set(timestamp, forKey: "timestamp")
                            kc.set(salt, forKey: "salt")
                            kc.set(secret, forKey: "secret")
                            kc.set(name, forKey: "name")
                            print(kc.get("timestamp"))

                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let view: CodeGenerationVC = storyboard.instantiateViewController(withIdentifier: "CodeGenerationVC") as! CodeGenerationVC
                            
                            
                            view.code = name
                            
                            self.present(view, animated: true, completion: nil)
                        }
                        
                    }
                    
            }
                
                if let arrayOfDic = response.result.value as? [Dictionary<String,AnyObject>]{
                    for aDic in arrayOfDic{
                        print(aDic)//print each of the dictionaries
                        
                    }
                }
                
        } 
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //usernameTextfield.leftViewMode = UITextFieldViewMode.always
        //var imageView = UIImageView();
        //var image = UIImage(named: "email.png");
        //imageView.image = image;
        //emailField.leftView = imageView;
       /* var imageView = UIImageView();
        var image = UIImage(named: "user.png");
        imageView.image = image;
        usernameTextfield.leftView = imageView;*/
        
        usernameTextfield.layer.cornerRadius = 10.0
        usernameTextfield.layer.borderWidth = 2.0
        usernameTextfield.layer.borderColor = UIColor.orange.cgColor

        passwordTextfield.layer.cornerRadius = 15.0
        passwordTextfield.layer.borderWidth = 2.0
        passwordTextfield.layer.borderColor = UIColor.orange.cgColor
        
        
       // usernameTextfield.borderStyle = UITextBorderStyle.roundedRect;
        //usernameTextfield.backgroundColor = UIColor(white: 1, alpha: 0)

       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
