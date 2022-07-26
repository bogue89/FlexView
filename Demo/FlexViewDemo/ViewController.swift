//
//  ViewController.swift
//  FlexViewDemo
//
//  Created by Jorge Benavides on 19/07/22.
//

import UIKit
import FlexView

class ViewController: UIViewController {

    let icons: [UIImageView] = ["star", "house", "heart"]
        .compactMap {
            UIImage(systemName: $0)
        }
        .map {
            let imageview = UIImageView(image: $0)
            let size =  CGFloat.random(in: 50...150)
            imageview.widthAnchor.constraint(equalToConstant: size).isActive = true
            imageview.heightAnchor.constraint(equalToConstant: size).isActive = true
            imageview.contentMode = .scaleAspectFit
            imageview.addBorder(.blue)
            return imageview
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(flexView)
        flexView.addBorder(.red)
        flexView.translatesAutoresizingMaskIntoConstraints = false
        flexView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        flexView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }

    let flexView = FlexView()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        flexView.items = icons

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
    }

    @objc func tapped() {
        flexView.direction = (flexView.direction == .horizontal) ? .vertical : .horizontal
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
