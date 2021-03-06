//
//  ViewController.swift
//  Project15
//
//  Created by Chandran, Sudha on 26/12/21.
//

import UIKit

class ViewController: UIViewController {
    var imageView: UIImageView!
    var currentAnimation = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)

    }

    @IBAction func tapped(_ sender: UIButton) {
        sender.isHidden = true

        UIView.animateKeyframes(withDuration: 1,
                                delay: 0,
                                options: [],
                                animations: {
                                    switch self.currentAnimation {
                                    case 0:
                                        self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                                        break
                                    default:
                                        self.imageView.transform = .identity
                                        break
                                    }
                                },
                                completion: { finished in
                                    sender.isHidden = false

                                })
        currentAnimation += 1

        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }

}

