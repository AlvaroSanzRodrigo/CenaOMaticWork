//
//  Meal.swift
//  CenaOMatic
//
//  Created by Alvaro Sanz Rodrigo on 21/12/2018.
//  Copyright © 2018 Alvaro Sanz Rodrigo. All rights reserved.
//

import UIKit

class Meal {
    var title: String!
    
    func mealEntity() -> MealEntity {
        var entity = MealEntity()
        entity.title = self.title
        return entity
    }
}
