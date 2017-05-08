//
//  CodeGenerationVC.swift
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

class CodeGenerationVC: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var getCode: UIButton!
    @IBOutlet weak var codeLabel: UILabel!
    let renewalRate = 15
    var timerx = Timer()
    var isTimerRunning = false
    var code:String? = nil
    let kc = KeychainSwift()
    var timeleft = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let timeleft = getTimeLeft()
        self.progressBar.progressTintColor = UIColor.orange
        self.progressBar.trackTintColor = UIColor.white

        timeleft = getTimeLeft()
        runTimer(x: timeleft)
        threadWork()
               
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func getTimeLeft() -> Int {
        let x = (Int(NSDate().timeIntervalSince1970) - Int(kc.get("timestamp")!)!)
        let y =  (x % 15)
        print(y)
        return y
    }
    
    func runTimer(x: Int) { 
        self.timerx = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    func updateTimer() {
        self.timeleft -= 1     //This will decrement(count down)the seconds.
        self.timeleft = getTimeLeft()
        print(self.timeleft)
        
        //self.progressBar.progress(Float(15/self.timeleft))
        
        if timeleft <=  0  {
            timeleft = getTimeLeft()
            threadWork()
            self.progressBar.setProgress(1, animated: false)

        }else{
            let x = Float(1-(Float(self.timeleft)/15.0) )
            self.progressBar.setProgress(x, animated: true)
                    }
        print(timeleft)
        
    }
    
    
    @IBAction func genCodeB(_ sender: Any) {
                let password :Array<UInt8> = Array(kc.get("secret")!.utf8)
        let salt: Array<UInt8> = Array(kc.get("salt")!.utf8)
        let ts = Int(NSDate().timeIntervalSince1970) - Int(kc.get("timestamp")!)!
        
        let it = (ts / self.renewalRate)
        //let it = 1000
        //print("secret",kc.get("secret")!)
        //print("salt",kc.get("salt")!)
        print("iterations", it)
        let x = try! PKCS5.PBKDF2(password: password, salt: salt, iterations: it, variant: .sha256).calculate()
        //print(x.toHexString())
        let z = x.toHexString()
        let index: String.Index = z.index(z.startIndex, offsetBy: 5)
        
        codeLabel.text  = z.substring(to: index)
        //print("first \(x)")
        do {
            try PKCS5.PBKDF2(password: password, salt: salt, iterations: it, variant: .sha256).calculate()
            
        } catch  {
        }
    }
    func genCode() {
        let password :Array<UInt8> = Array(kc.get("secret")!.utf8)
        let salt: Array<UInt8> = Array(kc.get("salt")!.utf8)
        
        let ts = Int(NSDate().timeIntervalSince1970) - Int(kc.get("timestamp")!)!
        let it = (ts / self.renewalRate) % 10000
        //let it = 1000
        print("iterations", it)
         let x = try! PKCS5.PBKDF2(password: password, salt: salt, iterations: it, variant: .sha256).calculate()
        //print(x.toHexString())
        
        
        
        let z = x.toHexString()
        let index: String.Index = z.index(z.startIndex, offsetBy: 5)
        
        codeLabel.text  = z.substring(to: index)
    
        //do {
        //     try PKCS5.PBKDF2(password: password, salt: salt, iterations: it, variant: .sha256).calculate()
            
        //} catch  {
            
        //}
    }
    
    
    func genCodeString() -> String {
        let password :Array<UInt8> = Array(kc.get("secret")!.utf8)
        let salt: Array<UInt8> = Array(kc.get("salt")!.utf8)
        let ts = Int(NSDate().timeIntervalSince1970) - Int(kc.get("timestamp")!)!
        let it = (ts / self.renewalRate) % 10000
        
        let x = try! PKCS5.PBKDF2(password: password, salt: salt, iterations: it, variant: .sha256).calculate()
        let z = x.toHexString()
        let index: String.Index = z.index(z.startIndex, offsetBy: 5)
        return z.substring(to: index)
        //codeLabel.text  = z.substring(to: index)

    }
    
    func threadWork(){
        DispatchQueue.global().async {
            do {
                try self.code = self.genCodeString()
            } catch {
                print("Failed")
            }
            DispatchQueue.main.async(execute: {
                self.codeLabel.text = self.code
            })
        }
    }
    
    



}
