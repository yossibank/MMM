import SwiftUI

struct JsonStringView: View {
    let string: String

    var body: some View {
        if string.starts(with: "http"),
           let url = URL(string: string) {
            HStack(spacing: 4) {
                Text(string)
                    .foregroundStyle(.green)
                    .underline()

                Text("(URL)")
                    .foregroundStyle(.gray)
            }
            .compositingGroup()
            .contextMenu {
                Button {
                    UIApplication.shared.open(url)
                } label: {
                    Label("Open is Safari", systemImage: "safari")
                }

                Button {
                    UIPasteboard.general.url = url
                } label: {
                    Label("Copy", systemImage: "doc.on.doc")
                }
            }
        } else {
            Text("\"\(string)\"")
                .foregroundStyle(.green)
                .contextMenu {
                    Button {
                        UIPasteboard.general.string = string
                    } label: {
                        Label("Copy", systemImage: "doc.on.doc")
                    }
                }
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        JsonStringView(string: "https://google.com")
        JsonStringView(string: "文字列だとこうなる")
    }
}
