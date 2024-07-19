//
//  FavoritesController.swift
//  wisdomLeaf
//
//  Created by Darshan on 19/07/24.
//

import UIKit

class FavoritesController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var movieDetails: [Search] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        cellConfiguration()
        print("View Did Load")
        // Do any additional setup after loading the view.
    }
   
    override func viewDidAppear(_ animated: Bool) {
      print("View Did Appear")
        if let savedMovies: [Search] = getUserDefault(key: "movieDetails", type: [Search].self) {
               print("Retrieved movies: \(savedMovies)")
             movieDetails = savedMovies
            print("saved Movie \(savedMovies.count)")
            tableView.reloadData()
           } else {
               print("No movies found in UserDefaults")
           }
       
    }
    
   
    
    private func cellConfiguration(){
        print("Cell Configuration")
        tableView.register(favoritesTableViewCell, forCellReuseIdentifier: "idFavoritesTableViewCell")
        tableView.register(favoritesHeaderTableViewCell, forCellReuseIdentifier: "idFavoritesHeaderTableViewCell")
    }
    


}
extension FavoritesController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return movieDetails.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idFavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell
        cell.movieName.text = movieDetails[indexPath.row].title
        cell.movieTitle.text = movieDetails[indexPath.row].year
        cell.movieStar.text = ""
        cell.setMovieImage(url: movieDetails[indexPath.row].poster)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idFavoritesHeaderTableViewCell") as! FavoritesHeaderTableViewCell
       
        return cell
    }

}
