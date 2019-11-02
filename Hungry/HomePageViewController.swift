//
//  HomePageViewController.swift
//  Hungry
//
//  Created by uxd on 25/10/19.
//  Copyright © 2019 uxd. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        
        let story = UIStoryboard(name: "Main", bundle: Bundle.main)
        let info = story.instantiateViewController(withIdentifier: "mainPage")
        present(info, animated: true)
    }
}
