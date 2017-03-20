//
//  DetailViewController.swift
//  Todo
//
//  Created by Karl on 2017/3/20.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var todo: TodoItem?
    
    @IBOutlet weak var travelBtn: UIButton!
    @IBOutlet weak var shoppingcaryBtn: UIButton!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var childBtn: UIButton!
    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var todoDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if todo == nil {
            self.navigationItem.title = "New Todo"
            childBtn.isSelected = true
        } else {
            self.navigationItem.title = "Edit Todo"
            switch todo!.image {
            case "child-selected":
                childBtn.isSelected = true
            case "phone-selectd":
                phoneBtn.isSelected = true
            case "shaopping-cart-selectd":
                shoppingcaryBtn.isSelected = true
            default:
                travelBtn.isSelected = true
            }
            
            todoTextField.text = todo?.title
            todoDatePicker.setDate((todo?.date)! as Date, animated: false)
        }
        
    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectedChild(_ sender: Any) {
        resetBtn()
        childBtn.isSelected = true
    }
    
    @IBAction func selectedPhone(_ sender: Any) {
        resetBtn()
        phoneBtn.isSelected = true
    }
    
    @IBAction func selectedShoppingCart(_ sender: Any) {
        resetBtn()
        shoppingcaryBtn.isSelected = true
    }
    @IBAction func selectedTravel(_ sender: Any) {
        resetBtn()
        travelBtn.isSelected = true
    }
    
    @IBAction func confirmBtn(_ sender: Any) {
        var image = ""
        
        if childBtn.isSelected {
            image = "child-selected"
        }
        else if phoneBtn.isSelected {
            image = "phone-selected"
        }
        else if shoppingcaryBtn.isSelected {
            image = "shopping-cart-selected"
        }
        else if travelBtn.isSelected {
            image = "travel-selected"
        }

        if todo == nil {
            let uuid = UUID().uuidString
            todo = TodoItem.init(id: uuid, image: image, title: todoTextField.text!, date: todoDatePicker.date)
            todos.append(todo!)
        } else {
            todo?.image = image
            todo?.title = todoTextField.text!
            todo?.date = todoDatePicker.date
        }
        
       let _ = navigationController?.popToRootViewController(animated: true)
        
    }
    
    fileprivate func resetBtn () {
        childBtn.isSelected = false
        phoneBtn.isSelected = false
        shoppingcaryBtn.isSelected = false
        travelBtn.isSelected = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

}
