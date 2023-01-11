//
//  Obs.swift
//  oct
//
//  Created by Francisco Perez on 01/01/23.
//

import SwiftUI

// when identifiable whe can use a UUID()
struct FruitModel: Identifiable {
    
    let id: String = UUID().uuidString
    let name: String
    let count: Int
}

class FruitViewModel: ObservableObject {
    
    
   @Published var fruitArray : [FruitModel] = []
   @Published var isLoading: Bool = false
    
    init(){
        getFruits()
    }
    
    func getFruits(){
        
        //async await
        let fruits1 = FruitModel(name:"oranges",count:6)
        let fruits2 = FruitModel(name:"watermaleon",count:1)
        let fruits3 = FruitModel(name:"lemons",count:9)
        let fruits4 = FruitModel(name:"Cereal",count:1)
        let fruits5 = FruitModel(name:"Biscuits",count:15)
        
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.fruitArray.append(fruits1)
            self.fruitArray.append(fruits2)
            self.fruitArray.append(fruits3)
            self.fruitArray.append(fruits4)
            self.fruitArray.append(fruits5)
            
            self.isLoading = false
        }
        
    }
    
    func deleteFruit(index: IndexSet){
        fruitArray.remove(atOffsets: index)
    }
}

struct Obs: View {
    /*@State var fruitArray: [FruitModel] = [
        FruitModel(name: "Apples", count:5)
    ]*/
    
    //@ObservedObject var fruitViewModel: FruitViewModel = FruitViewModel()
    // @StateObject -> use this on creation / init
    // @ObservedObject -> use this for subviews
    
    @StateObject var fruitViewModel: FruitViewModel = FruitViewModel()
    
    var body: some View {
        NavigationView {
            List{
                
                if fruitViewModel.isLoading{
                    ProgressView()
                }
                
                ForEach(fruitViewModel.fruitArray) { fruit in
                    HStack
                    {
                        Text("\(fruit.count)")
                            .foregroundColor(.red)
                        Text(fruit.name)
                            .font(.headline)
                            .bold()
                    }//endZstack
                }// end foreach
                .onDelete(perform: fruitViewModel.deleteFruit)
            }
            .navigationTitle("Shopping List")
            .listStyle(GroupedListStyle())
            .navigationBarItems(trailing: NavigationLink(destination: RandomScreen(), label: {
                Image(systemName: "arrow.right")
                    .font(.title)
            }))
        }
        
        
       
        /*.onAppear{
            fruitViewModel.getFruits()
            //getFruits()
        }
         */
         
        
    }
    
    
    
    
}//end view
struct RandomScreen: View{
    
    @Environment(\.presentationMode) var presentationMode
   
    var body: some View{

        ZStack {
            Color.green.ignoresSafeArea()
            Button {
                presentationMode.wrappedValue.dismiss()
                
            } label: {
                Text("Go back")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }

        }
    }
}


struct Obs_Previews: PreviewProvider {
    static var previews: some View {
        Obs()
        //RandomScreen()
    }
}
