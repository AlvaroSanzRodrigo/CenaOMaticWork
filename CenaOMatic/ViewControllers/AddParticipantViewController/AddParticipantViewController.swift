//
//  AddParticipantViewController.swift
//  CenaOMatic
//
//  Created by Alvaro Sanz Rodrigo on 30/12/2018.
//  Copyright © 2018 Alvaro Sanz Rodrigo. All rights reserved.
//

import UIKit

protocol AddParticipantViewControllerDelegate: class {
    func addParticipantViewController(_ vc: AddParticipantViewController, didEditParticipant participant: Participant)
}

class AddParticipantViewController: UIViewController {

    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var isPayed: UISwitch!
    internal var participant: Participant!
    weak var delegate: AddParticipantViewControllerDelegate!
    
    convenience init(participant: Participant?) {
        self.init()
        if participant == nil {
            self.participant = Participant()
            self.participant!.name = ""
            self.participant!.date = Date()
            self.participant!.meals = []
            self.participant!.isPayed = false
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
        self.participant.name = self.nameTextField.text!
        self.participant.isPayed = self.isPayed.isOn
        delegate.addParticipantViewController(self, didEditParticipant: participant)
        dismiss(animated: true, completion: nil)
    }
    
    
}
