import UIKit

open class FlexView: UIView {

    /// the direction in which the flexview will align items
    public enum Direction {
        case horizontal, vertical
    }

    public enum Alignment {
        case top, left, right, bottom, center
    }

    public var direction: Direction = .vertical {
        didSet {
            invalidateConstraints()
        }
    }

    public var alignment: Alignment = .center {
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
        switch direction {
        case .vertical:
            return setupVerticalConstraints(items, to: self)
        case .horizontal:
            return  setupHorizontalConstraints(items, to: self)
        }
    }

    public func setupVerticalConstraints(_ items: [UIView], to superview: UIView) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        var last: UIView?
        items.forEach { view in
            switch alignment {
            case .left:
                constraints.append(view.leadingAnchor.constraint(equalTo: superview.leadingAnchor))
            case .right:
                constraints.append(view.trailingAnchor.constraint(equalTo: superview.trailingAnchor))
            default: // .center:
                constraints.append(view.centerXAnchor.constraint(equalTo: superview.centerXAnchor))
            }
            constraints.append(superview.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor))
            constraints.append(view.topAnchor.constraint(equalTo: last?.bottomAnchor ?? superview.topAnchor))
            last = view
        }
        if let last = last {
            constraints.append(superview.bottomAnchor.constraint(equalTo: last.bottomAnchor))
        }
        return constraints
    }

    private func setupHorizontalConstraints(_ items: [UIView], to superview: UIView) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        var last: UIView?
        items.forEach { view in
            switch alignment {
            case .top:
                constraints.append(view.topAnchor.constraint(equalTo: superview.topAnchor))
            case .bottom:
                constraints.append(view.bottomAnchor.constraint(equalTo: superview.bottomAnchor))
            default: // .center:
                constraints.append(view.centerYAnchor.constraint(equalTo: superview.centerYAnchor))
            }
            constraints.append(superview.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor))
            constraints.append(view.leadingAnchor.constraint(equalTo: last?.trailingAnchor ?? superview.leadingAnchor))
            last = view
        }
        if let last = last {
            constraints.append(superview.trailingAnchor.constraint(equalTo: last.trailingAnchor))
        }
        return constraints
    }
}
