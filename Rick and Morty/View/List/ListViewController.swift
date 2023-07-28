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
    private let box: UIView = UIView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

//MARK: - Configure UI
extension ListViewController {
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(labelTitle)
        view.addSubview(box)
        view.addSubview(indicator)
        
        drawDesign()
        
        makeLabelTitle()
        makeBox()
        makeIndicator()
    }
    
    private func drawDesign() {
        DispatchQueue.main.async {
            self.labelTitle.text = "mehmettalhairmak"
            
            self.box.backgroundColor = .systemRed
            
            self.indicator.color = .systemRed
        }
        indicator.startAnimating()
    }
    
    private func makeLabelTitle() {
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
    }
    
    private func makeBox() {
        box.snp.makeConstraints { make in
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

