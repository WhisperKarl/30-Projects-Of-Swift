//
//  PersisencyManager.swift
//  Project18-BlueLibrarySwift
//
//  Created by Life's a struggle on 2018/8/5.
//  Copyright © 2018年 Karl. All rights reserved.
//

import UIKit

//final 关键字防止被重写
final class PersistencyManager: NSObject {
    fileprivate var albums = [Album]()
    fileprivate var cache: URL{
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }
    private var documents: URL{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    private enum FileNames {
        static let Albums = "albums.json"
    }
    override init() {
        super.init()
        
        let savedURL = documents.appendingPathComponent(FileNames.Albums)
        var data = try? Data(contentsOf: savedURL)
        if data == nil, let bundleURL = Bundle.main.url(forResource: FileNames.Albums, withExtension: nil) {
            data = try? Data(contentsOf: bundleURL)
        }
        
        if let albumData = data,
            let decodedAlbums = try? JSONDecoder().decode([Album].self, from: albumData) {
            albums = decodedAlbums
            saveAlbums()
        }

    }
    
    func saveAlbums() {
        let url = documents.appendingPathComponent(FileNames.Albums)
        let encoder = JSONEncoder()
        guard let encodedData = try? encoder.encode(albums) else {
            return
        }
        try? encodedData.write(to: url)
    }


    func getAlbums() -> [Album] {
        return albums
    }

    
    func addAlbum(_ album: Album, index: Int) {
        if albums.count >= index {
            albums.insert(album, at: index)
        } else {
            albums.append(album)
        }
    }
    
    func deleteAlbumAtIndex(_ index: Int) {
        albums.remove(at: index)
    }
    
    func saveImage(_ image: UIImage, filename: String) {
        let url = cache.appendingPathComponent(filename)
        guard let data = UIImagePNGRepresentation(image) else {
            return
        }
        try? data.write(to: url)
    }

    func getImage(with filename: String) -> UIImage? {
        let url = cache.appendingPathComponent(filename)
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
    }
    
}

