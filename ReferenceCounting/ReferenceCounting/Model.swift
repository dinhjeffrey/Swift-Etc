//
//  Model.swift
//  ReferenceCounting
//
//  Created by jeffrey dinh on 6/30/16.
//  Copyright © 2016 jeffrey dinh. All rights reserved.
//

import Foundation

class Model {
    
    static var key = String()
    
    func add(num1: Double, num2: Double, closure: (String) -> (String))  {
        dictionary["storedString"] = closure(Model.key)
    }
    var dictionary: [String: String] = ["storedString":"poke"]
}
