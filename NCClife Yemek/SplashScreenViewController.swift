//
//  SplashScreenViewController.swift
//  NCClife Yemek
//
//  Created by Serdar Güzel on 24.09.2017.
//  Copyright © 2017 Serdar Güzel. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("test")
        
        self.performSegue(withIdentifier: "Test", sender: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
