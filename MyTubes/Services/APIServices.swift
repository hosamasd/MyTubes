//
//  APIServices.swift
//  MyTubes
//
//  Created by hosam on 12/28/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class APIServices {
    
    let baseUrls = "https://s3-us-west-2.amazonaws.com/youtubeassets/"
    static let shared = APIServices()
    
    
    func getSharedAPIFromUrl(completion: @escaping ([VideoModel]?,Error?)->()) {
        let urlString = "\(baseUrls)home.json"
        
        guard let baseUrl = URL(string: urlString) else{
            return}
        URLSession.shared.dataTask(with: baseUrl) { (data, response, err) in
            if err != nil {
                print("error")
                return
            }
            guard let dataa = data else{ return}
            do {
                let objects = try JSONDecoder().decode([VideoModel].self, from: dataa)
                // success
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
            }.resume()
    }
}
