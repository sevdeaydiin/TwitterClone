//
//  EditProfileView.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 10.08.2024.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    
    @State var profileImage: Image?
    @State private var selectedImage: UIImage?
    @State var imagePickerPresented = false
    
    @ObservedObject var viewModel: EditProfileViewModel
    @Binding var user: User
    
    @State var name: String
    @State var location: String
    @State var bio: String
    @State var website: String
    
    @Environment(\.dismiss) var dismiss
    
    init(user: Binding<User>) {
        self._user = user
        self.viewModel = EditProfileViewModel(user: self._user.wrappedValue)
        self._name = State(initialValue: self._user.name.wrappedValue)
        self._location = State(initialValue: self._user.location.wrappedValue ?? "")
        self._bio = State(initialValue: self._user.bio.wrappedValue ?? "")
        self._website = State(initialValue: self._user.website.wrappedValue ?? "")
    }
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                         Text("Cancel")
                            .foregroundStyle(.black)
                    }
                    Spacer()
                    Button {
                        self.viewModel.uploadUserData(name: name, bio: bio, website: website, location: location)
                    } label: {
                        Text("Save")
                            .foregroundStyle(.black)
                    }
                }
                .padding()
                
                HStack {
                    Text("Edit Profile")
                        .fontWeight(.heavy)
                }
            }
            
            Image("banner")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: getRect().width, height: 180, alignment: .center)
                .cornerRadius(0)
            
            HStack {
                if profileImage == nil {
                    Button {
                        self.imagePickerPresented.toggle()
                    } label: {
                        KFImage(URL(string: "http://localhost:3000/users/id/avatar"))
                            .resizable()
                            .placeholder {
                                Image("Profile")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                            }
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .padding(8)
                            .background(Color.white)
                            .clipShape(Circle())
                            .offset(y: -20)
                            .padding(.leading, 12)
                    }
                    .sheet(isPresented: $imagePickerPresented) {
                        loadImage()
                    } content: {
                        ImagePicker(image: $selectedImage)
                    }
                }
                
                else if let image = profileImage {
                    VStack {
                        HStack(alignment: .top) {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .padding(8)
                                .background(.white)
                                .clipShape(Circle())
                                .offset(y: -20)
                        }
                        .padding()
                    }
                    .padding(.leading, 12)
                }
                
            }
            .onAppear {
                KingfisherManager.shared.cache.clearCache()
            }
            .padding(.top, -25)
            .padding(.bottom, -10)
            
            VStack {
                Divider()
                HStack {
                    ZStack {
                        HStack {
                            Text("Name")
                                .foregroundStyle(.black)
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        CustomProfileTextField(message: $name, placeholder: "Add your name")
                            .padding(.leading, 90)
                    }
                }
                .padding(.horizontal)
                Divider()
                HStack {
                    ZStack {
                        HStack {
                            Text("Location")
                                .foregroundStyle(.black)
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        CustomProfileTextField(message: $location, placeholder: "Add your location")
                            .padding(.leading, 90)
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                HStack {
                    ZStack(alignment: .topLeading) {
                        HStack {
                            Text("Bio")
                                .foregroundStyle(.black)
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        CustomProfileTextField(message: $bio, placeholder: "Add your bio")
                            .frame(maxHeight: 100, alignment: .top)
                            .padding(.leading, 90)
                            //.padding(.leading, 86)
                            //.padding(.top, 6)
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                HStack {
                    ZStack {
                        HStack {
                            Text("Website")
                                .foregroundStyle(.black)
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        CustomProfileTextField(message: $website, placeholder: "Add your website")
                            .padding(.leading, 90)
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
        }
        .onReceive(viewModel.$uploadComplete) { complete in
            if complete {
                self.dismiss()
                self.user.name = viewModel.user.name
                self.user.website = viewModel.user.website
                self.user.bio = viewModel.user.bio
                self.user.location = viewModel.user.location
                
            }
        }
    }
}

extension EditProfileView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}
