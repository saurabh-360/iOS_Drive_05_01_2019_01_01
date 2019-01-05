//Created 21/12/18
// Copyright © 2018 Viacom 18. All rights reserved.

import UIKit

import RxSwift
import RxCocoa

class StudentListViewController: UIViewController {

    @IBOutlet weak var runQueryButton: UIButton!

    @IBOutlet weak var tableview: UITableView!
    let viewModel = StudentListingViewModel()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getStudentData()
        self.bindUI()
        
    }

    func getStudentData() {
        
        self.viewModel.getStudentData().asObservable().subscribe(onNext: { data in
            print(data)
        }).disposed(by: self.disposeBag)
    }
    
    func bindUI() {
        
        self.viewModel.studentData.asObservable().bind(to: self.tableview.rx.items(cellIdentifier: String.init(describing: StudentListingTableViewCell.self), cellType: StudentListingTableViewCell.self)) {
            row, item, cell in
            cell.setData(model: item)
        }.disposed(by: self.disposeBag)
        
        self.runQueryButton.rx.tap.subscribe{ event in
            self.showQueryAlert()
        }.disposed(by: self.disposeBag)
    }
    
    func showQueryAlert() {
        let alertController = UIAlertController.init(title: "Choose", message: "Please select one", preferredStyle: .actionSheet)
        let rankSort = UIAlertAction.init(title: "Rank Sort", style: .default) { (action) in
            // sortOnRank
            self.viewModel.studentData.value = self.viewModel.tempResult.value
            
            self.viewModel.studentData.value = self.viewModel.studentData.value.sorted(by: { (a, b) -> Bool in
                return a.age! < b.age!
            })
            
            
        }
        
        let nameSort = UIAlertAction.init(title: "Name Sort", style: .default) { (action) in
//            sortOnRank
            self.viewModel.studentData.value = self.viewModel.tempResult.value
            
            self.viewModel.studentData.value = self.viewModel.studentData.value.sorted(by: { (a, b) -> Bool in
                return a.name! < b.name!
            })
            
        }
        
        let top3Sort = UIAlertAction.init(title: "Top 3 Sort", style: .default) { (action) in
//            sortOnRank
            
            self.viewModel.studentData.value = self.viewModel.tempResult.value
            let filteredData = self.viewModel.studentData.value.filter{$0.age! >= 15 && $0.age! <= 25}
            
            self.viewModel.studentData.value = filteredData.sorted(by: { (a, b) -> Bool in
                return a.age! < b.age!
            })
            
            
        }
        
        
        let avgSort = UIAlertAction.init(title: "Top 10 Sort", style: .default) { (action) in
//            sortOnRank
            self.viewModel.studentData.value = self.viewModel.tempResult.value
            
            
            let sortedOnRank = self.viewModel.studentData.value.sorted(by: { (a, b) -> Bool in
                return a.rank! < b.rank!
            })

            var avgAge = 0
            for i in 0..<10 {
                avgAge += sortedOnRank[i].age!
            }
            
            print(avgAge/10)
            
            
            self.showAlert(withMessage: "average age  = \(avgAge/10)")
            
            
        }
        
        alertController.addAction(rankSort)
        alertController.addAction(nameSort)
        alertController.addAction(top3Sort)
        alertController.addAction(avgSort)

        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    func showAlert(withMessage message: String){
        let alert = UIAlertController.init(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

