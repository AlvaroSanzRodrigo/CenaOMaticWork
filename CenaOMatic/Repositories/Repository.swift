//
//  Repository.swift
//  CenaOMatic
//
//  Created by Alvaro Sanz Rodrigo on 21/12/2018.
//  Copyright © 2018 Alvaro Sanz Rodrigo. All rights reserved.
//

import Foundation

protocol Repository {
    associatedtype T
    
    func getAll() -> [T]
    func get(identifier: String) -> T?
    func update(a: T) -> Bool
    func remove(a: T) -> Bool
    func create(a: T) -> Bool
}
