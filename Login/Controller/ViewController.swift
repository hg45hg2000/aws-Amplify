//
//  ViewController.swift
//  Login
//
//  Created by student on 2021/4/26.
//

import UIKit
import Alamofire
import Amplify
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var todoSubscription: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        performOnAppear()
    }

    @IBAction func loginButtonPress(_ sender: UIButton) {
         
        
    }
    
    
    
    func performOnAppear() {
        subscribeTodos()
       let item = Todo(name: "Build iOS Application",
                       description: "Build an iOS application using Amplify")
        Amplify.DataStore.save(item) { result in
           switch(result) {
           case .success(let savedItem):
               print("Saved item: \(savedItem.name)")
           case .failure(let error):
               print("Could not save item to DataStore: \(error)")
           }
        }
    }
    
    func subscribeTodos() {
       self.todoSubscription
           = Amplify.DataStore.publisher(for: Todo.self)
               .sink(receiveCompletion: { completion in
                   print("Subscription has been completed: \(completion)")
               }, receiveValue: { mutationEvent in
                   print("Subscription got this value: \(mutationEvent)")

                   do {
                     let todo = try mutationEvent.decodeModel(as: Todo.self)

                     switch mutationEvent.mutationType {
                     case "create":
                       print("Created: \(todo)")
                     case "update":
                       print("Updated: \(todo)")
                     case "delete":
                       print("Deleted: \(todo)")
                     default:
                       break
                     }

                   } catch {
                     print("Model could not be decoded: \(error)")
                   }
               })
    }
    
}

