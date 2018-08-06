
//
//  AlbumView.swift
//  Project18-BlueLibrarySwift
//
//  Created by Life's a struggle on 2018/8/5.
//  Copyright © 2018年 Karl. All rights reserved.
//

import UIKit

class AlbumView: UIView {
    private var coverImageView: UIImageView!
    private var indicatorView: UIActivityIndicatorView!
    private var valueObservation: NSKeyValueObservation!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commmonInit()
    }
    
    init(frame: CGRect, converUrl: String) {
        super.init(frame: frame)
        commmonInit()
        
        NotificationCenter.default.post(name: .BLDownloadImage, object: nil, userInfo: ["imageView": coverImageView, "coverUrl": converUrl])
    }
    
    
    private func commmonInit() {
        backgroundColor = .black
        
        coverImageView = UIImageView()
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(coverImageView)
        
        indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.activityIndicatorViewStyle = .whiteLarge
        indicatorView.startAnimating()
        addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            coverImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            coverImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ]
        )
        
        valueObservation = coverImageView.observe(\.image, options: [.new]) { [unowned self] observed, change in
            if change.newValue is UIImage {
                self.indicatorView.stopAnimating()
            }
        }
    }
    
    func highlightAlbum(_ didHighlightView: Bool) {
        if didHighlightView == true {
            backgroundColor = .white
        } else {
            backgroundColor = .black
        }
    }
    
    
    
    }

extension Notification.Name {
    static let BLDownloadImage = Notification.Name(downloadImageNotification)
}
