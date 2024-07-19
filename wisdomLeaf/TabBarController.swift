//
//  TabBarController.swift
//  wisdomLeaf
//
//  Created by Darshan on 19/07/24.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Tab Bar Contrller")
        self.delegate = self
        
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
                  
    }
    


}
