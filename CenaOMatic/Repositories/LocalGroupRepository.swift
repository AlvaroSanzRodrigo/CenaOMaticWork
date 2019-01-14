//
//  LocalGroupRepository.swift
//  CenaOMatic
//
//  Created by Alvaro Sanz Rodrigo on 22/12/2018.
//  Copyright © 2018 Alvaro Sanz Rodrigo. All rights reserved.
//

import UIKit
import RealmSwift

class LocalGroupRepository: Repository {
    
    func getAll() -> [Group] {
        var groups: [Group] = []
        do{
            let entities = try Realm().objects(GroupEntity.self).sorted(byKeyPath: "name", ascending: true)
            for entity in entities {
                let model = entity.groupModel()
                groups.append(model)
            }
        }
        catch let error as NSError {
            print("Error getAll: ", error.description)
        }
        
        return groups
    }
    
    func get(identifier: String) -> Group? {
        do {
            if let entity = try Realm().objects(GroupEntity.self).filter("name == %@", identifier).first {
                let model = entity.groupModel()
                return model
            }
        } catch {
            return nil
        }
        return nil
    }
    
    func update(a: Group) -> Bool {
        return create(a: a)
    }
    
    func remove(a: Group) -> Bool {
        do {
            try Realm().write {
                let entityToDelete = try Realm().objects(GroupEntity.self).filter("name == %@", a.name)
                try Realm().delete(entityToDelete)
            }
        } catch {
            return false
        }
        return true
    }
    
    func create(a: Group) -> Bool {
        do {
            let entity = GroupEntity(a)
            try Realm().write {
                try Realm().add(entity, update: true)
            }
        } catch {
            return false
        }
        return true
    }
}
