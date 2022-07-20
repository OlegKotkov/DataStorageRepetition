
import UIKit
import CoreData
class SecondViewController: UIViewController {
    
    var person: Person?
    
    private let buttonSave: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let textFieldName: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = .secondarySystemFill
        textField.layer.cornerRadius = 10
        textField.placeholder = "NameVampire"
        textField.font = .systemFont(ofSize: 20)
        textField.clearButtonMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private let textFieldAge: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = .secondarySystemFill
        textField.layer.cornerRadius = 10
        textField.placeholder = "AgeVampire"
        textField.font = .systemFont(ofSize: 20)
        textField.clearButtonMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private let label: UILabel = {
       let label = UILabel()
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(buttonSave)
        view.addSubview(textFieldName)
        view.addSubview(textFieldAge)
        setConstraints()
        buttonSave.addTarget(self, action: #selector(turnToVampire), for: .touchUpInside)
        //saveToVampire()
        //Чтение обьекта(не получается сделать функцию редактирования по нажатию на ячейку, поэто код ниже не работает)
//        if let person = person {
//            textFieldName.text = person.name
//            textFieldAge.text = String(person.age)
//        }
    }
    func setConstraints(){
        NSLayoutConstraint.activate([
            buttonSave.widthAnchor.constraint(equalToConstant: 300),
            buttonSave.heightAnchor.constraint(equalToConstant: 50),
            buttonSave.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonSave.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -10),
            textFieldAge.widthAnchor.constraint(equalToConstant: 300),
            textFieldAge.heightAnchor.constraint(equalToConstant: 50),
            textFieldAge.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldAge.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 30),
            
            textFieldName.widthAnchor.constraint(equalToConstant: 300),
            textFieldName.heightAnchor.constraint(equalToConstant: 50),
            textFieldName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldName.topAnchor.constraint(equalTo: view.topAnchor, constant: 130)
        ])
    }
    @objc func turnToVampire() -> Bool {
//        if saveToVampire() {
//            dismiss(animated: true, completion: nil)
//        }
        if textFieldName.text!.isEmpty {
            let alert = UIAlertController(title: "Ошибка ввода", message: "Вы не заполнили поле NAME -  сохранение невозможно", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present (alert, animated: true, completion: nil)
            return false
        }
        //Создаем обьект
        if person == nil {
            person = Person()
        }
        //Соxранить обьект
        if let person = person {
            person.name = textFieldName.text
            person.age = Int16(textFieldAge.text!)!
            CoreDataManager.instantse.saveContext()
        }
        return true
    }
}

