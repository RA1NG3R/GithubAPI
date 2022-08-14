//
//  OwnerViewModel.swift
//  GithubAPI
//
//  Created by Subodh Mahajan on 14/08/22.
//

import Foundation

class OwnerViewModel {
    
    private var service = Service()
    private var owner = [Owner]()
    
    func fetchOwnerData(completion: @escaping () -> ()) {
        
        // weak self - prevent retain cycles
        service.getOwnerData { [weak self] (result) in
            
            switch result {
            case .success(let owner):
                self?.owner = owner
                completion()
            case .failure(let error):
                // Something is wrong with the JSON file or the model
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if owner.count != 0 {
            return owner.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Owner {
        return owner[indexPath.row]
    }
}
