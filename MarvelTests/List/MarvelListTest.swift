//
//  MarvelListTest.swift
//  MarvelTests
//
//  Created by Fatima Garcia on 15/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import XCTest
@testable import Marvel

class MarvelListTest: XCTestCase {
    
    //MARK: Properties
    private var characters: CharacterWrapper? = nil
    private var charactersUI: [CharacterUIModel]? = nil
    
    private var presenter: MarvelListPresenter!
    
    //MARK: Mock view
    private var view =  MarvelListViewControllerMocked()
    
    private class MarvelListViewControllerMocked: MarvelListViewControllerProtocol {
        var loading = false
        var error = false
        var isReloadCalled = false
        
        func reloadData() {
            isReloadCalled = true
        }
        
        func isLoading(_ loading: Bool) {
            self.loading = loading
        }
        
        func isError(_ error: Bool) {
            self.error = error
        }
    }
    
    //MARK: Setup
    override func setUp() {
        let bundle = Bundle.init(for: type(of: self))
        loadJsonFile(bundle: bundle, "MarvelList") { [weak self] (model: CharacterWrapper) in
            self?.characters = model
        }
        presenter = MarvelListPresenter(view: view)
    }
    
    //MARK: Tests
    func testCreateUIModel() {
        XCTAssertNil(charactersUI)
        charactersUI = characters?.generateCharacterUIModel()
        XCTAssertNotNil(charactersUI)
        let previousCount = charactersUI?.count
        let newCharacter = CharacterUIModel(id: 1010699, image: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg", name: "Aaron Stack", description: nil)
        charactersUI?.append(newCharacter)
        XCTAssertNotEqual(charactersUI?.count, previousCount)
    }
    
    func testDecodingCorrectWithMissingFields() {
        var charactersMissingFields: CharacterWrapper?
        let bundle = Bundle.init(for: type(of: self))
        loadJsonFile(bundle: bundle, "MarvelListWithMissingFields") { (model: CharacterWrapper) in
            charactersMissingFields = model
        }
        XCTAssertNotNil(charactersMissingFields)
        let characterUIExample = charactersMissingFields?.generateCharacterUIModel().first
        XCTAssertNotNil(characterUIExample?.name)
        XCTAssertNil(characterUIExample?.description)
    }
    
    func testInstantiateMarvelListPresenter() {
        XCTAssertNotNil(presenter)
    }
    
    func testRequestList() {
        view.isLoading(true)
        XCTAssertTrue(view.loading)
        let list = ListRequest()
        let expectation = XCTestExpectation(description: "Get Marvel Characters")
        list.performRequest { [weak self] result in
            XCTAssertNotNil(result)
            switch result {
            case .success(let model):
                XCTAssertEqual(model.code, 200)
                XCTAssertTrue(model.data?.count ?? 0 > 0)
                self?.view.reloadData()
                if let isReload = self?.view.isReloadCalled {
                    XCTAssertTrue(isReload)
                }
            case .failure(let error):
                XCTAssertNotEqual(error.httpStatus, 200)
                self?.view.isError(true)
                if let isError = self?.view.error {
                    XCTAssertTrue(isError)
                }
            }
            expectation.fulfill()
        }
        view.isLoading(false)
        XCTAssertFalse(view.loading)
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    //MARK: Read JSON
    func loadJsonFile<T: Decodable>(bundle: Bundle, _ fileName: String, completion: @escaping (T) -> ()) {
        if let url = bundle.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(model)
            } catch {
                print("Failed to decode")
            }
        }
    }
}
