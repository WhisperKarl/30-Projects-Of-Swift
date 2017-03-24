//
//  CollectionViewController.swift
//  PhotoScroll
//
//  Created by Karl on 2017/3/24.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    fileprivate let reuseIdentifier = "PhotoCell"
    fileprivate let minSize: CGFloat = 70.0
    fileprivate let sectionInsets = UIEdgeInsets.init(top: 10, left: 5.0, bottom: 10, right: 5.0)
    fileprivate let photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
    
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        let fullSizedImage = UIImage.init(named: photos[indexPath.row])
        cell.photoImage.image = fullSizedImage
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell,
            let  indexPath = collectionView?.indexPath(for: cell),
            let managePageViewController = segue.destination as? ManagePageViewController{
            managePageViewController.currentIndex = indexPath.row
        }
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: minSize, height: minSize)
    }
    
    
}
