import UIKit

public class FlexView: UIView {

    public enum Direction {
        case horizontal, vertical
    }

    public var direction: Direction = .vertical {
        didSet {
            invalidateConstraints()
        }
    }

    public var items: [UIView] = [] {
        didSet {
            oldValue.forEach {
                $0.removeFromSuperview()
            }
            items.forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                addSubview($0)
            }
            invalidateConstraints()
        }
    }

    private var allConstraints: [NSLayoutConstraint] = []

    private func invalidateConstraints() {
        allConstraints.forEach { $0.isActive = false }
        allConstraints = setupConstrains()
        allConstraints.forEach { $0.isActive = true }
    }

    private func setupConstrains() -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        switch direction {
        case .vertical:
            var last: UIView?
            items.forEach { view in
                constraints.append(view.centerXAnchor.constraint(equalTo: centerXAnchor))
                constraints.append(widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor))
                constraints.append(view.topAnchor.constraint(equalTo: last?.bottomAnchor ?? topAnchor))
                last = view
            }
            if let last = last {
                constraints.append(bottomAnchor.constraint(equalTo: last.bottomAnchor))
            }
        case .horizontal:

            var last: UIView?
            items.forEach { view in
                constraints.append(view.centerYAnchor.constraint(equalTo: centerYAnchor))
                constraints.append(heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor))
                constraints.append(view.leadingAnchor.constraint(equalTo: last?.trailingAnchor ?? leadingAnchor))
                last = view
            }
            if let last = last {
                constraints.append(trailingAnchor.constraint(equalTo: last.trailingAnchor))
            }
        }
        return constraints
    }
}
