//
//  BlockchainController.swift
//  App
//
//  Created by Jaeson Booker on 12/4/18.
//

import Foundation
import Vapor

class BlockchainController {
    
    private (set) var blockchainService: BlockchainService
    
    init() {
        self.blockchainService = BlockchainService()
    }
    
    func getBlockchain(req: Request) -> Blockchain {
        return self.blockchainService.getBlockchain()
    }
    
    func greet(req: Request) -> Future<String> {
        return Future.map(on: req) { () -> String in
            return "Welcome to the Blockchain! Heyeyeey!"
        }
    }
}
