//
//  DataFetcher.swift
//  NotesApp
//
//  Created by Anytimes on 9/27/17.
//  Copyright © 2017 crisler. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DataFetcher {
    let networking: Networking
    
    func fetch(response: @escaping ([Note]) -> () ) {
        networking.request { (data) in
            // map the json data into model
            print(data)
        }
    }
    
    private func decode(data: JSON) -> [Note] {
        var notes = [Note]()
        return notes
    }
}
