//
//  Service.swift
//  GithubAPI
//
//  Created by Subodh Mahajan on 13/08/22.
//

import Foundation

class Service {
    
    private var dataTask: URLSessionDataTask?
    
    func getOwnerData(completion: @escaping(Result<[Owner], Error>) -> Void) {
        
        let githubPullsURL = "https://api.github.com/repos/RA1NG3R/GithubAPI/pulls?state=closed&base=main"
        
        guard let url = URL(string: githubPullsURL) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Owner].self, from: data)
                print(jsonData)
                // Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
}
