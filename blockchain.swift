class Blockchain: Codable {
    var blocks: [Block] = [Block]()
    init() {
        
    }
    init(_genesisBlock: Block) {
        self.addBlock(genesisBlock)
    }
    func addBlock(_ block: Block) {
        if self.blocks.isEmpty {
            block.previousHash = "0"
        } else {
            let previousBlock = getPreviousBlock()
            block.previousHash = previousBlock.hash
            block.index = self.blocks.count
        }
    }
}
