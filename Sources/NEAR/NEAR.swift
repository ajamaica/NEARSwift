import Foundation

public class NEAR {
    private let environment: NearEnvironment
    private let router: Router<NEAREndpoint>
    
    public init(
        environment: NearEnvironment,
        router: Router<NEAREndpoint> = Router<NEAREndpoint>(session: URLSession.shared)
    ) {
        self.router = router
        self.environment = environment
    }
    
    // View access key
    public func viewAccessKeys(params: ViewAccessKeysRequest, completion: @escaping (Result<ViewAccessKeysResponse , Error>) -> Void){
        queryCall(params: params, completion: completion)
    }
    
    // View access key list
    public func viewAccessKeyList(params: ViewAccessKeyListRequest, completion: @escaping (Result<ViewAccessKeyListResponse , Error>) -> Void){
        queryCall(params: params, completion: completion)
    }
    
    // View access key changes (single)
    public func viewAccessKeyChangesSingle(params: ViewAccessKeyChangesSingleRequest, completion: @escaping (Result<ViewAccessKeyChangesSingleResponse , Error>) -> Void){
        experimentalChanges(params: params, completion: completion)
    }
    
    // View access key changes (all)
    public func viewAccessKeyChangesAll(params: ViewAccessKeyChangesAllRequest, completion: @escaping (Result<ViewAccessKeyChangesAllResponse , Error>) -> Void){
        experimentalChanges(params: params, completion: completion)
    }
    
    // View account
    public func viewAccount(params: ViewAccountRequest, completion: @escaping (Result<ViewAccountResponse , Error>) -> Void){
        queryCall(params: params, completion: completion)
    }
    
    // View account Changes
    public func viewAccountChanges(params: ViewAccountChangesRequest, completion: @escaping (Result<ViewContractChangesResponse , Error>) -> Void){
        experimentalChanges(params: params, completion: completion)
    }
    
    // View contract state
    public func viewContractState(params: ViewContractStateRequest, completion: @escaping (Result<ViewContractStateResponse , Error>) -> Void){
        queryCall(params: params, completion: completion)
    }
    
    //View contract state changes
    public func viewContractStateChanges(params: ViewContractStateChangesRequest, completion: @escaping (Result<ViewContractStateChangesResponse , Error>) -> Void){
        experimentalChanges(params: params, completion: completion)
    }
    
    // View contract code changes
    public func viewContractStateCodeChanges(params: ViewContractStateCodeChangesRequest, completion: @escaping (Result<ViewContractStateCodeChangesResponse , Error>) -> Void){
        experimentalChanges(params: params, completion: completion)
    }
    
    // Call a contract function
    public func callContractFunction(params: CallContractFunctionRequest, completion: @escaping (Result<CallContractFunctionResponse , Error>) -> Void){
        queryCall(params: params, completion: completion)
    }
    
    // Block Details
    public func blockDetails(params: BlockDetailsRequest, completion: @escaping (Result<BlockDetailsResponse , Error>) -> Void){
        blockCall(params: params, completion: completion)
    }
    
    // Block Details Changes
    public func blockDetailsChanges(params: BlockChangesRequest, completion: @escaping (Result<BlockChangesResponse , Error>) -> Void){
        experimentalChangesInBlock(params: params, completion: completion)
    }
    
    // Block Details Changes
    public func gasPrice(params: GasPriceRequest, completion: @escaping (Result<GasPriceResponse , Error>) -> Void){
        gasPriceCall(params: params, completion: completion)
    }
    
    public func genesisConfig(completion: @escaping (Result<GenesisConfigResponse , Error>) -> Void){
        call(method: .experimental_genesisConfig, params: JSONNull(), completion: completion)
    }
    
    private func experimentalChanges<Params: Encodable, Response: Decodable>(params: Params, completion: @escaping (Result<Response , Error>) -> Void){
        call(method: .experimental_changes, params: params, completion: completion)
    }
    
    private func experimentalChangesInBlock<Params: Encodable, Response: Decodable>(params: Params, completion: @escaping (Result<Response , Error>) -> Void){
        call(method: .experimental_changes_in_block, params: params, completion: completion)
    }
    
    
    private func gasPriceCall<Params: Encodable, Response: Decodable>(params: Params, completion: @escaping (Result<Response , Error>) -> Void){
        call(method: .gas_price, params: params, completion: completion)
    }
    
    private func queryCall<Params: Encodable, Response: Decodable>(params: Params, completion: @escaping (Result<Response , Error>) -> Void){
        call(method: .query, params: params, completion: completion)
    }
    
    private func blockCall<Params: Encodable, Response: Decodable>(params: Params, completion: @escaping (Result<Response , Error>) -> Void){
        call(method: .block, params: params, completion: completion)
    }
    
    public func sendTransaction(signedTransaction: SendTransactionRequest, completion: @escaping (Result<SendTransactionResponse , Error>) -> Void){
        call(method: .broadcast_tx_commit, params: signedTransaction, completion: completion)
    }
    
    public func status(completion: @escaping (Result<NodeStatusResult , Error>) -> Void){
        call(method: .status, params: [String: String](), completion: completion)
    }
    
    private func call<Params: Encodable, Payload: Decodable>(method: Method, params: Params?, completion: @escaping (Result<Payload, Error>) -> Void ) {
        request(params: NEARRequest(method: method, params: params), completion: completion)
    }
    
    private func request<Params: Encodable, Payload: Decodable>(params: NEARRequest<Params>?,
                                                                completion: @escaping (Result<Payload, Error>) -> Void ) {
        router.request(.init(
                        enviroment: environment,
                        params: params)
        ) { ( data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(NEARError.canNotReadError))
            }
            completion(handleNetworkResponse(response, data, error))
        }
    }
    
}

private func handleNetworkResponse<Payload: Decodable>(_ response: HTTPURLResponse,
                                                       _ data: Data?,
                                                       _ error: Error?) -> Result<Payload, Error> {
    let decoder = JSONDecoder()
    if let error = error { return .failure(NEARError(code: -2, message: "Network error : \(error.localizedDescription)", data: nil )) }
    if let data =  data {
        do {
            let payload = try decoder.decode(NEARResponse<Payload>.self, from: data)
            
            if let result = payload.result {
                return .success(result)
            } else if let error = payload.error {
                return .failure(error)
            }
        } catch let error {
            return .failure(NEARError(code: -3, message: "Can not decode json with error: \(error.localizedDescription)", data: nil))
        }
    }
    return .failure(NEARError.canNotReadError)
}
