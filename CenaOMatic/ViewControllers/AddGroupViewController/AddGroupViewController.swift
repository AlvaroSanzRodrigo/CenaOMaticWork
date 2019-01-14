//
//  AddGroupViewController.swift
//  CenaOMatic
//
//  Created by Alvaro Sanz Rodrigo on 22/12/2018.
//  Copyright © 2018 Alvaro Sanz Rodrigo. All rights reserved.
//

import UIKit

protocol AddGroupViewControllerDelegate: class {
    func addGroupViewController(_ vc: AddGroupViewController, didEditGroup group: Group)
}

class AddGroupViewController: UIViewController {

    
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    internal var group: Group!
    weak var delegate: AddGroupViewControllerDelegate!
    
    convenience init(group: Group?) {
        self.init()
        if group == nil {
            self.group = Group()
            self.group!.name = ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.8) {
            self.view.backgroundColor =
                UIColor.white.withAlphaComponent(0.8)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBack.layer.cornerRadius = 8.0
        viewBack.layer.masksToBounds = true
        
        saveButton.layer.cornerRadius = 8.0
        saveButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }

    @IBAction func exitPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addPressed(_ sender: Any) {
        self.group.name = self.nameTextField.text!
        delegate.addGroupViewController(self, didEditGroup: group)
        dismiss(animated: true, completion: nil)
    }
    
   
    
}
