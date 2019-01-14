//
//  LocalParticipantRepository.swift
//  CenaOMatic
//
//  Created by Alvaro Sanz Rodrigo on 21/12/2018.
//  Copyright © 2018 Alvaro Sanz Rodrigo. All rights reserved.
//

import UIKit
import RealmSwift

class LocalParticipantRepository: Repository {
    
    
    func getAll() -> [Participant] {
        var participants: [Participant] = []
        do{
            let entities = try Realm().objects(ParticipantEntity.self).sorted(byKeyPath: "date", ascending: true)
            for entity in entities {
                let model = entity.participantModel()
                participants.append(model)
            }
        }
        catch let error as NSError {
            print("Error getAll: ", error.description)
        }
        
        return participants
    }
    
    func get(identifier: String) -> Participant? {
        do {
            if let entity = try Realm().objects(ParticipantEntity.self).filter("name == %@", identifier).first {
                let model = entity.participantModel()
                return model
            }
        } catch {
            return nil
        }
        return nil
    }
    
    func update(a: Participant) -> Bool {
        return create(a: a)
    }
    
    func remove(a: Participant) -> Bool {
        do {
            try Realm().write {
                let entityToDelete = try Realm().objects(ParticipantEntity.self).filter("name == %@", a.name)
                try Realm().delete(entityToDelete)
            }
        } catch {
            return false
        }
        return true
    }
    
    func create(a: Participant) -> Bool {
        do {
            let entity = ParticipantEntity(a)
            try Realm().write {
                try Realm().add(entity, update: true)
            }
        } catch {
            return false
        }
        return true
    }
}
