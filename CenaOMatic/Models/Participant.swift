//
//  Participant.swift
//  CenaOMatic
//
//  Created by Alvaro Sanz Rodrigo on 21/12/2018.
//  Copyright © 2018 Alvaro Sanz Rodrigo. All rights reserved.
//

import Foundation

class Participant {
    var name: String!
    var isPayed: Bool!
    var meals:[Meal] = []
    var date:Date!
    
    func participantEntity() -> ParticipantEntity {
        let entity = ParticipantEntity()
        entity.name = self.name
        entity.date = self.date
        entity.isPayed = self.isPayed
        for meal in self.meals {
            entity.meals.append(meal.mealEntity())
        }
        return entity
    }
}
