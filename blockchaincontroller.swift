class BlockchainController {
    private(set) var drop: Droplet
    private(set) var blockchainService: BlockchainService!
    init(drop: Droplet) {
        self.drop = drop
        self.blockchainService = BlockchainService()
        setupRoutes()
    }
    private func setupRoutes() {
        self.drop.get("mind") {
            request in
            let block = Block()
            self.blockchainService.addBlock(block)
            return try JSONEncoder().encode(block)
        }
        self.drop.post("transaction") {
            request in
            if let transaction = Transaction(request: request) {
                let block = self.blockchainService.getLastBlock()
                block.addTransaction(transaction: transaction)
                return try JSONEncoder().encode(block)
            }
            return try JSONEncoder().encode(["message":"Error! Error!"])
    }
        self.drop.get("blockchain") {
            request in
            if let blockchain = self.blockchainService.getBlockchain() {
                return try JSONEncoder().encode(blockchain)
            }
            return try! JSONEncoder().encode(["message":"Blockchain not intialized"])
        }
    }
}
