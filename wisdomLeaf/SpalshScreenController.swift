//
//  SpalshScreenController.swift
//  wisdomLeaf
//
//  Created by Darshan on 19/07/24.
//

import UIKit
class SpalshScreenController: UIViewController {

  
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Spalsh Screen")
        setUI()
       
    }
    
    private func setUI(){
        callingNextViewController()
        
    }
    private func callingNextViewController(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            appDelegate.window?.rootViewController =  uiTabBarController
            appDelegate.window?.makeKeyAndVisible()
            uiTabBarController.selectedIndex = 0
            print("uiTabar Index = \(uiTabBarController.selectedIndex)")
        }
    }

}
