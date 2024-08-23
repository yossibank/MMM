import SwiftUI

struct StatusCodeView: View {
    let statusCode: Int

    var body: some View {
        Text(statusCodeTitle())
            .font(.caption2)
            .foregroundStyle(.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(statusCodeColor())
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .lineLimit(1)
    }

    private func statusCodeTitle() -> String {
        let title = switch statusCode {
        case 100: "Continue"
        case 101: "Switching Protocols"
        case 200: "OK"
        case 201: "Created"
        case 202: "Accepted"
        case 203: "Non-Authoritative Information"
        case 204: "No Content"
        case 205: "Reset Content"
        case 206: "Partial Content"
        case 300: "Multiple Choices"
        case 301: "Moved Permanently"
        case 302: "Found"
        case 303: "See Other"
        case 304: "Not Modified"
        case 305: "Use Proxy"
        case 400: "Bad Request"
        case 401: "Unauthorized"
        case 402: "Payment Required"
        case 403: "Forbidden"
        case 404: "Not Found"
        case 405: "Method Not Allowed"
        case 406: "Not Acceptable"
        case 407: "Proxy Authentication Required"
        case 408: "Request Time-out"
        case 409: "Conflict"
        case 410: "Gone"
        case 411: "Length Required"
        case 412: "Precondition Failed"
        case 413: "Request Entity Too Large"
        case 414: "Request-URI Too Large"
        case 415: "Unsupported Media Type"
        case 429: "Too Many Requests"
        case 500: "Internal Server Error"
        case 501: "Not Implemented"
        case 502: "Bad Gateway"
        case 503: "Service Unavailable"
        case 504: "Gateway Time-out"
        case 505: "HTTP Version not supported"
        default: "Unknown"
        }

        return "\(statusCode) \(title)"
    }

    private func statusCodeColor() -> Color {
        switch statusCode {
        case 100...101: .teal
        case 200...206: .green
        case 300...305: .indigo
        case 400...415, 429: .pink
        case 500...504: .red
        default: .gray
        }
    }
}

#Preview {
    VStack(spacing: 8) {
        StatusCodeView(statusCode: 100)
        StatusCodeView(statusCode: 200)
        StatusCodeView(statusCode: 300)
        StatusCodeView(statusCode: 400)
        StatusCodeView(statusCode: 500)
        StatusCodeView(statusCode: 999)
    }
}
