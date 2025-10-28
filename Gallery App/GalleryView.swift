//
//  GalleryView.swift
//  Gallery App
//
//  Created by Sanan Husain on 27/10/25.

import SwiftUI

struct GalleryView: View {
    @StateObject var vm = GalleryViewModel()

    // 5 equal-width columns with fixed spacing
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 5)

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(vm.items) { item in
                        NavigationLink(destination: DetailContainerView(items: vm.items, selected: item)) {
                            GalleryCell(item: item)
                                .frame(width: 70, height: 90) // fixed size for 5 per row
                                .clipped()
                                .cornerRadius(6)
                                .shadow(radius: 1)
                                .onAppear {
                                    Task { await vm.loadNextIfNeeded(currentItem: item) }
                                }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(8)

                if vm.isLoading {
                    ProgressView()
                        .padding()
                }
            }
            .navigationTitle("Image Gallery")
            .task { await vm.loadNextIfNeeded(currentItem: nil) }
            .refreshable { await vm.refresh() }
            .alert(item: Binding(
                get: { vm.errorMessage.map { AlertMessage(message: $0) } },
                set: { _ in vm.errorMessage = nil }
            )) { msg in
                Alert(
                    title: Text("Error"),
                    message: Text(msg.message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
