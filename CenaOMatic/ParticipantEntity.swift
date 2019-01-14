//
//  ParticipantEntity.swift
//  CenaOMatic
//
//  Created by Alvaro Sanz Rodrigo on 21/12/2018.
//  Copyright © 2018 Alvaro Sanz Rodrigo. All rights reserved.
//

import Foundation
import RealmSwift

class ParticipantEntity: Object {

    @objc dynamic var name = ""
    @objc dynamic var isPayed = false
    var meals: List<MealEntity> = List<MealEntity>()
    @objc dynamic var date:Date = Date()
    override static func primaryKey() -> String? {
        return "name"
    }
    
    convenience init(_ participant: Participant) {
        self.init()
        self.name = participant.name
        self.isPayed = participant.isPayed
        self.date = participant.date
        for meal in participant.meals {
            self.meals.append(meal.mealEntity())
        }
    }

    func participantModel() -> Participant {
        let model = Participant()
        model.name = self.name
        model.isPayed = self.isPayed
        model.date = self.date
        for meal in meals {
            model.meals.append(meal.mealModel())
        }
        return model
    }
}
