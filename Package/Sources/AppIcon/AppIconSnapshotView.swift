import Photos
import SwiftUI

public struct AppIconSnapshotView: View {
    @State private var isShowAlert = false
    @State private var message = ""

    private let iconName: String
    private let iconColor: Color

    public init(
        iconName: String,
        iconColor: Color
    ) {
        self.iconName = iconName
        self.iconColor = iconColor
    }

    public var body: some View {
        VStack {
            Spacer()

            AppIconView(iconName: iconName, iconColor: iconColor)
                .frame(width: 300, height: 300)

            Text(iconName)
                .font(.headline)

            Spacer()

            Button("アイコン保存") {
                saveIcon()
            }
        }
        .alert("結果", isPresented: $isShowAlert) {} message: {
            Text(message)
        }
    }

    private func saveIcon() {
        Task { @MainActor in
            let viewSize = CGSize(
                width: 1024,
                height: 1024
            )

            let hostingController = UIHostingController(
                rootView: AppIconView(iconName: iconName, iconColor: iconColor)
                    .frame(width: viewSize.width, height: viewSize.height)
                    .offset(.init(width: .zero, height: -12))
                    .background(iconColor)
            )

            hostingController.view.frame = .init(origin: .zero, size: viewSize)
            hostingController.view.backgroundColor = .clear

            let image = hostingController.snapshot(viewSize: viewSize)

            guard let data = image.pngData() else {
                return
            }

            PHPhotoLibrary.shared().performChanges({
                let request = PHAssetCreationRequest.forAsset()
                request.addResource(
                    with: .photo,
                    data: data,
                    options: nil
                )
            }) { _, error in
                message = error == nil
                    ? "アイコンを保存しました。"
                    : "アイコンの保存に失敗しました。"

                isShowAlert = true
            }
        }
    }
}

private extension UIViewController {
    func snapshot(viewSize: CGSize) -> UIImage {
        let format: UIGraphicsImageRendererFormat = {
            $0.scale = 1.0
            return $0
        }(UIGraphicsImageRendererFormat.default())

        let renderer = UIGraphicsImageRenderer(
            size: viewSize,
            format: format
        )

        let image = renderer.image { _ in
            view.drawHierarchy(
                in: .init(
                    origin: .zero,
                    size: viewSize
                ),
                afterScreenUpdates: true
            )
        }

        return image
    }
}

#Preview {
    AppIconSnapshotView(iconName: "m.square.fill", iconColor: .black)
}
