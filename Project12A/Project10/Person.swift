//
//  Person.swift
//  Project10
//
//  Created by Chandran, Sudha on 26/12/21.
//

import UIKit

class Person: NSObject, NSCoding {
    var name: String
    var image: String

    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        image = coder.decodeObject(forKey: "image") as? String ?? ""
    }

    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(image, forKey: "image")
    }

    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
