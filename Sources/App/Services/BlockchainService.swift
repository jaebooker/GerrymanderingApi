//
//  BlockchainService.swift
//  App
//
//  Created by Jaeson Booker on 12/4/18.
//

import Foundation
import Vapor

class BlockchainService {
    private (set) var blockchain: Blockchain!
    
    init() {
        self.blockchain = Blockchain(genesisBlock: Block())
    }
    func getBlockchain() -> Blockchain {
        return self.blockchain
    }
}
