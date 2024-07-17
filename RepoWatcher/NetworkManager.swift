//
//  NetworkManager.swift
//  RepoWatcher
//
//  Created by Mohammad Blur on 7/10/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
    
    private init() { 
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getRepo(at urlString: String) async throws -> Repository {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        do {
            let codingData = try decoder.decode(Repository.CodingData.self, from: data)
            return codingData.repo
        } catch {
            throw NetworkError.invalidRepoData
        }
    }
    
    func getContributor(at urlString: String) async throws -> [Contributor] {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        do {
            let codingData = try decoder.decode([Contributor.CodingData].self, from: data)
            return codingData.map { $0.contributors }
        } catch {
            throw NetworkError.invalidRepoData
        }
    }
    
    func downloadImageData(from urlString: String) async -> Data? {
        guard let url = URL(string: urlString) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            return nil
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidRepoData
}

enum RepoURL {
    static let swiftNews = "https://api.github.com/repos/sallen0400/swift-news"
    static let repoWatcher = "https://api.github.com/repos/blur1379/RepoWatcher"
    static let publish = "https://api.github.com/repos/johnsundell/publish"
}
