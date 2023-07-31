//
//  ViewController.swift
//  Rick and Morty
//
//  Created by Mehmet Talha Irmak on 28.07.2023.
//

import UIKit
import SnapKit

final class ListViewController: UIViewController {
    private let labelTitle: UILabel = UILabel()
    private let tableView: UITableView = UITableView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private lazy var viewModel: ListViewModelInterface = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
        
        configureUI()
    }
}

//MARK: - TableView Delegate & DataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rickyMortyCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RickyMortyCell = tableView.dequeueReusableCell(withIdentifier: RickyMortyCell.Identifier.custom.rawValue) as? RickyMortyCell else {
            return UITableViewCell()
        }
        
        cell.saveModel(result: viewModel.rickyMortyCharacters[indexPath.row])
        
        return cell
    }
}

//MARK: - ListViewModel Method Transferring
extension ListViewController: ListViewInterface {
    func prepareListView() {
        
    }
    
    func changeLoading(isLoad: Bool) {
        DispatchQueue.main.async {
            isLoad ? self.indicator.startAnimating() : self.indicator.stopAnimating()
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - Configure UI
extension ListViewController {
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)
        
        drawDesign()
        
        makeLabelTitle()
        makeTableView()
        makeIndicator()
    }
    
    private func drawDesign() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RickyMortyCell.self, forCellReuseIdentifier: RickyMortyCell.Identifier.custom.rawValue)
        
        DispatchQueue.main.async {
            self.labelTitle.text = "Ricky Morty"
            self.labelTitle.font = .boldSystemFont(ofSize: 24)
            
            self.tableView.rowHeight = self.view.frame.height * 0.15
            self.tableView.showsVerticalScrollIndicator = false
            
            self.indicator.color = .systemRed
        }
    }
    
    private func makeLabelTitle() {
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
    }
    
    private func makeTableView() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(labelTitle)
        }
    }
    
    private func makeIndicator() {
        indicator.snp.makeConstraints { make in
            make.height.equalTo(labelTitle)
            make.top.equalTo(labelTitle)
            make.right.equalTo(labelTitle).offset(-5)
        }
    }
}

