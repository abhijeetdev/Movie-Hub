import XCTest
@testable import MovieHub

final class ServiceTests: XCTestCase {
    var service: Service!
    
    override func setUp() {
        super.setUp()
        //Mock URL Session
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolMock.self]
        let mockedSession =  URLSession(configuration: sessionConfiguration)
        
        service = Service(session: mockedSession)
    }
    
    override func tearDown() {
        service = nil
        URLProtocolMock.mockURLs.removeAll()
        super.tearDown()
    }
    
    func testValidResponse() {
        // Given:
        let urlRequestedMock: URL! = URL(string: "https://www.exaple1.com/api")
        
        let response = HTTPURLResponse(url: urlRequestedMock, statusCode: 200, httpVersion: nil, headerFields: nil)
        let error: Error? = nil
        let data = """
          [
            {
              "someJsonKey": "someJsonData",
              "anotherJsonKey": "anotherJsonData"
            }
          ]
        """.data(using: .utf8)
        
        URLProtocolMock.mockURLs[urlRequestedMock] = (error, data, response)
        
        //When:
        let request = Request(endpoint: "https://www.exaple1.com/api")
        service.GET(request: request) { (result: Result<[[String: String]], Error>) in
            switch result {
                //Then
            case .success(let responseModel):
                XCTAssertEqual(responseModel[0]["someJsonKey"], "someJsonData")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testInvalidResponse() {
        // Given: Response status 401, Server error
        
        let urlRequestedMock: URL! = URL(string: "https://www.exaple2.com/api")
        
        let response = HTTPURLResponse(url: urlRequestedMock, statusCode: 401, httpVersion: nil, headerFields: nil)
        let error: Error? = nil
        let data = """
          [
            {
              "someJsonKey": "someJsonData",
              "anotherJsonKey": "anotherJsonData"
            }
          ]
        """.data(using: .utf8)
        
        URLProtocolMock.mockURLs[urlRequestedMock] = (error, data, response)
        
        //When:
        let request = Request(endpoint: "https://www.exaple2.com/api")
        service.GET(request: request) { (result: Result<[[String: String]], Error>) in
            switch result {
                //Then
            case .success(let responseModel):
                XCTFail("invalid: \(responseModel)")
            case .failure(let error):
                XCTAssertEqual(ServiceError.invalidResponse.localizedDescription, error.localizedDescription)
            }
        }
    }
    
    func testStatusCodeError() {
        // Given: Response status 501, Server error
        
        let urlRequestedMock: URL! = URL(string: "https://www.exaple3.com/api")
        
        let response = HTTPURLResponse(url: urlRequestedMock, statusCode: 501, httpVersion: nil, headerFields: nil)
        let error: Error? = nil
        let data = """
          [
            {
              "someJsonKey": "someJsonData",
              "anotherJsonKey": "anotherJsonData"
            }
          ]
        """.data(using: .utf8)
        
        URLProtocolMock.mockURLs[urlRequestedMock] = (error, data, response)
        
        //When:
        let request = Request(endpoint: "https://www.exaple3.com/api")
        service.GET(request: request) { (result: Result<[[String: String]], Error>) in
            switch result {
                //Then
            case .success(let responseModel):
                XCTFail("invalid: \(responseModel)")
            case .failure(let error):
                if case ServiceError.statusCode(let code) = error {
                    XCTAssertEqual(code, 500)
                }
                
            }
        }
    }
    
    func testDecodingError() {
        // Given: Decode error
        let urlRequestedMock: URL! = URL(string: "https://www.exaple4.com/api")
        
        let response = HTTPURLResponse(url: urlRequestedMock, statusCode: 200, httpVersion: nil, headerFields: nil)
        let error: Error? = nil
        let data: Data? = nil
        
        URLProtocolMock.mockURLs[urlRequestedMock] = (error, data, response)
        
        //When:
        let request = Request(endpoint: "https://www.exaple4.com/api")
        service.GET(request: request) { (result: Result<[[String: String]], Error>) in
            switch result {
                //Then
            case .success(let responseModel):
                XCTFail("invalid: \(responseModel)")
            case .failure(let error):
                XCTAssertEqual("The data couldn’t be read because it isn’t in the correct format.", error.localizedDescription)
                
            }
        }
    }
}
