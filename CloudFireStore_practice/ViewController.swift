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
  private var personCount: Int = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  @IBAction func didTapAddButton(_ sender: Any) {
    guard let name = textField.text, !name.isEmpty else { return }
    textField.text = ""
    personCount += 1
    let person = PersonModel(name: name)
    let db = Firestore.firestore()
    do {
      try db.collection("Person").document("person\(personCount)").setData(from: person)
    } catch let error {
      print("Firestore error: \(error)")
    }
  }

  @IBAction func didTapUpdateButton(_ sender: Any) {

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
    cell.textLabel?.text = "text"
    return cell
  }
}
