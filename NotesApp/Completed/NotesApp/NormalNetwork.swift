//
//  NormalNetwork.swift
//  NotesApp
//
//  Created by Anytimes on 9/27/17.
//  Copyright © 2017 crisler. All rights reserved.
//

import Foundation
import SwiftyJSON

struct NormalNetwork: Networking {
    func request(response: @escaping (JSON?) -> ()) {
    
        guard let url = URL(string: DataConfig.url) else {
            print("Invalid url")
            return
        }
        // URLSession creates tasks that are run asynchronously. You set up a task, and either pass in a completion block, or set up a delegate.
        let task = URLSession.shared.dataTask(with: url) { (data, responseData, error) in
            guard let data = data else {
                print("Invalid data")
                return
            }
            
            let json = JSON(data)
            print(json)
            response(json)
            /*
             JSON parsing without SwiftyJSON
            do {
                // Swift 2 /3
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                
                print(json)
                response(json)
            }catch let jsonError {
                print("Error serializing json:", jsonError)
            }
            */
        }
        // tells the task to return immediately
        task.resume()
    }
}
