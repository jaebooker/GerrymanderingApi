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
    
    func registerNodes(req: Request, nodes: [BlockchainNode]) -> [BlockchainNode] {
        return self.blockchainService.registerNodes(nodes: nodes)
    }
    
    func getNodes(req: Request) -> [BlockchainNode] {
        return self.blockchainService.getNodes()
    }
    
//    func getInfo(req: Request, firstName: String, lastName: String) {
//        guard let getInfo = request.parameters[firstName + lastName]?.string
//            else {
//                return try JSONEncoder().encode(["message":"error, not found"])
//        }
//        let blockchain = self.blockchainService.blockchain
//        let transactions = blockchain?.transactionsBy(firstName: firstName, lastName: lastName)
//        return try JSONEncoder().encode(transactions)
//    }
    
    func mine(req: Request, transaction: Transaction) -> Block {
        return self.blockchainService.getNextBlock(transactions: [transaction])
    }
    
    func getBlockchain(req: Request) -> Blockchain {
        return self.blockchainService.getBlockchain()
    }
    
    func resolve(req: Request) -> Future<Blockchain> {
        let promise: EventLoopPromise<Blockchain> = req.eventLoop.newPromise()
        blockchainService.resolve {
            promise.succeed(result: $0)
        }
        return promise.futureResult
    }
    
    func greet(req: Request) -> Future<String> {
        return Future.map(on: req) { () -> String in
            return "Welcome to the Blockchain! Heyeyeey!"
        }
    }
}
