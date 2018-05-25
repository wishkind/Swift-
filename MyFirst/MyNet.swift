//
//  MyNet.swift
//  MyFirst
//
//  Created by sj on 11/02/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
class MyNet: NSObject {
    override init() {
        super.init()
        let urlString = "http://192.168.1.3/My.php"
        let url = URL(string: "http://192.169.1.3/crow-1.png")
            url = URL(string: urlString)
        var request = URLRequest(url: url!)
        let postString = "firstName=James&lastName=Bond";
           request.httpMethod = "POST"// Compose a query string
            request.httpBody = postString.data(using: String.Encoding.utf8);
        let session = URLSession.shared
        let date = Date()
        print("begin time:\(date.timeIntervalSince1970)")
        
        let dataTask = session.dataTask(with: request, completionHandler: {(data, resp, err) in
            let comDate = Date()
            print("return time:\(comDate.timeIntervalSince1970)")
            if err != nil {
                print(err.debugDescription)
            } else {
                let responseStr = String(data: data!, encoding: String.Encoding.utf8)
                print(responseStr ?? "o")
                if let response = resp as? HTTPURLResponse {
                    print("code:\(response.statusCode)")
                    for (tab, result) in response.allHeaderFields {
                        print("\(tab.description) - \(result)")
                        if response.statusCode == 200 {
                            print("ok")
                            do {
                                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                
                                if let parseJSON = json {
                                    
                                    // Now we can access value of First Name by its key
                                    let firstNameValue = parseJSON["firstName"] as? String
                                    print("firstNameValue: \(firstNameValue)")
                                }
                            } catch {
                                print(error)
                            }                        }
                        else {
                            print("error")
                            
                        }
                    }
                }
            }
            
            
            
        }) as URLSessionTask
        let beginDate = Date()
        print("begin:\(beginDate.timeIntervalSince1970)")
        dataTask.resume()
        let endDate = Date()
        print("end:\(endDate.timeIntervalSince1970)")
    }
    
    func download() {
        let temp = NSTemporaryDirectory()
        let session = URLSession.shared
        let data = Data()
        let downloadTask = session.downloadTask(withResumeData: data, completionHandler: {(url, rsp, err) in
            print("ok:")
            
        })
      
    }
}
