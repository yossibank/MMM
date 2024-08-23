import Foundation

public struct APIModelItem: Sendable {
    public let data: Data
    public let urlRequest: URLRequest
    public let urlResponse: HTTPURLResponse
    public let queryItems: [URLQueryItem]?

    public init(
        data: Data,
        urlRequest: URLRequest,
        urlResponse: HTTPURLResponse,
        queryItems: [URLQueryItem]?
    ) {
        self.data = data
        self.urlRequest = urlRequest
        self.urlResponse = urlResponse
        self.queryItems = queryItems
    }
}
