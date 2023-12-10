//
//  CustomCulturedPin.swift
//  CulturedUi
//
//  Created by Benia Morgan-Ware on 6/16/23.
//

import SwiftUI

struct CustomCulturedPin: View {
    var body: some View {
        VStack {
            Image("customPin")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 100)
        }
    }
}

struct CustomCulturedPin_Previews: PreviewProvider {
    static var previews: some View {
        CustomCulturedPin()
    }
}
