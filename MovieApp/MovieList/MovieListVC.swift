//
//  MovieListVC.swift
//  MovieApp
//
//  Created by Muhammad Darain on 07/04/2023.
//

import UIKit

class MovieListVC: BaseViewController {
    
    @IBOutlet var tableView:UITableView!
    private let refreshControl = UIRefreshControl()

    private var viewModel: MovieListViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieListViewModel()
        bindViewDidLoad(to: viewModel.input.viewDidLoad)
        setupTableView()
        addObservables()
        
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .white
        tableView.registerNib(cell:MoviesListTVC.self)
        tableView.contentInset.bottom = 5
        tableView.refreshControl = refreshControl
        tableView.delegate = self
        refreshControl.tintColor = .red
    }

    override func addObservables() {
        super.addObservables()
        
        viewModel
            .output
            .dataSource
            .bind(to: tableView) { rows, indexPath, tableView in
                tableView.endRefreshing()
                let row = rows[indexPath.row]
                
                let cell: MoviesListTVC = tableView.dequeueCell(for: indexPath)
                cell.configure(with: row)
                cell.button.tag = indexPath.row
                cell.button.addTarget(self, action: #selector(self.buttonClicked(sender:)), for: .touchUpInside)
                return cell
            }
        
        viewModel
            .output
            .error
            .bind(to: self){ viewController, error in
                print("error: ",error)
                
            }
        
        viewModel
            .output
            .route
            .bind(to: self){ viewController, router in
                switch router{
                case .movieDetail(let id, let image):
                    let vc = MovieDetailVC.create(movieID: id)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                
            }
        
    }
    
    @objc func buttonClicked(sender:UIButton){
        viewModel.input.selectItemTrigger.send(sender.tag)
    }
    
}

extension MovieListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let totalRows = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.item == totalRows{
            viewModel
                .input
                .paginationTrigger
                .send()
        }
    }
}
