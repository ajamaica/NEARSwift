import Foundation

public enum NearEnvironment: String {
    case mainnet = "https://rpc.mainnet.near.org"
    case testnet = "https://rpc.testnet.near.org"
    case betanet = "https://rpc.betanet.near.org"
    
    func getEnviromentURL() -> URL {
        guard let url = URL(string: rawValue) else { fatalError("Invalid enviroment URL for \(self.rawValue)") }
        return url
    }
}

public struct NEAREndpoint: EndPointType {
    public var path: String = "/"
    public var httpMethod: HTTPMethod = .post
    public var task: HTTPTask
    public var headers: HTTPHeaders?
    public var baseURL: URL
    
    init<Params: Encodable>(enviroment: NearEnvironment, params: Params) {
        self.baseURL = enviroment.getEnviromentURL()
        self.task = .requestParameters(
            bodyParameters: params.dict,
            bodyEncoding: .jsonEncoding,
            urlParameters: nil
        )
    }
}
