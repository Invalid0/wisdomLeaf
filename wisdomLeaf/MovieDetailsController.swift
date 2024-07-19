//
//  MovieDetailsController.swift
//  wisdomLeaf
//
//  Created by Darshan on 19/07/24.
//

import UIKit

class MovieDetailsController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var releseDate: UILabel!
    var movieDeatils:[Search] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Movie Details")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !movieDeatils.isEmpty{
            setUI()
        }
    }
    
    
    func setUI(){
        setMovieImage(url: movieDeatils[0].poster)
        movieName.text = movieDeatils[0].title
        releseDate.text = movieDeatils[0].year
    }
    
    func setMovieImage(url: String) {
        ApiManager.shared.loadImage(iconURL: url, imageView: self.imageView)

    }

    

 
}
