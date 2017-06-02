//
//  FirstViewController.swift
//  Exile
//
//  Created by Exile Soluciones Tecnológicas on 30/05/17.
//  Copyright © 2017 Exile Soluciones. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let tabItems = self.tabBarController?.tabBar.items as NSArray!
        let tabItem = tabItems?[1] as! UITabBarItem
        tabItem.badgeValue = "1"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

