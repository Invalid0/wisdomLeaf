//
//  FavoritesTableViewCell.swift
//  wisdomLeaf
//
//  Created by Darshan on 19/07/24.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieStar: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setMovieImage(url: String) {
        ApiManager.shared.loadImage(iconURL: url, imageView: self.movieImage)

    }

    
}
