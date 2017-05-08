//
//  ViewController.swift
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


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
       
        
        
                
        
        
       /* Alamofire.request("https://node.jose.nydus.eu/getUsers").responseJSON { response in
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
         //       print(response.metrics)
                print("JSON: \(JSON)")
            }
        }*/
        
       /* let password: Array<UInt8> = Array("password".utf8)
        let salt: Array<UInt8> = Array("salt".utf8)
        
        let x = try! PKCS5.PBKDF2(password: password, salt: salt, iterations: 1000, variant: .sha256).calculate()
        
        print(x)
        
        var str = String(bytes: x, encoding: String.Encoding.utf8)
        print("first ", x.toHexString())
        print(str)*/

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        print("asdasd") 
        let kc = KeychainSwift()
        if (kc.getBool("loggedIn") == nil) {
            
            kc.set(false, forKey: "loggedIn")
        }else{
            let x = kc.getBool("loggedIn")
            
            if (x! == false) {
                print("donethis")
                print("called")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let view: StartPointVC = storyboard.instantiateViewController(withIdentifier: "StartPointVC") as! StartPointVC
                self.present(view, animated: true, completion: nil)
                
                
                
            }else{
                print("here")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let view: CodeGenerationVC = storyboard.instantiateViewController(withIdentifier: "CodeGenerationVC") as! CodeGenerationVC
                self.present(view, animated: true, completion: nil)
            }
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

