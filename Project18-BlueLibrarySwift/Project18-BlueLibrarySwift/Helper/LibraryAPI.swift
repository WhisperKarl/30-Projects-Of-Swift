//
//  LibraryAPI.swift
//  Project18-BlueLibrarySwift
//
//  Created by Life's a struggle on 2018/8/5.
//  Copyright © 2018年 Karl. All rights reserved.
//

import UIKit

class LibraryAPI: NSObject {

    static let sharedInstance = LibraryAPI()
    
    fileprivate let persistencyManager: PersistencyManager
    fileprivate let httpClient: HTTPClient
    fileprivate let isOnline: Bool
    
    fileprivate override init() {
        persistencyManager = PersistencyManager()
        httpClient = HTTPClient()
        isOnline = false
        
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: .downloadImage, name: .BLDownloadImage, object: nil)
    }
    
    
    func getAlbums() -> [Album] {
        return persistencyManager.getAlbums()
    }

    
    func addAlbum(_ album: Album, index: Int) {
        persistencyManager.addAlbum(album, index: index)
        if isOnline {
            let _ = httpClient.postRequest("/api/addAlbum", body: album.description)
        }
    }

    func deleteAlbum(_ index: Int) {
        persistencyManager.deleteAlbumAtIndex(index)
        if isOnline {
            let _ = httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
        }
    }

    @objc func downloadImage(_ notification: Notification) {
        // retrieve info from notification
        guard let userInfo = notification.userInfo,
            let imageView = userInfo["imageView"] as? UIImageView,
            let coverUrl = userInfo["coverUrl"] as? String,
            let filename = URL(string: coverUrl)?.lastPathComponent else {
                return
        }
    }

}

extension Selector {
    static let downloadImage = #selector(LibraryAPI.downloadImage(_:))
}

