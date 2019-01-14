//
//  GroupEntity.swift
//  CenaOMatic
//
//  Created by Alvaro Sanz Rodrigo on 22/12/2018.
//  Copyright © 2018 Alvaro Sanz Rodrigo. All rights reserved.
//

import UIKit
import RealmSwift

class GroupEntity: Object {
    @objc dynamic var name = ""
    var participants: List<ParticipantEntity> = List<ParticipantEntity>()
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    convenience init(_ group: Group) {
        self.init()
        self.name = group.name
            for participant in group.participants {
                self.participants.append(participant.participantEntity())
            }        
    }
    
    func groupModel() -> Group {
        let model = Group()
        model.name = self.name
        for participant in self.participants {
            model.participants.append(participant.participantModel())
        }
        return model
    }
}
