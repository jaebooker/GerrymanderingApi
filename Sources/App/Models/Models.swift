//
//  Models.swift
//  App
//
//  Created by Jaeson Booker on 12/4/18.
//

import Foundation
import Vapor

let genesisBlock = Block()
let blockchain = Blockchain(genesisBlock: genesisBlock)


protocol SmartContract {
    func apply(transaction: Transaction)
}

//class TransactionTypeSmartContract: SmartContract {
//    func apply(transaction: Transaction) {
//        var fees = 0.0
//        switch transaction.transactionType {
//        case .domestic:
//            fees = 0.02
//        case .international:
//            fees = 0.05
//        }
//        transaction.fees = transaction.amount * fees
//        transaction.amount -= transaction.fees
//    }
//}
//
//enum TransactionType: String, Codable {
//    case domestic
//    case international
//}

final class BlockchainNode: Content {
    
    var address: String
    init(address: String) {
        self.address = address
    }
}

final class Transaction: Content {
    
    var firstName: String
    var lastName: String
    var officeType: String
    var representing: String
    var zipcodes: [Int]?
    var gerrymandering: Bool
    var voterSuppression: Bool
    var supportingEvidence: String
    
    init(firstName: String, lastName: String, officeType: String, representing: String, zipcodes: [Int]?, gerrymandering: Bool, voterSupression: Bool, supportingEvidence: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.officeType = officeType
        self.representing = representing
        if zipcodes != nil{
        self.zipcodes = zipcodes!
        }
        self.gerrymandering = gerrymandering
        self.voterSuppression = voterSupression
        self.supportingEvidence = supportingEvidence
    }
//    var from: String
//    var to: String
//    var amount: Double
//    //var fees: Double = 0.0
//    //var transactionType: TransactionType
//
//    init(from: String, to: String, amount: Double) {
//        self.from = from
//        self.to = to
//        self.amount = amount
//        //self.transactionType = transactionType
//    }
}
final class Block: Content {
    var index: Int = 0
    var previousHash: String = ""
    var hash: String!
    var nonce: Int
    private (set) var transactions: [Transaction] = [Transaction]()
    var key: String {
        get {
            let transactionsData = try! JSONEncoder().encode(self.transactions)
            let transactionsJSONString = String(data: transactionsData, encoding: .utf8)
            return String(self.index) + self.previousHash + String(self.nonce) + transactionsJSONString!
        }
    }
    init() {
        self.nonce = 0
    }
    func addTransaction(transaction: Transaction) {
        self.transactions.append(transaction)
    }
}
final class Blockchain: Content {
    private (set) var blocks: [Block] = [Block]()
    private (set) var nodes: [BlockchainNode] = [BlockchainNode]()
    //private (set) var smartContracts: [SmartContract] = [TransactionTypeSmartContract()]
    private (set) var smartContracts: InfoSmartContract = InfoSmartContract()
    private enum CodingKeys: CodingKey {
        case blocks
    }
    init(genesisBlock: Block) {
        addBlock(genesisBlock)
    }
    func registerNodes(nodes: [BlockchainNode]) -> [BlockchainNode] {
        self.nodes.append(contentsOf: nodes)
        return self.nodes
    }
    func addBlock(_ block: Block) {
        if self.blocks.isEmpty {
            block.previousHash = "000000000000000"
            block.hash = generateHash(for: block)
        }
        self.blocks.append(block)
    }
    func transactionsBy(firstName: String, lastName: String) -> [Transaction] {
        var transactions: [Transaction] = [Transaction]()
        self.blocks.forEach { block in
            block.transactions.forEach { transaction in
                if firstName == transaction.firstName && lastName == transaction.lastName {
                    transactions.append(transaction)
                }
            }
        }
        return transactions
    }
    func getNextBlock(transactions: [Transaction]) -> Block {
        let block = Block()
        transactions.forEach { transaction in
            self.smartContracts.apply(transaction: transaction, allBlocks: self.blocks)
            block.addTransaction(transaction: transaction)
            }
        let previousBlock = getPreviousBlock()
        block.index = self.blocks.count
        block.previousHash = previousBlock.hash
        block.hash = generateHash(for: block)
        return block
    }
    private func getPreviousBlock() -> Block {
        return self.blocks[self.blocks.count - 1]
    }
    func generateHash(for block: Block) -> String {
        var hash = block.key.sha1Hash()
        
        while(!hash.hasPrefix("00")) {
            block.nonce += 1
            hash = block.key.sha1Hash()
            print(hash)
        }
            
        return hash
    }
}
//let transaction = Transaction(from: "Peter", to: "Paul", amount: 2000, transactionType: .domestic)
//let block = blockchain.getNextBlock(transactions: [transaction])
let block1 = Block()
let data = try! JSONEncoder().encode(blockchain)
let blockchainJSON = String(data: data, encoding: .utf8)

//block1.addTransaction(transaction: transaction)
//block1.key
extension String {
    func sha1Hash() -> String {
        let task = Process()
        task.launchPath = "/usr/bin/shasum"
        task.arguments = []
        let inputPipe = Pipe()
        inputPipe.fileHandleForWriting.write(self.data(using: String.Encoding.utf8)!)
        inputPipe.fileHandleForWriting.closeFile()
        let outputPipe = Pipe()
        task.standardOutput = outputPipe
        task.standardInput = inputPipe
        task.launch()
        let data = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let hash = String(data: data, encoding: String.Encoding.utf8)!
        return hash.replacingOccurrences(of: "  -\n", with: "")
    }
}
