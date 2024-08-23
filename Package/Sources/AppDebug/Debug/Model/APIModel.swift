import Foundation
import SwiftData

@Model
public final class APIModel: @unchecked Sendable {
    @Attribute(.unique)
    public var id: String
    public var date: Date
    public var category: LogCategory
    public var host: String?
    public var path: String?
    public var contentType: String?
    public var httpMethod: String?
    public var httpBody: String?
    public var responseBody: String?
    public var responseSize: String?
    public var queryItems: [String: String?]
    public var statusCode: Int

    public init(
        id: String = UUID().uuidString,
        date: Date = .now,
        category: LogCategory = .networking,
        host: String?,
        path: String?,
        contentType: String?,
        httpMethod: String?,
        httpBody: String?,
        responseBody: String?,
        responseSize: String?,
        queryItems: [String: String?],
        statusCode: Int
    ) {
        self.id = id
        self.date = date
        self.category = category
        self.host = host
        self.path = path
        self.contentType = contentType
        self.httpMethod = httpMethod
        self.httpBody = httpBody
        self.responseBody = responseBody
        self.responseSize = responseSize
        self.queryItems = queryItems
        self.statusCode = statusCode
    }

    public init(item: APIModelItem) {
        self.id = UUID().uuidString
        self.date = .now
        self.category = .networking
        self.host = item.urlRequest.url?.host(percentEncoded: false)
        self.path = item.urlRequest.url?.path(percentEncoded: false)
        self.contentType = item.urlRequest.allHTTPHeaderFields?["Content-Type"]
        self.httpMethod = item.urlRequest.httpMethod

        self.httpBody = {
            guard let data = item.urlRequest.httpBody else {
                return nil
            }

            return String(data: data, encoding: .utf8)
        }()

        self.responseBody = {
            guard let responseBody = String(data: item.data, encoding: .utf8) else {
                return nil
            }

            return responseBody
        }()

        self.responseSize = {
            let formatter = ByteCountFormatter()
            formatter.allowedUnits = [.useKB]
            formatter.isAdaptive = true
            formatter.zeroPadsFractionDigits = true
            formatter.countStyle = .binary
            return formatter.string(fromByteCount: Int64(item.data.count))
        }()

        self.queryItems = {
            guard let queryItems = item.queryItems else {
                return [:]
            }

            return queryItems.reduce(into: [String: String?]()) {
                $0[$1.name] = $1.value
            }
        }()

        self.statusCode = item.urlResponse.statusCode
    }
}

public extension APIModel {
    static let mock = APIModel(
        date: Date().addingTimeInterval(-20),
        host: "app.rakuten.co.jp",
        path: "/services/api/IchibaItem/Search/20220601/",
        contentType: "application/json",
        httpMethod: "GET",
        httpBody: """
        {"userId":1,"id":1,"title":"sunt aut facere repellat provident occaecati excepturi optio reprehenderit"}
        """,
        responseBody: """
        {"userId":2,"id":2,"title":"sunt aut facere repellat provident occaecati excepturi optio reprehenderit"}
        """,
        responseSize: "100KB",
        queryItems: [
            "applicationId": "1032211485929725116",
            "formatVersion": "2",
            "hits": "30",
            "keyword": "からあげ",
            "page": "1"
        ],
        statusCode: 200
    )
}
