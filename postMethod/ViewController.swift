//
//  ViewController.swift
//  postMethod
//
//  Created by apple on 23/04/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.postMethod()
        self.pwdencode()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func postMethod()
    {
        let url = URL(string: "https://google.com/signup")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "userName=13&email=Jack1@gmail.com&password=12121212"
        request.httpBody = postString.data(using: .utf8)
        
        // Getting response for POST Method
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            // getting response
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            
            // checking statuscode
            if let HTTPResponse = response as? HTTPURLResponse {
                let statusCode = HTTPResponse.statusCode
                print("statusCode: \(statusCode)")
                if statusCode == 200 {
                    // Yes, Do something.
                }
            }
            
            // getting values from response as dictionary
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! NSDictionary
                print ("data = \(jsonResponse)")
                let msg = jsonResponse.object(forKey: "message")
                print("msg: \(String(describing: msg))")
            }catch _ {
                print ("OOps not good JSON formatted response")
            }
        }
        task.resume()
    }
    
    //encrypting password to 64 - bit
    func pwdencode()
    {
        let str = "iOS Developer Tips encoded in Base64"
        print("Original: \(str)")
        let utf8str = str.data(using: String.Encoding.utf8)
        // encoding to 64 - bit for password
        if let base64Encoded = utf8str?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        {
            print("Encoded:  \(base64Encoded)")
            if let base64Decoded = NSData(base64Encoded: base64Encoded, options:   NSData.Base64DecodingOptions(rawValue: 0))
                
                .map({ NSString(data: $0 as Data, encoding: String.Encoding.utf8.rawValue) })
            {
                // Convert back to a string
                print("Decoded:  \(String(describing: base64Decoded))")
            }
        }
    }
    
}

