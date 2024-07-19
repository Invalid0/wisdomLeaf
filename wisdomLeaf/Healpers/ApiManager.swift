//
//  ApiManager.swift
//  wisdomLeaf
//
//  Created by Darshan on 21/07/24.
//

import Foundation
import Alamofire
class ApiManager {
    static let shared = ApiManager()
    var json: (([String: Any]) -> Void)?
    
    func makeAlamofireRequest<T: Codable, E: Codable>(
        url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        success: @escaping (T) -> Void,
        invalid: @escaping (E) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        print("Api Method calling")
        NetworkManager.handleNetworkAvailability { isReachable in
            if isReachable{
                print("pramater = \(parameters)")
                print("Url ==> \(url)")
                Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { response in
                    switch response.result {
                    case .success:
                        do {
                            let decoder = JSONDecoder()
                            if response.response?.statusCode == 200 {
                                let result = try decoder.decode(T.self, from: response.data!)
                                success(result)
                            } else {
                                let errorResponse = try decoder.decode(E.self, from: response.data!)
                                invalid(errorResponse)
                            }
                        } catch {
                            failure(error)
                        }
                    case .failure(let error):
                        failure(error)
                    }
                }
            }
            else{
                print("Network is Not connected")
                showAlertWithOKButton(title: "Connection Failed", message: "check your internet connection")
            }
        }
    }
    
    func loadImage(iconURL: String, imageView: UIImageView) {
            guard let imageURL = URL(string: iconURL) else {
                // Handle the case when the URL is invalid
                
                print("Error: Invalid URL")
                return
            }

            // Use Alamofire to download the image asynchronously
        Alamofire.request(imageURL).responseData { response in
                switch response.result {
                case .success(let data):
                     
                    // Create UIImage from the downloaded data
                    if let image = UIImage(data: data)?.withRenderingMode(.alwaysOriginal) {
                        let squaredImage = resizeImage(image: image, targetSize: CGSize(width: 200, height: 200))

                        // Update UI on the main thread
                        DispatchQueue.main.async {
                            imageView.image = image
                        }
                    } else {
                        // Handle the case when the data cannot be converted to an image
                        print("Error: Unable to convert data to UIImage")
                    }

                case .failure(let error):
                    // Handle the error
                    print("Error: \(error.localizedDescription)")
                }
            }
        }

}
func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size

    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height

    let newSize: CGSize
    if widthRatio > heightRatio {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }

    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    // Ensure that the new image has a rendering mode set to .alwaysTemplate
    return newImage?.withRenderingMode(.alwaysTemplate) ?? UIImage()
}
