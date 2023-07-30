//
//  RickyMortyCell.swift
//  Rick and Morty
//
//  Created by Mehmet Talha Irmak on 30.07.2023.
//

import UIKit
import Kingfisher

final class RickyMortyCell: UITableViewCell {
    
    private let customImage: UIImageView = UIImageView()
    private let title: UILabel = UILabel()
    private let customDescription: UILabel = UILabel()
    private let characterStatusIcon: UIView = UIView()
    private let characterStatusLabel: UILabel = UILabel()
    
    enum Identifier: String {
        case custom = "mehmettalhairmak"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier )
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(customImage)
        addSubview(title)
        addSubview(customDescription)
        addSubview(characterStatusIcon)
        addSubview(characterStatusLabel)
        
        makeCustomImage()
        makeTitle()
        makeCustomDescription()
        makeCharacterStatusIcon()
        makeCharacterStatusLabel()
    }
}

//MARK: - Make UI Methods
extension RickyMortyCell {
    private func makeCustomImage() {
        customImage.snp.makeConstraints { make in
            make.height.equalTo(contentView).dividedBy(1.2)
            make.width.equalTo(contentView).dividedBy(3)
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(contentView).offset(10)
        }
    }
    
    private func makeTitle() {
        title.font = .boldSystemFont(ofSize: 16)
        title.numberOfLines = 0
        
        title.snp.makeConstraints { make in
            make.top.equalTo(customImage.snp.top)
            make.centerY.equalTo(contentView)
            make.left.equalTo(customImage.snp.right).offset(20)
        }
    }
    
    private func makeCustomDescription() {
        customDescription.font = .italicSystemFont(ofSize: 12)
        
        customDescription.snp.makeConstraints { make in
            make.top.equalTo(title).offset(25)
            make.right.left.equalTo(title)
            make.bottom.equalToSuperview()
        }
    }
    
    private func makeCharacterStatusIcon() {
        characterStatusIcon.layer.cornerRadius = 10
        
        characterStatusIcon.snp.makeConstraints { make in
            make.centerY.equalTo(title).offset(-25)
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.left.equalTo(title)
            
        }
    }
    
    private func makeCharacterStatusLabel() {
        characterStatusLabel.font = .italicSystemFont(ofSize: 14)
        
        characterStatusLabel.snp.makeConstraints { make in
            make.centerY.equalTo(characterStatusIcon)
            make.left.equalTo(characterStatusIcon.snp.right).offset(10)
        }
    }
}

//MARK: - UI Manupilation Methods
extension RickyMortyCell {
    func saveModel(result: Result) {
        title.text = result.name
        customDescription.text = result.type
        
        if result.status == Status.alive {
            characterStatusIcon.backgroundColor = .systemGreen
        } else if result.status == Status.dead {
            characterStatusIcon.backgroundColor = .red
        } else {
            characterStatusIcon.backgroundColor = .black
        }
        
        characterStatusLabel.text = result.status.rawValue
        
        let customImageURL: URL = URL(string: result.image) ?? URL(string: "")!
        customImage.kf.setImage(with: customImageURL)
    }
}
