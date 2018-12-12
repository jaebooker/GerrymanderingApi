//
//  SmartContracts.swift
//  App
//
//  Created by Jaeson Booker on 12/5/18.
//

import Foundation
import Vapor

final class InfoSmartContract: Content {
    func apply(transaction: Transaction, allBlocks: [Block]) {
        allBlocks.forEach { block in
            block.transactions.forEach { trans in
                if trans.firstName == transaction.firstName && trans.lastName == transaction.lastName {
                    print("matching")
                }
            }
        }
    }
}
