//
//  ViewController.swift
//  Example
//
//  Created by Harvey on 2021/5/9.
//

import UIKit
import ImageCG

class ViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView1.image = UIColor.red.icg.image(.init(width: 200, height: 100))
        imageView2.image = [UIColor.blue, UIColor.red, UIColor.yellow].icg.linearGradient(.init(width: 200, height: 100), direction: .diagonally)
        imageView3.image = [UIColor.blue, UIColor.red, UIColor.yellow].icg.radialGradient(.init(width: 100, height: 100))
        
        let image = UIImage(named: "1")
        imageView4.contentMode = .scaleAspectFit
        imageView4.image = image!.icg.add("2")
    }
}

