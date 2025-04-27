//
//  ProfileView.swift
//  ChatAI
//
//  Created by Aditya Anand on 03/04/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    var body: some View {
        if let user = viewModel.currentUser{
            List{
                Section("Personal Information"){
                    HStack{
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                        
                        VStack(alignment: .leading, spacing: 4){
                            Text(user.fullname)
                                .font(.headline)
                            Text(user.email)
                                .font(.caption)
                                .foregroundStyle(Color(.blue))
                        }
                    }
                }
                Section("General"){
                    Button {
                        viewModel.signOut()
                    } label: {
                        rowView(title: "Sign Out", imageName: "arrow.left.circle")
                    }
                    Button {
                        viewModel.deleteAccount()
                    } label: {
                        rowView(title: "Delete Account", imageName: "x.circle")
                    }
                }
            }
        }
    }
}

struct rowView : View {
    let title: String
    let imageName: String
    var body: some View {
        HStack(){
            Image(systemName: imageName)
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    ProfileView()
}
