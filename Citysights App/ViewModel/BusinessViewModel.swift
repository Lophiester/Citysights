//
//  BusinessModel.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/25.
//

import Foundation

@Observable
class BusinessViewModel{
    
  var businesses = [Business]()
  var text: String = ""
  var selected: Business?
  var service = DataService()
    
  var showAlert = false
  var errorMessage = ""
  var isLoading = false
    
    func getBusinesses(){
        Task{
            do{
                isLoading = true
                businesses = try await service.businessSearch()
                isLoading = false
                
            }
            catch{
                showAlert = true
                errorMessage = error.localizedDescription
            }

        }
    }
 
}
