//
//  Extentions.swift
//  RestfulMobileClient
//
//  Created by Hana  Demas on 3/1/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation
import UIKit

public extension UIImageView {
    //UIImageview extention to load image asynchronously
    public static func loadImageFromUrl(imageUrlString: String, completion: @escaping ((_ urlString: String, _ image: UIImage) -> ())) {
        guard let url = URL(string: imageUrlString) else {
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                return
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async(execute: { () -> Void in
                    completion(imageUrlString, image)
            })
            }
        }).resume()
    }
}

// seuence extention used to group arrays of photos into dictionary by their album id
public extension Sequence {
    func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var categories: [U: [Iterator.Element]] = [:]
        for element in self {
            let key = key(element)
            if case nil = categories[key]?.append(element) {
                categories[key] = [element]
            }
        }
        return categories
    }
}
