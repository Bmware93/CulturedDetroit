//
//  BottomDrawerView.swift
//  Cultured
//
//  Created by Omar Davidson II on 6/2/23.
//

import SwiftUI

struct BottomDrawerView: View {
    @EnvironmentObject var vm: DestinationsViewModel
    @State private var offSet: CGFloat = 0
    @State private var isInitialOffsetSet: Bool = false
    @GestureState private var dragOffset: CGSize = .zero
    
    let drawerHeights: [CGFloat] = [200, 300, 400]
    let initialHeight: CGFloat = 490
    let minHeight: CGFloat = 150
    let maxHeight: CGFloat = 818
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                BlurView(style: .systemUltraThinMaterial)
                VStack {
                    CapsuleView()

                    // MARK: Actual PickerButton
                    SegmentedPickerView(vm: _vm) {
                        offSet = UIScreen.main.bounds.height - minHeight
                    }
                        


                }
            }
            .offset(y: offSet)
            .animation(.spring(), value: offSet)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let newOffset = offSet + value.translation.height
                        // Limit the offset to the height range of the drawer
                        offSet = min(max(newOffset, UIScreen.main.bounds.height - maxHeight), UIScreen.main.bounds.height - minHeight)
                    }
            )
            .onAppear {
                if !isInitialOffsetSet {
                    offSet = UIScreen.main.bounds.height - initialHeight
                    isInitialOffsetSet = true
                }
            }
        }
    }
}

struct BottomDrawerView_Previews: PreviewProvider {
    static var previews: some View {
        BottomDrawerView()
            .environmentObject(DestinationsViewModel())
    }
}

// BottomDrawerCapsuleView

struct CapsuleView: View {
    var body: some View {
        VStack {
            Capsule()
                .frame(width: 71, height: 8)
                .foregroundColor(.gray)
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
