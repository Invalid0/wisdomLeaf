//
//  Macros.swift
//  wisdomLeaf
//
//  Created by Darshan on 19/07/24.
//

import Foundation
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let appDelegateKeyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
let window = UIWindow(frame: UIScreen.main.bounds)
let storyboard = UIStoryboard(name: "Main", bundle: nil)
let uiTabBarController: UITabBarController = storyboard.instantiateViewController(withIdentifier: "idTabBarController") as! UITabBarController
let spalshScreenController = storyboard.instantiateViewController(withIdentifier: "idSpalshScreenController") as! SpalshScreenController
let movieDetailsController = storyboard.instantiateViewController(withIdentifier: "idMovieDetailsController") as! MovieDetailsController

let movieCollectionViewCell = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
let movieTableViewCell = UINib(nibName: "MovieTableViewCell", bundle: nil)
let favoritesTableViewCell = UINib(nibName: "FavoritesTableViewCell", bundle: nil)
let favoritesHeaderTableViewCell = UINib(nibName: "FavoritesHeaderTableViewCell", bundle: nil)

// MARK: - Dynamic Table Height
func getTableHeight() -> [Double]{
    return [280,280,280,280,280,280]
}
func getTableCount() -> [Int]{
    return [1,2,3,2,2,1]
}

var isOffline = false
var networkStatusAlert: UIAlertController?
var isOfflineAlertIsPresent = false
func data() -> [Double]{
    return [3, 4, 5, 6, 6]
}
func movieName() -> [String: Any]{
    return ["Action":["Don","Heart of Stone","Lift","Everything Everywhere All at Once"], "War":["Civil War","Saving Private Ryan"],"Drama":["Pushpa"],"God":["Kantara"],"Sci-fi":["Interstellar"]]
}

enum APIBaseURL :String {
    case baseURL = "https://www.omdbapi.com/?"
}
enum ApiEndpoint: String{
    case apiKey = "apikey=851c34fb"
    case typr = "&type="
    case subType = "&s="
}
protocol SetProfileImageApi: AnyObject{
    func getimageProfileUrl(url: String)
}

func setUserDefault<T: Codable>(data: T, key: String) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(data) {
        UserDefaults.standard.set(encoded, forKey: key)
    }
}

func getUserDefault<T: Codable>(key: String, type: T.Type) -> T? {
    if let savedData = UserDefaults.standard.data(forKey: key) {
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: savedData)
    }
    return nil
}

