//
//  DataDownloader.swift
//  UseAsync-Await-Actor
//
//  Created by link on 20/03/2023.
//

import Foundation

actor DataDownloader {
    private var cache: [URL: Data] = [:]

    func download(from url: URL) async throws -> Data {
        if let data = cache[url] {
            return data
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        cache[url] = data
        return data
    }

    func download(request: URLRequest) async throws -> Data? {
        guard let url = request.url else { return nil }
        if let data = cache[url] {
            return data
        }

        let (data, _) = try await URLSession.shared.data(for: request)
        cache[url] = data
        return data
    }
}
