//
//  ViewController.swift
//  Project18
//
//  Created by Chandran, Sudha on 27/12/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("I'm inside view did load method")
        print(1,2,3,4,5, separator: "-")
        print(1,2,3,4,5, terminator: "~")
        print("some message", terminator: "~")

        for i in 1 ... 100 {
            print("Got number \(i)")
        }

        assert(1 == 1, "Math failure!")
        assert(1 == 2, "Math failure!")

        assert(myReallySlowMethod() == true, "The slow method returned false, which is a bad thing!")

    }

    func myReallySlowMethod() -> Bool {
        return false
    }

}

