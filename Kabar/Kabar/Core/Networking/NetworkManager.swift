//
//  NetworkManager.swift
//  Kabar
//
//  Created by user on 22/08/26.
//

import Foundation

enum APIMethod:String {
    case get = "GET"
    case post = "POST"
}

final class NetworkManager: NetworkManagerProtocol {
    
    func getData<T: Decodable>(_ type: T.Type, url: String, methodType: APIMethod = .get, completionHandler: @escaping (Result<T?, any Error>) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = methodType.rawValue
//        request.setValue(APIConstant.apiKey, forHTTPHeaderField: "apiKey")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(NSError(domain: "Data Error", code: -1)))
                return
            }
            
            guard let res = response as? HTTPURLResponse, (200...299).contains(res.statusCode) else {
                completionHandler(.failure(NSError(domain: "Response Error", code: -1)))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(error))
            }
        }.resume()
    }
}
