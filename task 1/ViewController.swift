//
//  ViewController.swift
//  task 1
//
//  Created by thrxmbxne on 22/01/24.
//
import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		let contentView = MessageFieldView()
		contentView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(contentView)

		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: view.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}
