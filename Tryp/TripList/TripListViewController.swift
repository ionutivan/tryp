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
    
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      let nib = UINib(nibName: cellIdentifier, bundle: nil)
      tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
      tableView.rowHeight = UITableView.automaticDimension
      tableView.estimatedRowHeight = 44
      tableView.backgroundView = UIImageView(image: UIImage(named: "Background"))
      tableView.separatorColor = Theme.Colors.warmGrey
      tableView.separatorInset = .zero
      tableView.refreshControl = refreshControl
    }
  }

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
        
        bindViews()
    }
    
    func bindViews() {
        
        viewModel.output.trips
            .drive(self.tableView.rx.items(cellIdentifier: cellIdentifier, cellType: TripListCell.self)) { (row, item, cell) in
                cell.pilotNameLabel?.text = item.pilot.name
                cell.dropOffNameLabel?.text = item.drop_off.name
                cell.pickUpNameLabel?.text = item.pick_up.name
                if let url = URL(string: baseURL.appending(item.pilot.avatar)) {
                    cell.pilotImageView.kf.setImage(with: url)
                }
                Int(item.pilot.rating) == 0 ?
                    cell.hideStarView() :
                    cell.starView.color(for: item.pilot.rating)
                
            }
            .disposed(by: disposeBag)
        
        viewModel.output.errorMessage.drive(onNext: { [weak self] errorMessage in
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
  
    }
    
    func showError(_ errorMessage: String) {
        let controller = UIAlertController(title: "An error occured", message: errorMessage, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
    
}
