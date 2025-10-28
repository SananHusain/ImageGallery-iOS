//
//  DetailContainerView.swift
//  Gallery App
//
//  Created by Sanan Husain on 27/10/25.
//


import SwiftUI

struct DetailContainerView: View {
    @StateObject var vm: DetailViewModel

    init(items: [ImageItem], selected: ImageItem) {
        let index = items.firstIndex(of: selected) ?? 0
        _vm = StateObject(wrappedValue: DetailViewModel(items: items, selectedIndex: index))
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $vm.selectedIndex) {
                ForEach(vm.items.indices, id: \.self) { idx in
                    DetailView(item: vm.items[idx])
                        .tag(idx)
                        .onAppear {
                            Task { await vm.prefetchAround(index: idx) }
                        }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .ignoresSafeArea(edges: .bottom)

            // Bottom details overlay
            VStack {
                Spacer()
                DetailInfoBar(item: vm.items[vm.selectedIndex])
            }
            .padding(.bottom, 30)
            .transition(.move(edge: .bottom).combined(with: .opacity))
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
struct DetailView: View {
    let item: ImageItem

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // 1️⃣ Background color filling the safe area
                Color(.systemBackground) // or any custom color (e.g., .black, .purple, .gray.opacity(0.9))
                    .ignoresSafeArea()

                // 2️⃣ Image content
                AsyncCachedImage(
                    url: URL(string: item.download_url + "?w=1200"),
                    placeholder: ProgressView()
                )
                .scaledToFit()
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
                .transition(.opacity.animation(.easeInOut))
            }
        }
    }
}


struct DetailInfoBar: View {
    let item: ImageItem

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(item.author)
                .font(.headline)
                .foregroundColor(.black)
            Text("Size: \(item.width) x \(item.height)")
                .font(.caption)
                .foregroundColor(.black.opacity(0.8))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .shadow(radius: 3)
        .padding(.horizontal, 12)
    }
}
