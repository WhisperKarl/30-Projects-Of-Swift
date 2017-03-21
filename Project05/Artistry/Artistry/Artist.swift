//
//  Artist.swift
//  Artistry
//
//  Created by Karl on 2017/3/21.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class Artist: NSObject {
    let name: String
    let bio: String
    let image: UIImage
    var works: [Work]
    
    init(name: String, bio: String, image: UIImage, works: [Work]) {
        self.name = name;
        self.bio = bio
        self.image = image
        self.works = works
    }
    
    static func artistsFromBundle() -> [Artist] {
        
        var artists = [Artist]()
        
        //guard语法，如果不满足条件，执行else语句，满足，拆包 继续执行
        guard let url = Bundle.main.url(forResource: "artists", withExtension: "json") else {
            return artists
        }
        // do-catch 语句,捕捉异常
        do {
            let data = try Data.init(contentsOf: url)
            guard let rootObjects = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return artists
            }
            guard let artistObjects = rootObjects["artists"] as? [[String : Any]] else {
                return artists
            }
            
            for artistObject in artistObjects {
                if let name = artistObject["name"] as? String,
                    let bio = artistObject["bio"] as? String,
                    let imageName = artistObject["image"] as? String,
                    let image = UIImage.init(named: imageName),
                    let worksObject = artistObject["works"] as? [[String : String]]{
                    
                    var works = [Work]()
                    for workObject in worksObject {
                        if let workTitle  = workObject["title"],
                            let workImageName = workObject["image"],
                            let workImage = UIImage.init(named: workImageName + ".jpg"),
                            let info = workObject["info"]{
                            works.append(Work(title: workTitle, image: workImage, info: info, isExpanded: false))
                        }
                    }
                    let artist = Artist.init(name: name, bio: bio, image: image, works: works)
                    artists.append(artist)
                }
            }
        } catch  {
            return artists
        }
        return artists
    }
}
