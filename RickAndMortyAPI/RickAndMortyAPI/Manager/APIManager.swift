//
//  APIManager.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 16.02.2023.
//

import Foundation

private enum HttpMethod: String {
    case GET
}

private protocol APIManagerInterface {
    func getAllCharacters(page: Int, completion: @escaping (Result<Characters, Error>) -> Void)
    func getMultipleCharacters(query: String, completion: @escaping (Result<[Character], Error>) -> Void)
    func filterCharacter(name: String, completion: @escaping (Result<[Character], Error>) -> Void)
    func getAllLocations(page: Int, completion: @escaping (Result<[Locations], Error>) -> Void)
    func filterLocations(name: String, completion: @escaping (Result<[Locations], Error>) -> Void)
    func getAllEpisodes(page: Int, completion: @escaping (Result<[Episode], Error>) -> Void)
    func filterEpisodes(name: String, completion: @escaping (Result<[Episode], Error>) -> Void)

}


final class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
    private func createRequest(with url: URL?, completion: @escaping (URLRequest) -> Void) {
        guard let apiURL = url else { return }
        
        var request = URLRequest(url: apiURL)
        request.httpMethod = HttpMethod.GET.rawValue
        completion(request)
    }
}


extension APIManager: APIManagerInterface {
    
    
    func getAllCharacters(page: Int, completion: @escaping (Result<Characters, Error>) -> Void) {
        createRequest(with: URL(string: URLManager.shared.characters + "?page=\(page)")) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Characters.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func getMultipleCharacters(query: String, completion: @escaping (Result<[Character], Error>) -> Void) {
        createRequest(with: URL(string: URLManager.shared.characters + "/\(query)" )) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode([Character].self, from: data)
                    print(result)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func filterCharacter(name: String, completion: @escaping (Result<[Character], Error>) -> Void) {
        createRequest(with: URL(string: URLManager.shared.characters + "/?name=\(name)")) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Characters.self, from: data)
                    completion(.success(result.results ?? []))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func getAllLocations(page: Int, completion: @escaping (Result<[Locations], Error>) -> Void) {
        createRequest(with: URL(string: URLManager.shared.locations + "?page=\(page)")) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(LocationResult.self, from: data)
                    completion(.success(result.results ?? []))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func filterLocations(name: String, completion: @escaping (Result<[Locations], Error>) -> Void) {
        createRequest(with: URL(string: URLManager.shared.locations + "/?name=\(name)")) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(LocationResult.self, from: data)
                    completion(.success(result.results ?? []))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    func getAllEpisodes(page: Int, completion: @escaping (Result<[Episode], Error>) -> Void) {
        createRequest(with: URL(string: URLManager.shared.episodes + "?page=\(page)")) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Episodes.self, from: data)
                    completion(.success(result.results ?? []))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func filterEpisodes(name: String, completion: @escaping (Result<[Episode], Error>) -> Void) {
        createRequest(with: URL(string: URLManager.shared.episodes + "/?name=\(name)")) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Episodes.self, from: data)
                    completion(.success(result.results ?? []))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
}
