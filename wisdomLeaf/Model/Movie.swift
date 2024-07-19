//
//  Movie.swift
//  wisdomLeaf
//
//  Created by Darshan on 22/07/24.
//

import Foundation
// MARK: - Movie
struct Movie: Codable {
    let search: [Search]
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - Search
struct Search: Codable {
    let title, year, imdbID: String
    let type: TypeEnum
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
}
func getSearchDict(data: Search)-> [String: Any]{
    return[data.imdbID: data.imdbID]
}


// MARK: - InvalidResponse
struct InvalidResponse: Codable {
    let response, error: String

    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case error = "Error"
    }
}

typealias movies = [String: Movie]
typealias moviesDetails = [Movie]

class MovieService{
    public static let share = MovieService();
    private var movieList: moviesDetails?
    
//    public func setMovieList(movieList: [Movie], movieType: String){
//
//        self.movieList[movieType]!.append(movieList)
//        print("Setvalue = \(self.movieList)")
//    }
    public func setMovieList(movieList: moviesDetails){
        self.movieList = movieList
    }
  
    public func getMovieList() -> moviesDetails?{
        return self.movieList
    }
    
   
}


struct MovieImage: Codable {
    let previewurl: String

    enum CodingKeys: String, CodingKey {
        case previewurl
    }
}




struct MovieImageError: Codable{
    let error: String
    enum CodingKeys: String, CodingKey{
        case error
    }
}
