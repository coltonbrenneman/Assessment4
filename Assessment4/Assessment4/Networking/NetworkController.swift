//
//  NetworkController.swift
//  Assessment4
//
//  Created by Colton Brenneman on 6/20/23.
//

import UIKit.UIImage
//https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2012-10-10&api_key=NjDahs8YwTgoAs2nor8gzuTTrDFQwE5KpsDDXx1Y

struct NetworkController {
    func fetchRover(searchTerm: String, completion: @escaping(Result<TopLevelDictionary, ResultError>) -> Void) {
        guard let baseURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos") else { completion(.failure(.invalidURL)) ; return }
        
        var urlRequest = URLRequest(url: baseURL)
        let earthDateQueryItem = URLQueryItem(name: "earth_date", value: searchTerm)
        let apiQueryItem = URLQueryItem(name: "api_key", value: "NjDahs8YwTgoAs2nor8gzuTTrDFQwE5KpsDDXx1Y")
        urlRequest.url?.append(queryItems: [earthDateQueryItem, apiQueryItem])
        print(urlRequest.url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error {
                completion(.failure(.thrownError(error)))
            } // End of error
            guard let data else { completion(.failure(.noData)) ; return }
            do {
                let tld = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(.success(tld))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    } // End of fetchRover
    
    func fetchImage(with imageURL: String, completion: @escaping(Result<UIImage, ResultError>) -> Void) {
        guard let url = URL(string: imageURL) else { completion(.failure(.invalidURL)) ; return }
        
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                completion(.failure(.thrownError(error))) ; return
            } // End of error
           
            guard let imageData = data else { completion(.failure(.noData)) ; return }
            
            guard let movieImage = UIImage(data: imageData) else { return }
            completion(.success(movieImage))
        }.resume() // End of dataTask
    } // End of fetchImage
    
} //End of struct
