import SwiftUI

class MessageFieldViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var names = []
    @Published var totalLikes = 0
    @Published var replyContent: [Reply] = []
    @Published var isFocused: Bool = false
    @Published var posts: [String: Post] = [:]
    
    init() {
        setupPosts()
    }
    
    func addNewReply(authorName: String) {
        guard !text.isEmpty else { return }
        let postID = UUID().uuidString
        let newPost = Post(content: text, authorName: "You", comments: [], totalLikes: 0)
        posts[postID] = newPost
        text = ""
    }
    
    func setupPosts() {
        for (index, name) in names.enumerated() {
            let postID = UUID().uuidString
            let post = Post(content: "Post \(index + 1)", authorName: name as! String, comments: [], totalLikes: 0)
            posts[postID] = post
        }
    }
}
