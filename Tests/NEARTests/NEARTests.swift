import XCTest
@testable import NEAR

final class NEARTests: XCTestCase {
    
    fileprivate func getDencoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
    
    fileprivate func getMockURLSession<Payload>(fileName: String) -> (URLSession, NEARResponse<Payload>) {

        let json = stubbedResponse(fileName)
        let payload = try! getDencoder().decode(NEARResponse<Payload>.self, from: json)

        URLProtocolMock.testData = json
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return (URLSession(configuration: config), payload)
    }
    
    func testStatusCall() {
        let expectation = XCTestExpectation(description: "Network Call")
        let near = NEAR(environment: .testnet, router: Router<NEAREndpoint>(session: URLSession.shared, enableDebugLogs: true))
        near.status { (result) in
            debugPrint(result)
            if case .success = result {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testStatusCallMock() {
        let expectation = XCTestExpectation(description: "Network Call")

        let tuple: (session: URLSession, stub: NEARResponse<NodeStatusResult>) = getMockURLSession(fileName: "status")
        
        let near = NEAR(environment: .testnet, router: Router<NEAREndpoint>(session: tuple.session))
        near.status { (result) in
            debugPrint(result)
            if case let .success(response) = result {
                XCTAssertEqual(response.chainID, tuple.stub.result?.chainID)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testSendTransactionCallError() {
        let expectation = XCTestExpectation(description: "Network Call")
        let near = NEAR(environment: .testnet, router: Router<NEAREndpoint>(session: URLSession.shared, enableDebugLogs: true))
        near.sendTransaction(signedTransaction: [    "DgAAAHNlbmRlci50ZXN0bmV0AOrmAai64SZOv9e/naX4W15pJx0GAap35wTT1T/DwcbbDQAAAAAAAAAQAAAAcmVjZWl2ZXIudGVzdG5ldIODI4YfV/QS++blXpQYT+bOsRblTRW4f547y/LkvMQ9AQAAAAMAAACh7czOG8LTAAAAAAAAAAXcaTJzu9GviPT7AD4mNJGY79jxTrjFLoyPBiLGHgBi8JK1AnhK8QknJ1ourxlvOYJA2xEZE8UR24THmSJcLQw="]) { (result) in
            debugPrint(result)
            if case .failure = result {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testViewAccessKeysCall() {
        let expectation = XCTestExpectation(description: "Network Call")
        let near = NEAR(environment: .testnet, router: Router<NEAREndpoint>(session: URLSession.shared, enableDebugLogs: true))
        near.viewAccessKeys(params: .init(accountID: "client.chainlink.testnet", publicKey: "ed25519:H9k5eiU4xXS3M4z8HzKJSLaZdqGdGwBG49o7orNC4eZW", blockIdOrFinality: .finality(.final))) { (result) in
            debugPrint(result)
            if case .success = result {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testViewAccessKeyListsCall() {
        let expectation = XCTestExpectation(description: "Network Call")
        let near = NEAR(environment: .testnet, router: Router<NEAREndpoint>(session: URLSession.shared, enableDebugLogs: true))
        near.viewAccessKeyList(params: .init(blockIdOrFinality: .finality(.final), accountID: "example.testnet")){ (result) in
            debugPrint(result)
            if case .success = result {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testViewAccessKeyChangesSingle() {
        let expectation = XCTestExpectation(description: "Network Call")
        let near = NEAR(environment: .testnet, router: Router<NEAREndpoint>(session: URLSession.shared, enableDebugLogs: true))
        near.viewAccessKeyChangesSingle(params: .init(keys: [AccountKey(accountId: "dev-1614442965550-6620932", publicKey: "ed25519:4FLSbHkoe6dNue8gtoABqDoyF6n92V5T2FngAoHQ2vsi")], blockIdOrFinality: .finality(.final))) { (result) in
            debugPrint(result)
            if case .success = result {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testViewAccessKeyChangesSingleMock() {
        let expectation = XCTestExpectation(description: "Network Call")
        let tuple: (session: URLSession, stub: NEARResponse<ViewAccessKeyChangesSingleResponse>) = getMockURLSession(fileName: "viewAccessKeyChangesSingle")

        let near = NEAR(environment: .testnet, router: Router<NEAREndpoint>(session: tuple.session, enableDebugLogs: true))
        near.viewAccessKeyChangesSingle(params: .init(keys: [AccountKey(accountId: "dev-1614442965550-6620932", publicKey: "ed25519:4FLSbHkoe6dNue8gtoABqDoyF6n92V5T2FngAoHQ2vsi")], blockIdOrFinality: .finality(.final))) { (result) in
            debugPrint(result)
            if case let .success(response) = result {
                XCTAssertEqual(response.blockHash, tuple.stub.result?.blockHash)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testViewAccessKeyChangesAll() {
        let expectation = XCTestExpectation(description: "Network Call")
        let near = NEAR(environment: .testnet, router: Router<NEAREndpoint>(session: URLSession.shared, enableDebugLogs: true))
        near.viewAccessKeyChangesAll(params: ViewAccessKeyChangesAllRequest(accountIDS: ["example-acct.testnet"], blockIdOrFinality: .finality(.final))) { (result) in
            debugPrint(result)
            if case .success = result {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testViewAccount() {
        let expectation = XCTestExpectation(description: "Network Call")
        let near = NEAR(environment: .testnet, router: Router<NEAREndpoint>(session: URLSession.shared, enableDebugLogs: true))
        near.viewAccount(params: .init(accountID: "nearkat.testnet", blockIdOrFinality: .finality(.final))) { (result) in
            debugPrint(result)
            if case .success = result {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testViewAccountMock() {
        let expectation = XCTestExpectation(description: "Network Call")
        let tuple: (session: URLSession, stub: NEARResponse<ViewAccountResponse>) = getMockURLSession(fileName: "viewAccount")

        let near = NEAR(environment: .testnet, router: Router<NEAREndpoint>(session: tuple.session, enableDebugLogs: true))
        near.viewAccount(params: .init(accountID: "nearkat.testnet", blockIdOrFinality: .finality(.final))) { (result) in
            debugPrint(result)
            if case let .success(response) = result {
                XCTAssertEqual(response.blockHash, tuple.stub.result?.blockHash)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testViewAccountChanges() {
        let expectation = XCTestExpectation(description: "Network Call")
        let near = NEAR(environment: .testnet, router: Router<NEAREndpoint>(session: URLSession.shared, enableDebugLogs: true))
        near.viewAccountChanges(params: .init(accountIds: ["nearkat.testnet"], blockIdOrFinality: .finality(.final))) { (result) in
            debugPrint(result)
            if case .success = result {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testViewContractState() {
        let expectation = XCTestExpectation(description: "Network Call")
        let near = NEAR(environment: .testnet, router: Router<NEAREndpoint>(session: URLSession.shared, enableDebugLogs: true))
        near.viewContractState(params: ViewContractStateRequest(accountID: "guest-book.testnet", prefixBase64: "", blockIdOrFinality: .finality(.final))) { (result) in
            debugPrint(result)
            if case .success = result {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCallContractStateChanges() {
        let expectation = XCTestExpectation(description: "Network Call")
        let near = NEAR(environment: .testnet, router: Router<NEAREndpoint>(session: URLSession.shared, enableDebugLogs: true))
        near.viewContractStateChanges(params: .init(accountIDS: ["guest-book.testnet"], keyPrefixBase64: "", blockIdOrFinality: .finality(.final))) { (result) in
            debugPrint(result)
            if case .success = result {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCallContractCodeChanges() {
        let expectation = XCTestExpectation(description: "Network Call")
        let near = NEAR(environment: .testnet, router: Router<NEAREndpoint>(session: URLSession.shared, enableDebugLogs: true))
        near.viewContractStateCodeChanges(params: ViewContractStateCodeChangesRequest(accountIDS: ["dev-1602714453032-7566969"], blockIdOrFinality: .finality(.final))) { (result) in
            debugPrint(result)
            if case .success = result {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testBlockDetailsHash() {
        let expectation = XCTestExpectation(description: "Network Call")
        let near = NEAR(environment: .testnet, router: Router<NEAREndpoint>(session: URLSession.shared, enableDebugLogs: true))
        near.blockDetails(params: .init(blockIdOrFinality: .hash("CtUCuCMHEKQTswpDgY96UwQmZiC4hX8SiLWuihVYdENS"))){ (result) in
            debugPrint(result)
            if case .success = result {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testBlockDetailsFinal() {
        let expectation = XCTestExpectation(description: "Network Call")
        let near = NEAR(environment: .testnet, router: Router<NEAREndpoint>(session: URLSession.shared, enableDebugLogs: true))
        near.blockDetails(params: .init(blockIdOrFinality: .finality(.final))){ (result) in
            debugPrint(result)
            if case .success = result {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCallContractFunctionMock() {
        let expectation = XCTestExpectation(description: "Network Call")
        
        let tuple: (session: URLSession, stub: NEARResponse<CallContractFunctionResponse>) = getMockURLSession(fileName: "callContractFunction")
        
        let near = NEAR(environment: .testnet, router: Router<NEAREndpoint>(session: tuple.session, enableDebugLogs: true))
        near.callContractFunction(params: CallContractFunctionRequest(accountID: "dev-1615008631986-5402557", methodName: "getCounter", blockIdOrFinality: .finality(.final), argsBase64: "")) { (result) in
            debugPrint(result)
            if case let .success(response) = result {
                XCTAssertEqual(response.blockHash, tuple.stub.result?.blockHash)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
}

func stubbedResponse(_ filename: String) -> Data {
    @objc class FeelitTests: NSObject { }
    let thisSourceFile = URL(fileURLWithPath: #file)
    let thisDirectory = thisSourceFile.deletingLastPathComponent()
    let resourceURL = thisDirectory.appendingPathComponent("fixtures/\(filename).json")
    return try! Data(contentsOf: resourceURL)
}
