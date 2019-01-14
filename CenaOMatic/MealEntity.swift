//
//  MealEntity.swift
//  CenaOMatic
//
//  Created by Alvaro Sanz Rodrigo on 21/12/2018.
//  Copyright © 2018 Alvaro Sanz Rodrigo. All rights reserved.
//

import UIKit
import RealmSwift

class MealEntity: Object {
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    
    override static func primaryKey() -> String? {
        return "title"
    }
    
    convenience init(_ meal: Meal) {
        self.init()
        self.title = meal.title
    }
    
    func mealModel() -> Meal {
        let model = Meal()
        model.title = self.title
        return model
    }

}
