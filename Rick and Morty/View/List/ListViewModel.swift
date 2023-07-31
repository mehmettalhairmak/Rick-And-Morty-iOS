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
    
    private func fetchItemsAndPerformTask() async {
        changeLoading()
        do {
            rickyMortyCharacters = try await rickyMortyService.fetchAllDatas() ?? []
        } catch {
            print("error confirmed, \(error)")
        }
        view?.reloadTableView()
        changeLoading()
    }
}

extension ListViewModel: ListViewModelInterface {
    func viewDidLoad() {
        Task {
            await fetchItemsAndPerformTask()
        }
        view?.prepareListView()
    }
    
    func changeLoading() {
        isLoading = !isLoading
        view?.changeLoading(isLoad: isLoading)
    }
}
