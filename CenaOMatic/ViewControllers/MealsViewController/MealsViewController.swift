//
//  MealsViewController.swift
//  CenaOMatic
//
//  Created by Alvaro Sanz Rodrigo on 14/01/2019.
//  Copyright © 2019 Alvaro Sanz Rodrigo. All rights reserved.
//

import UIKit

class MealsViewController: UIViewController {
    
    var meals: [Meal]!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meals"
        registerCells()
    }
    
    convenience init(meals:[Meal]) {
        self.init()
        self.meals = meals
    }
    
    func registerCells(){
        let nib = UINib(nibName: "EmptyGroupTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EmptyGroupTableViewCell")
        let nibEmpty = UINib(nibName: "MealTableViewCell", bundle: nil)
        tableView.register(nibEmpty, forCellReuseIdentifier: "MealTableViewCell")
        
    }


}
extension MealsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if meals.count == 0{
            return 1
        }else {
            return meals.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if meals.count == 0{
            let emptyCell: EmptyGroupTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmptyGroupTableViewCell") as! EmptyGroupTableViewCell
            emptyCell.messageLabel.text = "No meals yet"
            return emptyCell
        }else {
            let cell: MealTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as! MealTableViewCell
            cell.nameLabel.text = meals[indexPath.row].title
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}
