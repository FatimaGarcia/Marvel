//
//  NetworkSession.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import Foundation
import Alamofire

struct Session {
    static func performRequest<Request: BaseRequest>(_ request: Request, _ completion: Request.Completion?) {

        guard let urlRequest = try? request.getRequest() else {
            fatalError("Request is not valid")
        }
        
        AF.request(urlRequest)
            .responseDecodable{ (response: AFDataResponse<Request.Response>) in
                DispatchQueue.main.async {
                    guard let statusCode = response.response?.statusCode else {
                        return completion?(.failure(.unknown(request.urlString))) ?? ()
                    }
                    switch statusCode {
                    case 200..<300:
                        guard let data = response.data else {
                            return completion?(.failure(.emptyData(request.urlString))) ?? ()
                        }
                        guard let model = try? JSONDecoder().decode(Request.Response.self, from: data) else {
                            return completion?(.failure(.parseData(request.urlString))) ?? ()
                        }
                        return completion?(.success(model)) ?? ()
                    default:
                        let error = ResponseError(statusCode, request.urlString, "Service Error", data: response.data)
                        return completion?(.failure(error)) ?? ()
                    }
                }
        }
    }
}
