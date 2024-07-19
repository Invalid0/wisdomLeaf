//
//  DashboardController.swift
//  wisdomLeaf
//
//  Created by Darshan on 19/07/24.
//

import UIKit

class DashboardController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var tableViewHeight = [Double]()
    var movieDetails:[String: Any] = [String: Any]()
    var count = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view Did Load")
        callMovieApi()
        tableViewHeight = getTableHeight()
        uiConfiguration()
        cellConfiguration()
    }
    override func viewWillAppear(_ animated: Bool) {
        print("View Will Appear")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("view did Appear")
    }
    
    private func uiConfiguration(){
        print("Dashboard")
        tableView.delegate = self
        tableView.dataSource = self;
        searchBar.delegate = self
        searchBar.showsCancelButton = true
    }
    private func callMovieApi(){
        callApi()
    }
    
    private func cellConfiguration(){
        print("Cell Configuration")
        tableView.register(movieTableViewCell, forCellReuseIdentifier: "idMovieTableViewCell")
    }
    private func callApi(movieName: String = "Don"){
        let restUrl = APIBaseURL.baseURL.rawValue + ApiEndpoint.apiKey.rawValue + ApiEndpoint.typr.rawValue + "movie" + ApiEndpoint.subType.rawValue + movieName
        ApiManager.shared.makeAlamofireRequest(url: restUrl) { (movieDetails: Movie) in
            MovieService.share.setMovieList(movieList: [movieDetails])
            print("Movie Json = \(movieDetails)")
            self.tableView.reloadData()
            self.count += 1
            print("callApi = \(self.count)")
        } invalid: { (invalidJson: InvalidResponse) in
            print("Invalid Json = \(invalidJson)")
        } failure: { erro in
            print("")
        }
    }

}

extension DashboardController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movieDetails = MovieService.share.getMovieList(){
            return movieDetails[0].search.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idMovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let index = indexPath.row
        cell.movieImage.image = UIImage(systemName: "")
        cell.favBtn.tag = index
        cell.favBtn.addTarget(self, action: #selector(favActionBtn(_ :)), for: .touchUpInside)
        if let movieDetails = MovieService.share.getMovieList(){
             let details = movieDetails[0].search
            cell.movieName.text = details[index].title
            cell.movieName_1.text = details[index].title
            cell.setMovieImage(url: details[index].poster)
            cell.movieTitle.text = details[index].year
           
        }
        
        return cell;
    }
    @objc func favActionBtn(_ sender: UIButton) {
        print("fav Btn Clicked")
        
        if let value = MovieService.share.getMovieList() {
            let details = value[0].search[sender.tag]
            print("details = \(details)")
            var savedMovies: [Search] = []
            if let existingMovies: [Search] = getUserDefault(key: "movieDetails", type: [Search].self) {
                savedMovies = existingMovies
            }

            if !savedMovies.contains(where: { $0.imdbID == details.imdbID }) {
                savedMovies.append(details)
                setUserDefault(data: savedMovies, key: "movieDetails")
            } else {
                print("Movie already saved")
            }
        }
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idMovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.selectedBackgroundView?.backgroundColor = UIColor.black
        if let value = MovieService.share.getMovieList() {
            let details = value[0].search[indexPath.row]
            movieDetailsController.movieDeatils = [details]
            self.modalPresentationStyle = .fullScreen
            self.present(movieDetailsController, animated: true, completion: nil)
        }
    }
    
}

extension DashboardController: UISearchBarDelegate{
    // MARK: UISearchBarDelegate methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
          print("searchText \(searchBar.text)")
        if let searchText = searchBar.text, !searchText.isEmpty{
            callApi(movieName: searchText)
            
        }
        else{
            callApi()
        }
        tableView.reloadData()
        searchBar.resignFirstResponder()
      }
}
