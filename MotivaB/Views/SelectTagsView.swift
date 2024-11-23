//
//  ContentView.swift
//  MotivaB
//
//  Created by  on 11/7/24.
//

import SwiftUI
import SwiftData

struct SelectTagsView: View {
    @Environment(\.modelContext) var modelContext // add context to TestTagView so that we have access to the model context.
    @Query var savedTags: [Source]
    //@Query var allTags: [Source]
    //View Properties
    //Sample Tags
    @State private var tags: [String] = [
        "Star Wars",
        "Star Trek",
        "Marvel Cinematic Universe (MCU)",
        "DC Universe",
        "Doctor Who",
        "The Lord of the Rings Universe",
        "Harry Potter",
        "Game of Thrones",
        "The Matrix",
        "Dune",
        "Firefly",
        "Battlestar Galactica",
        "The Expanse",
        "Rick and Morty",
        "Stranger Things",
        "The Witcher",
        "Avatar: The Last Airbender",
        "Blade Runner",
        "Neon Genesis Evangelion",
        "Gundam Universe"
    ] // get these tags to load into persistant storage, so they can be read out.
    @State private var selectedTags: [String] = []
    @State private var selection: String? = nil
    // Adding Matched Geometry Effect
    @Namespace private var animation
    var body: some View {
        NavigationView {
//MARK: Selected tag view
            VStack(spacing: 0) {
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(savedTags, id: \.self) { tag in
                            TagView(tag.source, .indigo, "checkmark")
                                .matchedGeometryEffect(id: tag, in: animation)
                            //removing from selected list
                                .onTapGesture {
                                    // let remove = Source(source: tag, genre: "", quality: "", author: "")
                                    //   modelContext.delete(remove)
                                    withAnimation(.snappy) {
                                        selectedTags.removeAll(where: { $0 == tag.source})
                                        modelContext.delete(tag)
                                    }
                                }
                        }
                    }
                    .padding(.horizontal, 15)
                    .frame(height: 35)
                    .padding(.vertical, 15)
                }
                .scrollClipDisabled(true)
                .scrollIndicators(.hidden)
                .overlay(content: {
                    if savedTags.count < 3{
                        Text("Select 3 or more tags")
                            .font(.callout)
                            .foregroundStyle(.gray)
                    }
                })
                .background(.white)
                .zIndex(1)
// MARK: Unselected tags view
                //View containing all the buttons from our source list.
                ScrollView(.vertical) {
                    //change layout alignment here if needed.
                    TagLayout(alignment: .center, spacing: 10) {
                        //need the tag list to be loaded by sources, prestored in swiftdata.
                        ForEach(tags.filter { !selectedTags.contains($0) }, id: \.self) { tag in
                            TagView(tag, .black, "plus")
                                .matchedGeometryEffect(id: tag, in: animation)
                                .onTapGesture {
                                    let add = Source(source: tag, genre: "", quality: "", author: "")
                                    //adding to selected tag list
                                    withAnimation(.snappy) {
                                        selectedTags.insert(tag, at: 0)
                                        modelContext.insert(add)
                                    }
                                }
                        }
                    }
                    .padding(10)
                }
                .scrollClipDisabled(true)
                .scrollIndicators(.hidden)
                .background(.black.opacity(0.05))
                .zIndex(0)
                //button to continue and add selected buttons to modelcontex.
                NavigationLink(destination: TestTagView(), tag: "Selected", selection: $selection){ EmptyView() }
                ZStack {
                    Button(action: {
                        self.selection = "Selected"
                    }, label: {
                        Text("Continue")
                            .fontWeight(.semibold)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .background{
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.indigo.gradient)
                            }
                    })
                    //Disabling button until 3 or more tags are selected.
                    .disabled(savedTags.count < 3)
                    .opacity(savedTags.count >= 3 ? 1 : 0.3)
                    .padding()
                }
                .background(.white)
                .zIndex(2)
            }
        }
        .preferredColorScheme(.light)
    }
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


#Preview {
    SelectTagsView()
}
