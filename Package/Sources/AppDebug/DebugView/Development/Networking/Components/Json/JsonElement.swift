import Foundation

enum JsonElement: Equatable {
    case string(String)
    case int(Int)
    case num(Double)
    case flag(Bool)
    case nested([String: JsonElement])
    case list([JsonElement])
    case null
    case error(String)

    var isValue: Bool {
        switch self {
        case .string, .int, .num, .null: true
        default: false
        }
    }

    var isEmpty: Bool {
        switch self {
        case let .list(items):
            items.isEmpty

        case let .nested(dictionary):
            dictionary.isEmpty

        default:
            false
        }
    }

    static func parse(_ json: String) -> JsonElement {
        if json.isEmpty {
            return .error("{empty}")
        }

        do {
            return try map(
                JSONSerialization.jsonObject(
                    with: json.data(using: .utf8)!,
                    options: [.fragmentsAllowed] // 不完全なJSONを許容する
                )
            )
        } catch {
            return .error(error.localizedDescription)
        }
    }

    private static func map(_ json: Any?) -> JsonElement {
        guard let json else {
            return .error("{empty}")
        }

        switch json {
        case let nsString as NSString:
            return .string(.init(nsString))

        case let nsNumber as NSNumber:
            let encoding = String(cString: nsNumber.objCType)

            if encoding == "d" {
                return .num(.init(truncating: nsNumber))
            }

            if encoding == "c" {
                return .flag(.init(exactly: nsNumber)!)
            }

            return .int(.init(truncating: nsNumber))

        case let nsDictionary as NSDictionary:
            return .nested(nsDictionary.reduce(into: [:]) { result, arg in
                guard let key = arg.key as? String else {
                    return
                }

                result[key] = JsonElement.map(arg.value)
            })

        case let nsArray as NSArray:
            return .list(nsArray.map { map($0) })

        case is NSNull:
            return .null

        default:
            return .error("\(json)")
        }
    }
}
