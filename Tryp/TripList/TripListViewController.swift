//
//  TripListViewController.swift
//  Tryp
//
//  Created by Ionut Ivan on 12/5/19.
//  Copyright © 2019 Ionut Ivan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class TripListViewController: UIViewController {
    
  lazy var tableView: UITableView! = {
    let tableView = UITableView()
    tableView.register(TripListCell.self, forCellReuseIdentifier: cellIdentifier)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 44
    tableView.backgroundView = UIImageView(image: UIImage(named: "Background"))
    tableView.separatorColor = Theme.Colors.warmGrey
    tableView.separatorInset = .zero
    tableView.refreshControl = refreshControl
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

    let refreshControl = UIRefreshControl()
    let cellIdentifier = "TripListCell"
    
    private var viewModel: TripListViewModel!
    private let disposeBag = DisposeBag()
    let api = TripAPI()
    convenience init(viewModel: TripListViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      view.addSubview(tableView)
      
      constraintInit()
        
      bindViews()
    }
  
  func constraintInit() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    ])
  }
    
    func bindViews() {
        
      viewModel.output.trips
        .observeOn(MainScheduler.instance)
        .bind(to: self.tableView.rx.items(cellIdentifier: cellIdentifier, cellType: TripListCell.self)) { (row, item, cell) in
          let viewModel = TripCellViewModel(item: item)
          cell.viewModel = viewModel
          }
          .disposed(by: disposeBag)
        
      viewModel.output.errorMessage.observeOn(MainScheduler.instance).asObservable().subscribe(onNext:  { [weak self] errorMessage in
                guard let strongSelf = self else { return }
                strongSelf.showError(errorMessage)
            })
            .disposed(by: disposeBag)
            
        tableView.rx.modelSelected(Trip.self)
            .subscribe(onNext: { [weak self] model in
                
              self?.viewModel.output.selectTrip.accept(model)
              if let selectedIndexPath = self?.tableView.indexPathForSelectedRow {
                self?.tableView.deselectRow(at: selectedIndexPath, animated: true)
              }
            }
        )
            .disposed(by: disposeBag)
      
      refreshControl.rx.controlEvent(.valueChanged)
        .delay(.seconds(3), scheduler: MainScheduler.instance)
        .subscribe(onNext: { [weak self] in
          self?.refreshControl.endRefreshing()
          self?.viewModel.input.reload.accept(true)
        })
        .disposed(by: disposeBag)
      
      viewModel.getTrips()
  
    }
    
    func showError(_ errorMessage: String) {
        let controller = UIAlertController(title: "An error occured", message: errorMessage, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
    
}
