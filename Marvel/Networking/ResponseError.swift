//
//  ResponseError.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import Foundation

class ResponseError: Error {
    var httpStatus: Int
    var url: String
    var message: String
    var data: Data?
    
    init(_ httpStatus: Int, _ url: String, _ message: String, data: Data? = nil){
        self.httpStatus = httpStatus
        self.url = url
        self.message = message
    }
}

extension ResponseError {
    static func noConnection(_ url: String) -> ResponseError {
        return ResponseError(-1, url, "Network connection error")
    }
    
    static func parseData(_ url: String) -> ResponseError {
        return ResponseError(-2, url, "Cannot parse data from URL")
    }
    
    static func emptyData(_ url: String) -> ResponseError {
        return ResponseError(-3, url, "No data received")
    }
    
    static func unknown(_ url: String) -> ResponseError {
        return ResponseError(-4, "Unknown error", url)
    }
}
