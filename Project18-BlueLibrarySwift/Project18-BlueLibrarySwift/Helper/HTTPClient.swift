//
//  HTTPClient.swift
//  Project18-BlueLibrarySwift
//
//  Created by Life's a struggle on 2018/8/5.
//  Copyright © 2018年 Karl. All rights reserved.
//

import UIKit

class HTTPClient {
    
    func getRequest(_ url: String) -> (AnyObject) {
        return Data() as (AnyObject)
    }
    
    func postRequest(_ url: String, body: String) -> (AnyObject){
        return Data() as (AnyObject)
    }
    
    func downloadImage(_ url: String) -> (UIImage) {
        let aUrl = URL(string: url)
        
        guard let data = try? Data(contentsOf: aUrl!) else {
            return UIImage()
        }
        
        let image = UIImage(data: data)
        return image!
    }
    
}
