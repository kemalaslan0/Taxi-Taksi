//
//  HomeView.swift
//  Taksi
//
//  Created by Kemal Aslan on 7.12.2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState = MapViewState.noInput
    @State private var showSideMenu = false
    @EnvironmentObject var authViewModel : AuthViewModel
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        Group {
            
            if authViewModel.userSession == nil {
                LoginView()
            }else if let currentUser = authViewModel.currentUser {
                
                NavigationStack {
                    ZStack {
                        if showSideMenu {
                            SideMenuView(user: currentUser)
                        }
                        mapView
                            .offset(x: showSideMenu ? 316 : 0)
                            .shadow(color: showSideMenu ? .black : .clear,
                                    radius: 10)
                    }
                    .onAppear {
                        showSideMenu = false
                        
                    }
                }
                
               
            }

        }
    }
}

extension HomeView{
    var mapView: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                TaksiMapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                
                if mapState == .searchingForLocation{
                    LocationSearchView()
                }else if mapState == .noInput {
                    LocationSearchActivationView()
                        .padding(.vertical, 72)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                mapState = .searchingForLocation

                            }
                        }
                }
                
                MapViewActionButton(mapState: $mapState,showSideMenu: $showSideMenu)
                    .padding(.leading)
                    .padding(.top,4)
            }
            
            if let user = authViewModel.currentUser {
                homeViewModel.viewForState(mapState, user: user)
                    .transition(.move(edge: .bottom))
            }

        }
        .edgesIgnoringSafeArea(.bottom)
            .onReceive(LocationManager.shared.$userLocation) { location in
                if let location = location {
                    homeViewModel.userLocation = location
                }
        }
            .onReceive(homeViewModel.$selectedUberLocation) { location in
                if location != nil {
                    self.mapState = .locationSelected
                }
            }
            .onReceive(homeViewModel.$trip) { trip in
                guard let trip else {
                    self.mapState = .noInput
                    return
                }
                
                withAnimation(.spring()){
                    switch trip.state {
                    case .accepted:
                        self.mapState = .tripAccepted
                    case .rejected:
                        self.mapState = .tripRejected
                    case .requested:
                        self.mapState = .tripRequested
                    case .passangerCancelled:
                        self.mapState = .tripCancelledByPassanger
                    case .driverCancelled:
                        self.mapState = .tripCancelledByDriver
                    }
                }
            }
    }

}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthViewModel())
    }
}
