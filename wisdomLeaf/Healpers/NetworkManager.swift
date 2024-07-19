//
//  NetworkManager.swift
//  wisdomLeaf
//
//  Created by Darshan on 21/07/24.
//


import Foundation
import SystemConfiguration
import UIKit

class NetworkManager {
    
    static func isNetworkReachable() -> Bool {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zeroAddress.sa_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return isReachable && !needsConnection
    }

    static func handleNetworkAvailability(completion: @escaping (Bool) -> Void) {
        if isNetworkReachable() {
            if isOffline{
               
                isOffline = false
            }
            completion(true)
        } else {
            
            isOffline = true
            completion(false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                       handleNetworkAvailability(completion: completion)
                   }
        }
    }
}

// Placeholder for your API request function
func apiRequestFunction() {
    // Replace this with your actual API request logic
    print("Performing API request...")
}

// Example of calling the network manager before making an API request
func makeAPIRequest() {
    NetworkManager.handleNetworkAvailability { isReachable in
        if isReachable {
            // Network is reachable, proceed with the API request
            
            
            apiRequestFunction()
        } else {
            // Network is not reachable, handle the offline state (show an alert, etc.)
            print("No Internet Connection. Please check your internet connection.")
        }
    }
}

func dismissNetworkStatusAlert() {
    if let alert = networkStatusAlert {
        alert.dismiss(animated: true, completion: nil)
        networkStatusAlert = nil
    }
}

func showAlertWithOKButton(title: String, message: String) {
    guard  !isOfflineAlertIsPresent else {
        return
    }
    if let topViewController = UIApplication.topViewController() {
        if let existingAlert = topViewController.presentedViewController as? UIAlertController {
            existingAlert.dismiss(animated: true) {
                // Present the new alert after dismissal
                
                presentNewAlertWithOKButton(in: topViewController, title: title, message: message)
            }
        } else {
            // No existing alert, present the new alert directly
            print("alert controller present")
            presentNewAlertWithOKButton(in: topViewController, title: title, message: message)
        }
    }
}

func presentNewAlertWithOKButton(in viewController: UIViewController, title: String, message: String) {
    isOfflineAlertIsPresent = true
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        alert.dismiss(animated: true, completion: nil)
        isOfflineAlertIsPresent = false
    }
    alert.addAction(okAction)
    viewController.present(alert, animated: true, completion: nil)
    
    
    
}



