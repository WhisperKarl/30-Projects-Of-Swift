
//
//  LibraryAPI.swift
//  PokeddexGo
//
//  Created by Karl on 2018/8/1.
//  Copyright © 2018年 whisperkarl.com. All rights reserved.
//

import UIKit

class LibraryAPI: NSObject {
    static let sharedInstance = LibraryAPI()
    let persistencyManager = PersistencyManager()
    
    fileprivate override init() {
    super.init()
    NotificationCenter.default.addObserver(self, selector: #selector(LibraryAPI.downloadImage(_:)), name: NSNotification.Name(rawValue: downloadImageNotification), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func getPokemons() -> [Pokemon] {
        return pokemons
    }
    func downloadImg(_ url: String) -> UIImage{
        let aUrl = URL(string: url)
        let data = try? Data(contentsOf: aUrl!)
        let image = UIImage(data: data!)
        return image!
    }
    @objc func downloadImage(_ notification :Notification) {
        let userinfo = (notification as Notification).userInfo as! [String: AnyObject]
        let pokeImageView = userinfo["pokeImageView"] as! UIImageView?
        let pokeImageUrl = userinfo["pokeImageUrl"] as! String
        //异步下载图片并缓存
        if let imageViewUnwrapped = pokeImageView {
            imageViewUnwrapped.image = persistencyManager.getImage((URL(string: pokeImageUrl)!.lastPathComponent))
            if imageViewUnwrapped.image == nil {
                DispatchQueue.global().async {
                    let downloadImage = self.downloadImg(pokeImageUrl as String)
                    DispatchQueue.main.async(execute: {
                        imageViewUnwrapped.image = downloadImage
                        self.persistencyManager.saveImage(downloadImage, filename: URL(string: pokeImageUrl)!.lastPathComponent)
                    })
                }
            }
        }
    }
    
    
    
}
