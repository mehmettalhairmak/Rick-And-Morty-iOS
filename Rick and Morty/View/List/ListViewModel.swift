//
//  ListViewModel.swift
//  Rick and Morty
//
//  Created by Mehmet Talha Irmak on 29.07.2023.
//

import Foundation

final class ListViewModel {
    weak var view: ListViewInterface?
    
    var rickyMortyCharacters: [Result] = []
    private var isLoading: Bool = false
    private lazy var rickyMortyService: RickyMortyService = RickyMortyService()
    
    private func fetchItems() {
        changeLoading()
        
        rickyMortyService.fetchAllDatas { [weak self] response in
            self?.changeLoading()
            
            self?.rickyMortyCharacters = response?.results ?? []
            
            self?.view?.saveDatas(values: self?.rickyMortyCharacters ?? [])
        }
    }
}

extension ListViewModel: ListViewModelInterface {
    func viewDidLoad() {
        fetchItems()
        view?.prepareListView()
    }
    
    func changeLoading() {
        isLoading = !isLoading
        view?.changeLoading(isLoad: isLoading)
    }
}
