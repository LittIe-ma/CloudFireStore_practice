//
//  ViewController.swift
//  CloudFireStore_practice
//
//  Created by Masato Yasuda on 2022/01/19.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

final class ViewController: UIViewController {

  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
    }
  }
  @IBOutlet private weak var textField: UITextField!
  private let db = Firestore.firestore()

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func didTapAddButton(_ sender: Any) {
    guard let text = textField.text, !text.isEmpty else { return }
    textField.text = ""
    db.collection("post").addDocument(data: ["text": text]) { error in
      if let error = error {
        print("Error adding document: \(error)")
      }
    }
  }

  @IBAction func didTapUpdateButton(_ sender: Any) {

    tableView.reloadData()
  }
}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    return cell
  }
}
