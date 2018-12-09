import Vapor
import Crypto
/// Register your application's routes here.
public func routes(_ router: Router) throws {
    let blockchainController = BlockchainController()
    let userRouteController = UserController()
    let basicAuthMiddleware = User.basicAuthMiddleware(using: BCrypt)
    let guardAuthMiddleware = User.guardAuthMiddleware()
    let basicAuthGroup = router.grouped([basicAuthMiddleware, guardAuthMiddleware])
    try userRouteController.boot(router: router)
    router.get("/api/greet", use: blockchainController.greet)
    router.get("blockchain", use: blockchainController.getBlockchain)
    basicAuthGroup.post(Transaction.self, at: "mine", use: blockchainController.mine)
    //router.post([BlockchainNode].self, at: "/nodes/register", use: blockchainController.registerNodes)
    basicAuthGroup.post([BlockchainNode].self, at: "/nodes/register", use: blockchainController.registerNodes)
    router.get("/nodes", use: blockchainController.getNodes)
    router.get("/resolve", use: blockchainController.resolve)
    //router.get("/getinfo/:name", use: blockchainController.getInfo)
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    let gerrymanderingController = GerrymanderingController()
    
    router.get("gerrymandering", use: gerrymanderingController.index)
    basicAuthGroup.post("gerrymandering", use: gerrymanderingController.create)
    basicAuthGroup.delete("gerrymandering", GerryMandering.parameter, use: gerrymanderingController.delete)
}
