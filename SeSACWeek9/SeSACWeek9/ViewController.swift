//
//  ViewController.swift
//  SeSACWeek9
//
//  Created by 이중원 on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lottoLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private var viewModel = PersonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let example = User("고래밥")
        example.bind { name in
            print("이름이 \(name)으로 바뀌었습니다")
        }
        example.value = "칙촉"
        
        let sample = User([1,2,3,4,5])
        
        sample.bind { value in
            print(value)
        }
        
        
        var number1 = 10
        var number2 = 3
        
        print(number1 - number2) //7
        
        number1 = 3 //0
        number2 = 1 //2
        
        var number3 = Observable(10)
        var number4 = Observable(3)
        
        number3.bind { a in
            print("Observable", number3.value - number4.value)
        }
        
        number3.value = 100
        number3.value = 200
        number3.value = 50
        

        viewModel.fetchPerson(query: "kim")
        
        viewModel.list.bind { person in
            print("viewController bind")
            self.tableView.reloadData()
        }
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let data = viewModel.cellForRowAt(at: indexPath)
        
        cell.textLabel?.text = data.name
        cell.detailTextLabel?.text = data.knownForDepartment
        return cell
    }
}

