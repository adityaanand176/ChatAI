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
                        rowView(title: "Sign Out", imageName: "arrow.left.circle", color: .primary)
                            .foregroundStyle(Color.red)
                    }
                    Button {
                        viewModel.deleteAccount()
                    } label: {
                        rowView(title: "Delete Account", imageName: "x.circle", color: .red)
                            .foregroundStyle(Color.red)
                    }
                }
            }
        }
    }
}

struct rowView : View {
    let title: String
    let imageName: String
    var color: Color? = nil
    var body: some View {
        HStack(){
            Image(systemName: imageName)
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(color ?? .primary)
        }
    }
}

#Preview {
    ProfileView()
}
