import SnapKit
import UIKit

final class SampleView: UIView {
    private let label = UILabel()

    init() {
        super.init(frame: .zero)

        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(label)

        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    @discardableResult
    func configure(with text: String) -> Self {
        label.text = text
        return self
    }
}

#Preview("SampleView") {
    SampleView()
        .configure(with: "Hello World!")
}
