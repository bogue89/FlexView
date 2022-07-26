//
//  ViewController.swift
//  FlexViewDemo
//
//  Created by Jorge Benavides on 19/07/22.
//

import UIKit
import FlexView

class ViewController: UIViewController {

    var icons: [UIImageView] {
        Array(repeating: "photo", count: 3)
            .compactMap {
                UIImage(systemName: $0)
            }
            .map {
                let imageview = UIImageView(image: $0)
                let size =  CGFloat.random(in: 50...120)
                imageview.widthAnchor.constraint(equalToConstant: size).isActive = true
                imageview.heightAnchor.constraint(equalToConstant: size).isActive = true
                imageview.contentMode = .scaleAspectFit
                imageview.addBorder(.blue)
                return imageview
        }
    }

    lazy
    var flexView: FlexView = {
        let view = FlexView()
        view.items = icons
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addBorder(.red)
        return view
    }()

    lazy
    var toolbar: UIToolbar = {
        let view = UIToolbar()
        view.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Direction", style: .plain, target: self, action: #selector(changeDirection)),
            UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(regenerateIcons)),
            UIBarButtonItem(title: "Alignment", style: .plain, target: self, action: #selector(changeAlignment)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
        ]
        view.translatesAutoresizingMaskIntoConstraints = false
        view.barStyle = .black
        view.isTranslucent = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(flexView)
        view.addSubview(toolbar)

        NSLayoutConstraint.activate([
            flexView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flexView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ViewController {

    @objc func changeDirection() {
        flexView.direction = (flexView.direction != .vertical) ? .vertical : .horizontal
        UIView.animate(withDuration: 0.3, animations: {
            self.flexView.layoutIfNeeded()
        })
    }

    @objc func regenerateIcons() {
        flexView.items = icons
    }

    @objc func changeAlignment() {
        switch flexView.direction {
        case .horizontal:
            flexView.alignment = (flexView.alignment != .top) ? .top : .bottom
        case .vertical:
            flexView.alignment = (flexView.alignment != .left) ? .left : .right
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.flexView.layoutIfNeeded()
        })
    }
}

extension UIView {
    func addBorder(_ color: UIColor, width: CGFloat = 1) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
}
