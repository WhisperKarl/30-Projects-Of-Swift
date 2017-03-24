//
//  PhotoCommentViewController.swift
//  PhotoScroll
//
//  Created by Karl on 2017/3/24.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class PhotoCommentViewController: UIViewController {

    public var photoName: String!
    public var photoIndex: Int!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let photoName = photoName {
            imageView.image = UIImage.init(named: photoName)
        }
        
        
        
    }
    
    fileprivate func adjustInsetForKeyboard(isShow: Bool, notification: Notification) {
        guard let value = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {
            return
        }
        let keyboardFrame = value.cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 20) * (isShow ? 1 : -1)
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    

}
