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
//setting blockchain address class
final class BlockchainNode: Content {
    
    var address: String
    init(address: String) {
        self.address = address
    }
}
//creating blockchain entry
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
}
//class for a single block
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
    //add information passed
    func addTransaction(transaction: Transaction) {
        self.transactions.append(transaction)
    }
}
//the actual blockchain
final class Blockchain: Content {
    private (set) var blocks: [Block] = [Block]()
    private (set) var nodes: [BlockchainNode] = [BlockchainNode]()
    private (set) var smartContracts: InfoSmartContract = InfoSmartContract()
    private enum CodingKeys: CodingKey {
        case blocks
    }
    //create first block
    init(genesisBlock: Block) {
        addBlock(genesisBlock)
    }
    //register addresses
    func registerNodes(nodes: [BlockchainNode]) -> [BlockchainNode] {
        self.nodes.append(contentsOf: nodes)
        return self.nodes
    }
    //add new entry on block
    func addBlock(_ block: Block) {
        if self.blocks.isEmpty {
            block.previousHash = "000000000000000"
            block.hash = generateHash(for: block)
        }
        self.blocks.append(block)
    }
    //traverse through information on transaction
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
    //set the next block after genesis
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
    //create basic hash using sha1
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
let block1 = Block()
//encode JSON data
let data = try! JSONEncoder().encode(blockchain)
let blockchainJSON = String(data: data, encoding: .utf8)
extension String {
    //generating hash, searching for random number with two 0s in a row
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
