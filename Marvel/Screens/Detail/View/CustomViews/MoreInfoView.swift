//
//  MoreInfo.swift
//  Marvel
//
//  Created by Fatima Garcia on 14/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import UIKit

enum MoreInfoSection {
    case comics([String])
    case series([String])
    case stories([String])
    
    var title: String {
        switch self {
        case .comics:
            return UIConstants.comicsInfoTitle
        case .series:
            return UIConstants.seriesInfoTitle
        case .stories:
            return UIConstants.storiesInfoTitle
        }
    }
    
    var index: Int {
        switch self {
        case .comics:
            return 0
        case .series:
            return 1
        case .stories:
            return 2
        }
    }
}


class MoreInfoView: UIView, NibLoadable {
    //MARK: Properties
    private var collapsableSections: [Bool] = []
    
    private var sections: [MoreInfoSection] = []
    
    //MARK: IBOutlets
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = UIConstants.moreInfoDetailTitle
        }
    }
    
    func configure(comics: [String]?, series: [String]?, stories: [String]?) {
        configureModel(comics: comics, series: series, stories: stories)
        configureStackView()
    }
    
    //MARK: Private methods
    private func configureModel(comics: [String]?, series: [String]?, stories: [String]?){
        sections.removeAll()
        if let comics = comics, comics.count > 0 {
            sections.append(.comics(comics))
        }
        
        if let series = series, series.count > 0 {
            sections.append(.series(series))
        }
        
        if let stories = stories, stories.count > 0 {
            sections.append(.stories(stories))
        }
        titleLabel.isHidden = sections.count == 0
        collapsableSections = Array(repeating: true, count: sections.count)
    }
    
    private func configureStackView() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        sections.forEach { addHeaderAndView(for: $0) }
    }
    
    private func addHeaderAndView(for section: MoreInfoSection) {
        let view: UIView
        var count: Int = 0
        switch section {
        case .comics(let comics):
            view = relatedMaterialView(with: comics)
            count = comics.count
            view.isHidden = collapsableSections[section.index]
        case .series(let series):
            view = relatedMaterialView(with: series)
            count = series.count
            view.isHidden = collapsableSections[section.index]
        case .stories(let stories):
            view = relatedMaterialView(with: stories)
            count = stories.count
            view.isHidden = collapsableSections[section.index]
        }
        
        let header = MoreInfoHeader.instantiate()
        header.configure(title: section.title, info: "\(count)", section: section.index, isCollapsed: collapsableSections[section.index])
        header.delegate = self
        
        stackView.addArrangedSubview(header)
        stackView.addArrangedSubview(view)
    }
    
    private func relatedMaterialView(with names: [String]) -> UIView {
        let view = RelatedMaterialView.instantiate()
        view.configure(with: names)
        return view
    }
    
    private func configureCollapsable() {
        var arrangedSubviews = stackView.arrangedSubviews
        let headers = arrangedSubviews.filter( { $0.isKind(of: MoreInfoHeader.self) })
        arrangedSubviews.removeAll(where: { $0.isKind(of: MoreInfoHeader.self) })
        
        for(index, subview) in arrangedSubviews.enumerated() {
            subview.isHidden = self.collapsableSections[index]
        }
        
        for (index, header) in headers.enumerated() {
            if let header = header as? MoreInfoHeader {
                header.isCollapsed = self.collapsableSections[index]
            }
        }
    }
    
}

//MARK: More Info Header Delegate
extension MoreInfoView: MoreInfoHeaderDelegate {
    func toggleSection(header: MoreInfoHeader, section: Int) {
        collapsableSections = collapsableSections
            .enumerated()
            .map { (index, collapsed) in
                index == section ? !collapsed : true
        }
        configureCollapsable()
    }
}

