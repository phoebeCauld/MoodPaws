import UIKit

final class NoteViewController: UIViewController {
    private let componentsFactory: IComponentsFactory
    
    init(componentsFactory: IComponentsFactory) {
        self.componentsFactory = componentsFactory
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
