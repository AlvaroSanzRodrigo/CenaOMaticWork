//
//  LocalMealRepository.swift
//  CenaOMatic
//
//  Created by Alvaro Sanz Rodrigo on 21/12/2018.
//  Copyright © 2018 Alvaro Sanz Rodrigo. All rights reserved.
//

import UIKit
import RealmSwift

class LocalMealRepository: Repository {
    
    
    
    func getAll() -> [Meal] {
        var meals: [Meal] = []
        do{
            let entities = try Realm().objects(MealEntity.self).sorted(byKeyPath: "title", ascending: true)
            for entity in entities {
                let model = entity.mealModel()
                meals.append(model)
            }
        }
        catch let error as NSError {
            print("Error getAll Tasks: ", error.description)
        }
        
        return meals
    }
    
    func get(identifier: String) -> Meal? {
        do {
            if let entity = try Realm().objects(MealEntity.self).filter("title == %@", identifier).first {
                let model = entity.mealModel()
                return model
            }
        } catch {
            return nil
        }
        return nil
    }
    
    func update(a: Meal) -> Bool {
        return create(a: a)
    }
    
    func remove(a: Meal) -> Bool {
        do {
            try Realm().write {
                let entityToDelete = try Realm().objects(MealEntity.self).filter("title == %@", a.title)
                try Realm().delete(entityToDelete)
            }
        } catch {
            return false
        }
        return true
    }
    
    func create(a: Meal) -> Bool {
        do {
            let entity = MealEntity(a)
            try Realm().write {
                try Realm().add(entity, update: true)
            }
        } catch {
            return false
        }
        return true
    }


}

