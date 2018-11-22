class Block : Codable {
    
    var index: Int = 0
    var dateCreated: String
    var previousHash: String!
    var hash: String!
    var message: String = ""
    var nonce: Int
    
    private(set) var transactions: [Transaction] = [Transaction]()
    
    var key: String {
        get {
            let transactionsData = try! JSONEncoder().encode(self.transactions)
            let transactionsJSONString = String(data: transactionsData, encoding: .utf8)
            return String(self.index) + self.dataCreated + self.previousHash + transactionsJSONString! + String(self.nonce)
        }
    }
    func addTransaction(transaction: Transaction) {
        self.transactions.append(transaction)
    }
    init() {
        self.dateCreated = Date().toString()
        self.nonce = 0
        self.message = "New Block Successfully Mined"
    }
    init(transaction: Transaction) {
        self.dateCreated = Date().toString()
        self.nonce = 0
        self.addTransaction(transaction: transaction)
    }
}
