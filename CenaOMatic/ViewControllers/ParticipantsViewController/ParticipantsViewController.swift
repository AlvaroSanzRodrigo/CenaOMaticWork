//
//  ParticipantsViewController.swift
//  CenaOMatic
//
//  Created by Alvaro Sanz Rodrigo on 24/12/2018.
//  Copyright © 2018 Alvaro Sanz Rodrigo. All rights reserved.
//

import UIKit

class ParticipantsViewController: UIViewController {
    
    internal var group: Group!
    internal var repository = LocalGroupRepository()
    internal var payed: [Participant] = []
    internal var aux_participant: [Participant] = []
    @IBOutlet weak var filter: UISwitch!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupBarButtonsItems()
        title = "Participants"
    }
    
    convenience init(group: Group) {
        self.init()
        self.group = group
    }
    
    @IBAction func filter(_ sender: Any) {
        
        if filter.isOn {
            payed = group.participants.filter { (Participant) -> Bool in
                return Participant.isPayed
            }
            aux_participant = group.participants
            group.participants = payed
            tableView.reloadData()
        }else {
            group.participants = aux_participant
            tableView.reloadData()
        }
    }
    
    func registerCells(){
        let nib = UINib(nibName: "ParticipantTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ParticipantTableViewCell")
        let nibEmpty = UINib(nibName: "EmptyGroupTableViewCell", bundle: nil)
        tableView.register(nibEmpty, forCellReuseIdentifier: "EmptyGroupTableViewCell")
    }
    
    private func setupBarButtonsItems(){
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        navigationItem.setRightBarButton(addButton, animated: true)
    }
    
    @objc internal func addPressed(){
        let addVC = AddParticipantViewController(participant: nil)
        addVC.delegate = self
        addVC.modalTransitionStyle = .coverVertical
        addVC.modalPresentationStyle = .overCurrentContext
        present(addVC, animated: true, completion: nil)
    }
}

extension ParticipantsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if group.participants.count == 0{
            return 1
        }else {
            return group.participants.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if group.participants.count == 0{
            let emptyCell: EmptyGroupTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmptyGroupTableViewCell") as! EmptyGroupTableViewCell
            emptyCell.messageLabel.text = "Tap the + button to add a participant"
            return emptyCell
        }else {
            let cell: ParticipantTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ParticipantTableViewCell", for: indexPath) as! ParticipantTableViewCell
            cell.participantName.text = group.participants[indexPath.row].name
            if group.participants[indexPath.row].isPayed {
                cell.isPayed.image = UIImage(named: "ok")
            }else {
                 cell.isPayed.image = UIImage(named: "nope")
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let participantDetailVC = ParticipantDetailViewController(group: self.group, participantNumber: indexPath.row)
        participantDetailVC.delegate = self
        navigationController?.pushViewController(participantDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if group.participants.count == 0{
        }else {
            if editingStyle == .delete {
                
                if repository.update(a: self.group) {
                    self.group.participants.remove(at: indexPath.row)
                    tableView.beginUpdates()
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    tableView.endUpdates()
                }
                }
            }
        }
    }

extension ParticipantsViewController: AddParticipantViewControllerDelegate{
    func addParticipantViewController(_ vc: AddParticipantViewController, didEditParticipant participant: Participant) {
        if group.participants.count == 0 {
            group.participants = []
        }
        group.participants.append(participant)
        if repository.create(a: group) {
            tableView.reloadData()
        }
        vc.dismiss(animated: true, completion: nil)
    }
}

extension ParticipantsViewController: EditParticipantViewControllerDelegate{
    func editParticipantViewController(_ vc: ParticipantDetailViewController, didEditGroup group: Group) {
        self.group = group
        if repository.create(a: self.group){	
            tableView.reloadData()
        }
    }
}
