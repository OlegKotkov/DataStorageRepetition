
import UIKit
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var result: Result?
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        parceJson()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
    }
    //JSON
    private func parceJson() {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(Result.self, from: jsonData)
            //Для проверки работы на стации создания
//            if let result = result {
//                print(result)
//            } else {
//                print("Faled to pase")
//            }
//        return
        } catch {
            print("Error\(error)")
        }
    }
    // TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return result?.data.count ?? 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return result?.data[section].title
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let result = result {
            return result.data[section].items.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let text = result?.data[indexPath.section].items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = text
        return cell
    }
}

