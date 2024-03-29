//
//  LocationSearchView.swift
//  Taksi
//
//  Created by Kemal Aslan on 21.12.2023.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var startLocation = ""
    @EnvironmentObject var viewModel : HomeViewModel
    
    
    var body: some View {
        
        VStack {
            //            Header view
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 6, height: 6)
                    
                }
                
                
                VStack {
                    TextField("Current location", text: $startLocation)
                        .frame(height: 32)
                        .disabled(true)
                        .padding(.leading)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                    
                    
                    TextField("Where to?", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .padding(.leading)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                    
                }
            }
            .padding(.horizontal)
            .padding(.top,64)
            
            Divider()
                .padding(.vertical)
            
            //            list view
            LocationSearchResultView(viewModel: viewModel, config: .ride )
            
        }
        .background(Color.theme.backgroundColor)
    }
}

struct LocationSearchVI_ew_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}
