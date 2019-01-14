//
//  GroupViewController.swift
//  CenaOMatic
//
//  Created by Alvaro Sanz Rodrigo on 22/12/2018.
//  Copyright © 2018 Alvaro Sanz Rodrigo. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {
    internal var groups:[Group] = []
    internal var repository = LocalGroupRepository()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Groups"
        registerCells()
        groups = repository.getAll()
        setupBarButtonsItems()
        
        // Do any additional setup after loading the view.
    }
    
    func registerCells(){
        let nib = UINib(nibName: "GroupTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "GroupTableViewCell")
        
        let nibEmpty = UINib(nibName: "EmptyGroupTableViewCell", bundle: nil)
        tableView.register(nibEmpty, forCellReuseIdentifier: "EmptyGroupTableViewCell")
    }
    
    private func setupBarButtonsItems(){
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        navigationItem.setRightBarButton(addButton, animated: true)
    }
    
    @objc internal func addPressed(){
        let addVC = AddGroupViewController(group: nil)
        addVC.delegate = self
        addVC.modalTransitionStyle = .coverVertical
        addVC.modalPresentationStyle = .overCurrentContext
        present(addVC, animated: true, completion: nil)
    }
}

extension GroupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if groups.count == 0 {
            return 1
        }else {
             return groups.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if groups.count == 0 {
            let emptyCell: EmptyGroupTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmptyGroupTableViewCell") as! EmptyGroupTableViewCell
            return emptyCell
        }else {
            let cell: GroupTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell
            cell.nameLabel.text = groups[indexPath.row].name
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let participantVC = ParticipantsViewController(group: groups[indexPath.row])
        
        var meals: [Meal] = []
        
        for participant in groups[indexPath.row].participants {
            for meal in participant.meals{
                meals.append(meal)
            }
            
        }
        
        let mealsVC = MealsViewController(meals: meals)
        let tabVC = UITabBarController()
        
        tabVC.viewControllers = [participantVC, mealsVC]
        
        navigationController?.pushViewController(tabVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if groups.count == 0{
        }else {
            if editingStyle == .delete {
                let group = groups[indexPath.row]
                if repository.remove(a: group) {
                    groups.remove(at: indexPath.row)
                    tableView.beginUpdates()
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    tableView.endUpdates()
                }
            }
        }
    }
}

extension GroupViewController: AddGroupViewControllerDelegate{
    func addGroupViewController(_ vc: AddGroupViewController, didEditGroup group: Group) {
        if repository.create(a: group) {
            groups = repository.getAll()
            tableView.reloadData()
        }
        vc.dismiss(animated: true, completion: nil)
    }
}
