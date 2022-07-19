//
//  ViewController.swift
//  FlexViewDemo
//
//  Created by Jorge Benavides on 19/07/22.
//

import UIKit
import FlexView

class ViewController: UIViewController {

    let flexView = FlexView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(flexView)
        flexView.layer.borderColor = UIColor.red.cgColor
        flexView.layer.borderWidth = 1
        flexView.translatesAutoresizingMaskIntoConstraints = false
        flexView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        flexView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        flexView.items = ["star", "house", "heart"].map { UIImage(systemName: $0) }.map {
            let imageview = UIImageView(image: $0)
            imageview.widthAnchor.constraint(equalToConstant: CGFloat.random(in: 50...150)).isActive = true
            imageview.heightAnchor.constraint(equalToConstant: CGFloat.random(in: 50...150)).isActive = true
            imageview.contentMode = .scaleAspectFit
            return imageview
        }


        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
    }

    @objc func tapped() {
        flexView.direction = (flexView.direction == .horizontal) ? .vertical : .horizontal
        UIView.animate(withDuration: 0.3, animations: {
            self.flexView.layoutIfNeeded()
        })
    }

}


