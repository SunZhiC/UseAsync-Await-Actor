//
//  ViewController.swift
//  UseAsync-Await-Actor
//
//  Created by SuniMac on 2022/6/12.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        let request = makeRequest()
        mockRequest(request) { user in
            print(user)
        }

        Task {
            let user = await mockRequest(request)
            print(user)
        }
    }

    func makeRequest() -> URLRequest {
        let token = "YOUR_TOKEN"
        let url = URL(string: "https://api.github.com/user")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("token \(token)", forHTTPHeaderField: "Authorization")
        return request
    }

    func mockRequest(_ request: URLRequest, complete: @escaping (User?) -> Void) {
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                complete(user)
            } catch {
                print(error)
                complete(nil)
            }
        }.resume()
    }

    func mockRequest(_ request: URLRequest) async -> User? {
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let user = try JSONDecoder().decode(User.self, from: data)
            return user
        } catch {
            print(error)
            return nil
        }
    }
}

