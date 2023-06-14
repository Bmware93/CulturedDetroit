//
//  BottomDrawerView.swift
//  Cultured
//
//  Created by Omar Davidson II on 6/2/23.
//

import SwiftUI

struct BottomDrawerView: View {
    @ObservedObject var vm: DestinationsViewModel
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                BlurView(style: .systemUltraThinMaterial)
                VStack {
                    CapsuleView()
                    SegmentedPickerView(vm: DestinationsViewModel())
                        .environmentObject(DestinationsViewModel())
                }
            }
            .offset(y: vm.offSet)
            .animation(.spring(), value: vm.offSet)
            .onAppear {
                        // Slide up the drawer when the view appears
                        withAnimation {
                            vm.drawerOffset = 0
                        }
                    }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let newOffset = vm.offSet + value.translation.height
                        // Limit the offset to the height range of the drawer
                        vm.offSet = min(max(newOffset, UIScreen.main.bounds.height - vm.maxHeight), UIScreen.main.bounds.height - vm.minHeight)
                    }
                    .onEnded { value in
                            // Close the drawer if drag distance is less than 100
                            if value.translation.height < 100 {
                                withAnimation {
                                    vm.drawerOffset = 0
                                }
                            } else {
                                // Open the drawer if drag distance is more than 100
                                withAnimation {
                                    vm.drawerOffset = UIScreen.main.bounds.height - 100
                                }
                            }
                        }
            )
            .onAppear {
                if !vm.isInitialOffsetSet {
                    vm.offSet = UIScreen.main.bounds.height - vm.initialHeight
                    vm.isInitialOffsetSet = true
                }
            }
        }
    }
}

struct BottomDrawerView_Previews: PreviewProvider {
    static var previews: some View {
        BottomDrawerView(vm: DestinationsViewModel())
    }
}

// BottomDrawerCapsuleView

struct CapsuleView: View {
    var body: some View {
        VStack {
            Capsule()
                .frame(width: 71, height: 8)
                .foregroundColor(.white)
                .padding(9)
        }
    }
}

// Blurred View Here
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))

        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        // do nothing
    }
}
