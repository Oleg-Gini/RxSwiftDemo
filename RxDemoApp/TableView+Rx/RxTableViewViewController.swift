//
//  RxTableViewViewController.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevsky on 04/10/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RxTableViewViewController: UIViewController
{
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        bindTableView()
    }
    
    func bindTableView()
    {
        let cities = Observable.of(["Lisbon", "Copenhagen", "London", "Madrid","Vienna"])
        
        cities.bind(to: tableView.rx.items) { (tableView: UITableView, index: Int, element: String) in
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = element
            
            return cell
        }
        .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext: { model in
                print("\(model) was selected")
            })
            .disposed(by: disposeBag)
    }
}
