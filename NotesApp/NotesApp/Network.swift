//
//  Network.swift
//  NotesApp
//
//  Created by Anytimes on 9/27/17.
//  Copyright © 2017 crisler. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Network: Networking {
    func request(response: @escaping (JSON?) -> ()) {
        Alamofire.request(DataConfig.url).responseJSON {
            data in
            response(JSON(data))
        }
    }
}
