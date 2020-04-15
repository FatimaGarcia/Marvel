//
//  BaseRequest.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String:String]
typealias Parameters = [String: Any]

enum HTTPMethod: String, Codable {
    case GET, POST, UPDATE, DELETE
}

private enum RequestError: String, Error {
    case missingUrl = "Error generating url"
    case generateUrlComponents = "Error generating components"
    case finalUrl = "Error generating final url"
}

protocol BaseRequest {
    associatedtype Response: Codable
    
    typealias RequestResponse = Result<Response, ResponseError>
    typealias Completion = (RequestResponse) -> ()

    var baseUrl: String { get }
    var path: String { get }
    var urlString: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters { get }
    var body: Any { get }
}

extension BaseRequest {
    var baseUrl: String { return NetworkConstants.endpoint }
    var urlString: String { return baseUrl + path }

    var parameters: Parameters {
        return ["apikey": NetworkConstants.publicKey,
                "hash" : NetworkConstants.hash,
                "ts": NetworkConstants.ts] }
    
    var headers: HTTPHeaders { return ["Content-Type":"application/json"] }
    
    var body: Any { return [:] }

    func getRequest() throws -> URLRequest {
        guard var url = URL(string: baseUrl) else {
            throw RequestError.missingUrl
        }
        
        url.appendPathComponent(path)
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw RequestError.generateUrlComponents
        }
        
        if !parameters.isEmpty {
            components.queryItems = parameters.map{ URLQueryItem(name: $0,
                                                                 value: "\($1)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) ) }
        }
                   
        guard let finalURL = components.url else {
            throw RequestError.finalUrl
        }

        var request = URLRequest(url: finalURL)
        request.httpMethod = httpMethod.rawValue
        if httpMethod == .POST {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        request.allHTTPHeaderFields = headers
    
        return request
    }
    
    func performRequest(completion: Completion?) {
        Session.performRequest(self, completion)
    }
}
