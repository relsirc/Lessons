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
            guard let noteData = data else {
                response([Note]())
                return }
            // map the json data into model
            let notes = self.decode(data: noteData)
            response(notes)
        }
    }
    
    private func decode(data: JSON) -> [Note] {
        var notes = [Note]()
        for (_, json) in data {
            var note = Note()
            note.id = json["id"].stringValue
            note.message = json["note"].stringValue
            notes.append(note)
        }
        print(notes)
        return notes
    }
}
