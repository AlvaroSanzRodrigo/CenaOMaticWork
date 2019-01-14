//
//  EditParticipantViewController.swift
//  CenaOMatic
//
//  Created by Alvaro Sanz Rodrigo on 11/01/2019.
//  Copyright © 2019 Alvaro Sanz Rodrigo. All rights reserved.
//

import UIKit

protocol EditParticipantDetailViewControllerDelegate: class {
    func EditParticipantDetailViewController(_ vc: EditParticipantViewController, didEditParticipant participant: Participant)
}

class EditParticipantViewController: UIViewController {
    internal var participant: Participant!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var mealsText: UITextView!
    @IBOutlet weak var addMeals: UITextField!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var savedButton: UIButton!
    
    weak var delegate: EditParticipantDetailViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewBack.layer.cornerRadius = 8.0
        viewBack.layer.masksToBounds = true
        
        savedButton.layer.cornerRadius = 8.0
        savedButton.layer.masksToBounds = true
        
        name.text = participant.name
        
        mealsText.text = ""
        for meal in participant.meals {
            mealsText.text.append(meal.title + "\n")
        }
        // Do any additional setup after loading the view.
    }
    convenience init(participant: Participant) {
        self.init()
        self.participant = participant
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.8) {
            self.view.backgroundColor =
                UIColor.white.withAlphaComponent(0.8)
        }
    }
    
    @IBAction func addMeal(_ sender: Any) {
        
        if participant.meals.count < 3{
            let meal = Meal()
            meal.title = addMeals.text
            participant.meals.append(meal)
            mealsText.text = ""
            for meal in participant.meals {
                mealsText.text.append(meal.title + "\n")
            }
        }
        
    }
    
    @IBAction func save(_ sender: Any) {
        participant.name = name.text
        delegate?.EditParticipantDetailViewController(self, didEditParticipant: self.participant)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteMeal(_ sender: Any) {
        participant.meals.remove(at: participant.meals.count-1)
        mealsText.text = ""
        for meal in participant.meals {
            mealsText.text.append(meal.title + "\n")
        }
    }
}
