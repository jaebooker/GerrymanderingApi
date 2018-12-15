//
//  BlockchainController.swift
//  App
//
//  Created by Jaeson Booker on 12/4/18.
//

import Foundation
import Vapor

class BlockchainController {
    //create blockchain service
    private (set) var blockchainService: BlockchainService
    
    init() {
        self.blockchainService = BlockchainService()
    }
    
    func registerNodes(req: Request, nodes: [BlockchainNode]) -> [BlockchainNode] {
        return self.blockchainService.registerNodes(nodes: nodes)
    }
    //get a JSON object of the nodes
    func getNodes(req: Request) -> [BlockchainNode] {
        return self.blockchainService.getNodes()
    }
    //mine blockchain to create new information
    func mine(req: Request, transaction: Transaction) -> Block {
        return self.blockchainService.getNextBlock(transactions: [transaction])
    }
    //retrieve the entire blockchain
    func getBlockchain(req: Request) -> Blockchain {
        return self.blockchainService.getBlockchain()
    }
    //merge with a more up-to-date blockchain
    func resolve(req: Request) -> Future<Blockchain> {
        let promise: EventLoopPromise<Blockchain> = req.eventLoop.newPromise()
        blockchainService.resolve {
            promise.succeed(result: $0)
        }
        return promise.futureResult
    }
    //just a fun test
    func greet(req: Request) -> Future<String> {
        return Future.map(on: req) { () -> String in
            return "Welcome to the Blockchain! Heyeyeey!"
        }
    }
}
