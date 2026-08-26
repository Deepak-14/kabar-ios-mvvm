//
//  NetworkManagerProtocol.swift
//  Kabar
//
//  Created by user on 22/08/26.
//

protocol NetworkManagerProtocol {
    func getData<T: Decodable>(_ type: T.Type, url: String, methodType: APIMethod, completionHandler: @escaping (Result<T?, Error>) -> Void)
}
