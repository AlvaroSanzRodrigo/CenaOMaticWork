//
//  ParticipantDetailViewController.swift
//  CenaOMatic
//
//  Created by Alvaro Sanz Rodrigo on 03/01/2019.
//  Copyright © 2019 Alvaro Sanz Rodrigo. All rights reserved.
//

import UIKit

protocol EditParticipantViewControllerDelegate: class {
    func editParticipantViewController(_ vc: ParticipantDetailViewController, didEditGroup group: Group)
}

class ParticipantDetailViewController: UIViewController {
    
    internal var group: Group!
    internal var participantNumber: Int!
    internal var participant: Participant!

    @IBOutlet weak var participantHavePaid: UISwitch!
    @IBOutlet weak var participantName: UILabel!
    @IBOutlet weak var mealsTable: UITableView!
    weak var delegate: EditParticipantViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        participant = group.participants[participantNumber]
        self.participantName.text = participant.name
        participantHavePaid.isOn = participant.isPayed
        registerCells()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        group.participants[participantNumber] = participant
        delegate.editParticipantViewController(self, didEditGroup: group)
        navigationController?.popViewController(animated: true)
    }
    
    
    func registerCells(){
        let nib = UINib(nibName: "EmptyGroupTableViewCell", bundle: nil)
        mealsTable.register(nib, forCellReuseIdentifier: "EmptyGroupTableViewCell")
        let nibEmpty = UINib(nibName: "MealTableViewCell", bundle: nil)
        mealsTable.register(nibEmpty, forCellReuseIdentifier: "MealTableViewCell")
        
    }
    @IBAction func payChange(_ sender: Any) {
        participant.isPayed = participantHavePaid.isOn
    }
    
    @IBAction func edit(_ sender: Any) {
        let editVC = EditParticipantViewController(participant: self.participant)
        editVC.modalTransitionStyle = .coverVertical
        editVC.modalPresentationStyle = .overCurrentContext
        editVC.delegate = self
        present(editVC, animated: true, completion: nil)
    }
    
    convenience init(group: Group, participantNumber: Int) {
        self.init()
        self.group = group
        self.participantNumber = participantNumber
    }
}
extension ParticipantDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if participant.meals.count == 0{
            return 1
        }else {
            return participant.meals.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  participant.meals.count == 0{
            let emptyCell: EmptyGroupTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmptyGroupTableViewCell") as! EmptyGroupTableViewCell
            emptyCell.messageLabel.text = "No meals"
            return emptyCell
        }else {
            let cell: MealTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as! MealTableViewCell
            cell.nameLabel.text = participant.meals[indexPath.row].title
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

extension ParticipantDetailViewController: EditParticipantDetailViewControllerDelegate{
    func EditParticipantDetailViewController(_ vc: EditParticipantViewController, didEditParticipant participant: Participant) {
        self.participant = participant
        self.participantName.text = participant.name
        participantHavePaid.isOn = participant.isPayed
        mealsTable.reloadData()
    }
}
