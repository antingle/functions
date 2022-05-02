//
//  History.swift
//  Calculator
//
//  Created by Anthony Ingle on 5/1/22.
//

import Foundation
import SwiftUI

struct History: Identifiable, Codable {
    let id: UUID
    var date: Date
    var expression: String
    var solution: String
    
    init(expression: String, solution: String) {
        id = UUID()
        date = .now
        self.expression = expression
        self.solution = solution
    }
}

class HistoryStore : ObservableObject {
    @Published var history: [History] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("history.data")
    }
    
    static func load(completion: @escaping (Result<[History], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let historyData = try JSONDecoder().decode([History].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(historyData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(history: [History], completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(history)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(history.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
