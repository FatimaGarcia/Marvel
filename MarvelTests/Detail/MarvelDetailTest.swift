//
//  MarvelDetailTest.swift
//  MarvelTests
//
//  Created by Fatima Garcia on 15/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import XCTest
@testable import Marvel

class MarvelDetailTest: XCTestCase {
    //MARK: Tests
    func testViewInstantiate(){
        let vc = MarvelDetailViewController.instantiate()
        XCTAssertNotNil(vc)
        
        let moreInfoView = MoreInfoView.instantiate()
        XCTAssertNotNil(moreInfoView)
    }
    
    func testInstantiateErrorView() {
        let errorView = ErrorView.init()
        XCTAssertNotNil(errorView)
    }
    
    func testGenerateUIDetailCharaceter() {
        let character = CharacterUIModel(id: 1011334, image: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg", name: "3-D Man", description: "")
        let detail = CharacterDetailUIModel(basicInfo: character,
                                            comicsName: ["Avengers: The Initiative (2007) #14", "Avengers: The Initiative (2007) #18"],
                                            seriesName: ["Avengers: The Initiative (2007 - 2010)", "Deadpool (1997 - 2002)"],
                                            storiesName: ["Cover #19947", "AVENGERS: THE INITIATIVE (2007) #14"])
        XCTAssertNotNil(detail)
    }
    
    func testGenerateMoreInfoView() {
        let character = CharacterUIModel(id: 1011334, image: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg", name: "3-D Man", description: "")
        let detail = CharacterDetailUIModel(basicInfo: character,
                                            comicsName: ["Avengers: The Initiative (2007) #14", "Avengers: The Initiative (2007) #18"],
                                            seriesName: ["Avengers: The Initiative (2007 - 2010)", "Deadpool (1997 - 2002)"],
                                            storiesName: ["Cover #19947", "AVENGERS: THE INITIATIVE (2007) #14"])
        
        let vc = MarvelDetailViewController.instantiate()
        let presenter = MarvelDetailPresenter(view: vc, characterId: 1011334)
        vc.configure(presenter: presenter)
        vc.viewDidLoad()
        vc.loadData(detail)
        XCTAssertNotNil(vc.name.text)
        
        let subviews = vc.stackView.arrangedSubviews.count
        XCTAssertEqual(subviews, 3)
        
        let moreInfoView = vc.stackView.arrangedSubviews.filter { $0 is MoreInfoView }.first as? MoreInfoView
        
        let headers = moreInfoView?.stackView.arrangedSubviews.filter{ $0 is MoreInfoHeader }
        XCTAssertEqual(headers?.count ?? 0, 3)
        
        let sections = moreInfoView?.stackView.arrangedSubviews.filter{ $0 is RelatedMaterialView }
        XCTAssertEqual(sections?.count ?? 0, 3)
    }
    
    
    func testGenerateMoreInfoViewWithoutASection() {
        let character = CharacterUIModel(id: 1011334, image: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg", name: "3-D Man", description: "")
        let detail = CharacterDetailUIModel(basicInfo: character,
                                            comicsName: ["Avengers: The Initiative (2007) #14", "Avengers: The Initiative (2007) #18"],
                                            seriesName: ["Avengers: The Initiative (2007 - 2010)", "Deadpool (1997 - 2002)"],
                                            storiesName: nil)
        
        let vc = MarvelDetailViewController.instantiate()
        let presenter = MarvelDetailPresenter(view: vc, characterId: 1011334)
        vc.configure(presenter: presenter)
        vc.viewDidLoad()
        vc.loadData(detail)
        XCTAssertNotNil(vc.name.text)
        
        let moreInfoView = vc.stackView.arrangedSubviews.filter { $0 is MoreInfoView }.first as? MoreInfoView
        
        let headers = moreInfoView?.stackView.arrangedSubviews.filter{ $0 is MoreInfoHeader }
        XCTAssertEqual(headers?.count ?? 0, 2)
        
        let sections = moreInfoView?.stackView.arrangedSubviews.filter{ $0 is RelatedMaterialView }
        XCTAssertEqual(sections?.count ?? 0, 2)
    }
    
    func testLoadingView() {
        let vc = MarvelDetailViewController.instantiate()
        
    }
}
