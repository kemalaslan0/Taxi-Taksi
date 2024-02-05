//
//  LocationSearchResultView.swift
//  Taksi
//
//  Created by Kemal Aslan on 15.01.2024.
//

import SwiftUI

struct LocationSearchResultView: View {
    @StateObject var viewModel: HomeViewModel
    let config: LocationResultsViewConfig
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.results, id : \.self) { result in
                    LocationSearchResultCell(title: result.title, subTitle: result.subtitle)
                        .onTapGesture {
                            withAnimation(.spring()){
                                viewModel.selectLocation(result, config: config)
                            }
                        }
                }
            }
        }
    }
}
