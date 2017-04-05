//
//  PlaceholderAPIClient.swift
//  RestfulMobileClient
//
//  Created by Hana  Demas on 2/21/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation

class PlaceholderAPIClient {
    
    //function to fetch data using "Get" method from URI
    func fetchDataFromNetwork(url: String, completion: @escaping (ResponseObject?) -> ()) {
        let request = clientURLRequest(url: URL(string: url)!, path:"",  params: nil)
        get(request: request){ (success, object) -> () in
            DispatchQueue.main.async(execute: { () -> Void in
                if success {
                    completion(object as? ResponseObject)
                } else {
                    completion(nil)
                }
            })
        }
    }
    
    // function to set the restful api method to get
    private func get(request:URLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request as URLRequest, method: "GET", completion: completion)
    }
    
    // Function to get urlrequest object from uri string
    private func clientURLRequest(url: URL, path: String, params: Dictionary<String, AnyObject>? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        if let params = params {
            var paramString = ""
            for (key, value) in params {
                let escapedKey = key.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
                let escapedValue = (value as AnyObject).addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
                paramString += "\(escapedKey)=\(escapedValue)&"
            }
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = paramString.data(using: String.Encoding.utf8)
        }
        return request
    }
    
    //function to get json object from urlrequest
    private func dataTask( request: URLRequest, method:String, completion: @escaping (Bool, AnyObject?) -> ()) {
        var request = request
        request.httpMethod = method
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                    completion(true, json as AnyObject?)
                } else {
                    completion(false, json as AnyObject?)
                }
            }
        })
        task.resume()
    }
}


