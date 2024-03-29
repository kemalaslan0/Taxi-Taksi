//
//  MapViewActionButton.swift
//  Taksi
//
//  Created by Kemal Aslan on 21.12.2023.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapState: MapViewState
    @Binding var showSideMenu: Bool
    @EnvironmentObject var viewModel: HomeViewModel
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        Button {
            withAnimation(.spring()) {
                actionForState(mapState)
            }
        } label: {
            Image(systemName: imageNameForState(mapState))
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 8)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    func actionForState(_ state: MapViewState){
        switch state {
        case .noInput:
            showSideMenu.toggle()
        case .locationSelected,
                .polylineAdded,
                .tripAccepted,
                .tripRejected,
                .tripRequested,
                .tripCancelledByPassanger,
                .tripCancelledByDriver:
            
            mapState = .noInput
            viewModel.selectedUberLocation = nil
        case .searchingForLocation:
            mapState = .noInput
        }
    }
    
    func imageNameForState(_ state: MapViewState) -> String{
        switch state {
        case .noInput:
            return "line.3.horizontal"
        case .locationSelected,
                .searchingForLocation,
                .polylineAdded,
                .tripAccepted,
                .tripRejected,
                .tripRequested,
                .tripCancelledByDriver,
                .tripCancelledByPassanger:
            return "arrow.left"
        }
    }
}


struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapState: .constant(.noInput), showSideMenu: .constant(false))
    }
}
