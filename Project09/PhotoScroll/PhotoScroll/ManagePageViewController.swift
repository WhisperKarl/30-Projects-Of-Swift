//
//  ManagePageViewController.swift
//  PhotoScroll
//
//  Created by Karl on 2017/3/24.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class ManagePageViewController: UIPageViewController {

    var currentIndex: Int!
    var photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let viewController  = viewPhotoCommentController(index: currentIndex ?? 0) {
            let viewControllers = [viewController]
            setViewControllers(
                viewControllers,
                direction: .forward,
                animated: false,
                completion: nil
            )
        }
        
    }

    fileprivate func viewPhotoCommentController(index: Int) -> PhotoCommentViewController? {
        if let storyboard = storyboard,
            let page = storyboard.instantiateViewController(withIdentifier: "PhotoCommentViewController") as? PhotoCommentViewController{
            page.photoName = photos[index]
            page.photoIndex = index
            return page
        }
        return nil
    }
}

extension ManagePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? PhotoCommentViewController {
            guard let index = viewController.photoIndex, index != 0 else
            {
                return nil
            }
            return viewPhotoCommentController(index: index - 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? PhotoCommentViewController {
            guard let index = viewController.photoIndex , index != photos.count - 1 else
            {
                return nil
            }
            return viewPhotoCommentController(index: index + 1)
        }
        return nil
    }
    
    //MARK: UIPageControl
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return photos.count
    }
    // ??用于判断变量是否为nil 如果为nil 则赋值为??后面的参数
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex ?? 0
    }
    
}
