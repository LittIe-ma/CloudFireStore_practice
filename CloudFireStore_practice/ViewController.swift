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
  private var items: [String] = []

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func didTapAddButton(_ sender: Any) {
    guard let text = textField.text, !text.isEmpty else { return }
    textField.text = ""
    db.collection("posts").addDocument(data: ["text": text]) { error in
      if let error = error {
        print("Error adding document: \(error)")
      }
    }
  }

  @IBAction func didTapUpdateButton(_ sender: Any) {
    db.collection("posts").getDocuments() { (querySnapshot, error) in
      if let error = error {
        print("Error getting documents: \(error)")
      } else {
        self.items = []
        for document in querySnapshot!.documents {
          let data = document.data()
          guard let text = data["text"] as? String else { return }
          self.items.append(text)
        }
      }
    }
    tableView.reloadData()
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(items[indexPath.row])
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    if #available(iOS 14.0, *) {
      var content = cell.defaultContentConfiguration()
      content.text = items[indexPath.row]
      cell.contentConfiguration = content
    } else {
      cell.textLabel?.text = items[indexPath.row]
    }
    return cell
  }
}
