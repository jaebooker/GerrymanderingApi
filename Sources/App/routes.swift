import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    let blockchainController = BlockchainController()
    router.get("/api/greet", use: blockchainController.greet)
    router.get("blockchain", use: blockchainController.getBlockchain)
    router.post(Transaction.self, at: "mine", use: blockchainController.mine)
    router.post([BlockchainNode].self, at: "/nodes/register", use: blockchainController.registerNodes)
    router.get("/nodes", use: blockchainController.getNodes)
    router.get("/resolve", use: blockchainController.resolve)
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
