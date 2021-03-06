//
//  ScheduledTransactionsController.swift
//  BudgetKit
//
//  Created by TQL Mobile on 7/28/18.
//

import Foundation

struct ScheduledTransactionsController {
    
    static var baseURL: URL {
        let string = API.baseURL + "budgets/"
        return URL(string: string)!
    }
    
    static func getScheduledTransactionList(budgetID: UUID, completion: @escaping YNABCompletion<[ScheduledTransactionDetail]>) {
        var path = budgetID.uuidString
        path += "/transactions"
        let url = URL(string: path, relativeTo: baseURL)!
        
        let success: ((Data) -> Void) = { data in
            do {
                let response = try JSONDecoder().decode(ScheduledTransactionListResponse.self, from: data)
                let transactions = response.wrapper.transactions
                completion(.success(transactions))
            } catch let error {
                completion(.failure(error))
            }
        }
        let failure: ((Error) -> Void) = { error in
            completion(.failure(error))
        }
        
        WebServiceManager.shared.get(url, success: success, failure: failure)
    }
    
    static func getScheduledTransaction(budgetID: UUID, transactionID: UUID, completion: @escaping YNABCompletion<ScheduledTransactionDetail>) {
        var path = budgetID.uuidString
        path += "/transactions/"
        path += transactionID.uuidString
        let url = URL(string: path, relativeTo: baseURL)!
        
        let success: ((Data) -> Void) = { data in
            do {
                let response = try JSONDecoder().decode(ScheduledTransactionResponse.self, from: data)
                let transaction = response.wrapper.transaction
                completion(.success(transaction))
            } catch let error {
                completion(.failure(error))
            }
        }
        let failure: ((Error) -> Void) = { error in
            completion(.failure(error))
        }
        
        WebServiceManager.shared.get(url, success: success, failure: failure)
    }
}
