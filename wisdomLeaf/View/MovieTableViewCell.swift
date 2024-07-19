//
//  MovieTableViewCell.swift
//  wisdomLeaf
//
//  Created by Darshan on 19/07/24.
//

import UIKit
class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieName_1: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet var movieImage: UIImageView!
    var viewController: UIViewController? = nil
    var tableindex = 0
    var moviesDetail = moviesDetails()
    var setProfileImageApiDelegate: SetProfileImageApi!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    func setText(movieName_1: String, movieTitle: String, movieName: String){
        self.movieName_1.text = movieName_1
        self.movieTitle.text = movieTitle
        self.movieName.text = movieName
    }
    func setUI(){
        containerView.layer.cornerRadius = 10.0
        containerView.layer.cornerRadius = 10.0
        containerView.layer.borderColor = UIColor.white.cgColor 
        containerView.layer.borderWidth = 2.0
        containerView.layer.masksToBounds = true
    }
 
    func setMovieImage(url: String) {
        ApiManager.shared.loadImage(iconURL: url, imageView: self.movieImage)
    }
    
    

}


