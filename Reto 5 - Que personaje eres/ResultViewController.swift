import UIKit

class ResultViewController: UIViewController {
    
    var resultText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: 20, y: 150, width: 350, height: 300))
        label.text = resultText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        
        view.addSubview(label)
    }
}
