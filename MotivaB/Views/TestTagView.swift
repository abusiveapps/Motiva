//
//  TestTagView.swift
//  MotivaB
//
//  Created by   on 11/20/24.
//

import SwiftUI
import SwiftData

struct TestTagView: View {
    @Environment(\.modelContext) var modelContext // add context to TestTagView so that we have access to the model context.
    @State private var selectedTags: [String] = []
    @Query var tags: [Source]

    var body: some View {
        //change layout alignment here if needed.
           // Show tags that were saved to the modelContext.
            List{
                ForEach(tags) { tag in
                    Text(tag.source)
                }
                .navigationTitle("Tags")
                .navigationBarTitleDisplayMode(.inline)
            }
        .scrollClipDisabled(true)
        .scrollIndicators(.hidden)
        .background(.black.opacity(0.05))
        .zIndex(0)
    }
    @ViewBuilder
    func TagView(_ tag: String, _ color: Color, _ icon: String) -> some View {
        //in the for each loop above the tag, color and icon are set, so this tagview can be used for selected and unselected tags.
        HStack(spacing: 10) {
            Text(tag)
                .font(.callout)
                .fontWeight(.semibold)
            
            Image(systemName: icon)
                
        }
        .frame(height: 35)
        .foregroundStyle(.white)
        .padding(.horizontal, 15)
        .background {
            Capsule()
                .fill(color.gradient)
        }
    }
}

#Preview {
    TestTagView()
}
