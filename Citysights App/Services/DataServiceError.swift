//
//  DataServiceError.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/21.
//

import Foundation

enum DataServiceError: Error, LocalizedError {
    case missingAPIKey
    case invalidURL
    case invalidResponse
    case httpError(code: Int, message: String)
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .missingAPIKey:
            return "A API Key está ausente ou inválida."
        case .invalidURL:
            return "A URL fornecida é inválida."
        case .invalidResponse:
            return "A resposta do servidor é inválida."
        case .httpError(let code, let message):
            return "Erro HTTP (\(code)): \(message)"
        case .decodingError(let error):
            return "Erro ao decodificar os dados: \(error.localizedDescription)"
        }
    }
    
}
