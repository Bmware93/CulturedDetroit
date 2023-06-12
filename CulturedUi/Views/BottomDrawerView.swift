//
//  BottomDrawerView.swift
//  Cultured
//
//  Created by Omar Davidson II on 6/2/23.
//

import SwiftUI

// DrawerView Code Here
struct BottomDrawerView: View {
    @EnvironmentObject var vm: DestinationsViewModel
    @State private var offSet: CGFloat = 0
    @State private var isInitialOffsetSet: Bool = false
    @GestureState private var dragOffset: CGSize = .zero
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                
                // MARK: Blur Effect Here
                BlurView(style: .systemUltraThinMaterial)
                VStack {
                    CapsuleView()
                    // MARK: Actual PickerButton
                    SegmentedPickerView(vm: _vm)
                        
                }
            }
            .offset(y: offSet)
            .animation(.spring(), value: offSet)
            .gesture(
                DragGesture()
                    .onChanged { value in
//                        let startLocation = value.startLocation
//                    offSet = value.translation.height
                        let newOffset = offSet + value.translation.height
                                             offSet = min(max(newOffset, 0), UIScreen.main.bounds.height - 250)
                    }
            )
            .onAppear {
                if !isInitialOffsetSet {
                    offSet = UIScreen.main.bounds.height - 250
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
