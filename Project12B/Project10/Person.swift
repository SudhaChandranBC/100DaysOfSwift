//
//  Person.swift
//  Project10
//
//  Created by Chandran, Sudha on 26/12/21.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String

    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
