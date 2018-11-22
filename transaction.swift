class Transaction: Codable {
    
    var to: String
    var from: String
    var amount: Double
    
    init(to: String, from: String, amount: Double) {
        self.to = to
        self.from = from
        self.amount = amount
    }
    init?(request: Request) {
        guard let to = request.data["to"]?.string,
        let from = request.data["from"]?.string,
        let amount = request.data["amount"]?.double
        else {
            return nil
        }
        self.to = to
        self.from = from
        self.amount = amount
    }
}
