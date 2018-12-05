//  BlockchainService.swift
//  Created by Jaeson Booker on 11/22/18.
//
import Foundation
import Vapor

class BlockchainService {
    typealias JSONDictionary = [String: String]
    private var blockchain: Blockchain = blockchain()
    init() {
        
    }
    func addBlock(_ block: Block) {
        self.blockchain.addBlock(block)
    }
    func registerNode(_ blockchain: BlockchainNode) {
        self.blockchain.addNode(blockchainNode)
    }
    func getLastBlock() -> Block {
        return self.blockchain.blocks.last!
    }
    func getBlockchain() -> Blockchain? {
        return self.blockchain
    }
}
