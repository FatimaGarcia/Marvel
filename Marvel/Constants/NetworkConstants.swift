//
//  NetworkConstants.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import Foundation

struct NetworkConstants {
    static let baseUrl = "https://gateway.marvel.com"
    static let publicKey = "7517c301035b65aa7ca807da1b874cab"
    //WORKAROUND: Fix hash parameter to not include privateKey from Marvel's API on code
    static let hash = "cc6f78a7afa0a6152c4cccba05c464f9"
    //WORKAROUND: Fix timestamp parameter to match with the hash above
    static let ts = "1586810619.94981"
}

