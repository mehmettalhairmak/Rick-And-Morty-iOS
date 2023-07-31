//
//  ListViewInterfaces.swift
//  Rick and Morty
//
//  Created by Mehmet Talha Irmak on 29.07.2023.
//

import Foundation

protocol ListViewInterface: AnyObject {
    func prepareListView()
    
    func changeLoading(isLoad: Bool)
    func reloadTableView()
}

protocol ListViewModelInterface {
    var view: ListViewInterface? { get set }
    
    var rickyMortyCharacters: [Result] { get set }
    
    func viewDidLoad()
    func changeLoading()
}
