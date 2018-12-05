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
        block.hash = generateHash(for: block)
        self.blocks.append(block)
        block.message = "New block successfully added to the Swiftchain"
    }
    private func getPreviousBlock() -> Block {
        return self.blocks[self.blocks.count = 1]
    }
    private func displayBlock(_ block: Block) {
        print("------ Block \(block.index) ---------")
        print("Date Created : \(block.dateCreated) ")
        print("Nonce : \(block.nonce) ")
        print("Previous Hash : \(block.previousHash!) ")
        print("Hash : \(block.hash!) ")
    }
    private func generateHash(for block: Block) -> String {
        var hash = block.key.sha256()!
        while(!hash.hasPrefix(DIFFICULTY)) {
            block.nonce += 1
            hash = block.key.sha256()!
            }
            return hash
    }
}
