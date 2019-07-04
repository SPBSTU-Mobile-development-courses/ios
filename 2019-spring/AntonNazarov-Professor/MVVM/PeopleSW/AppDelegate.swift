import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // swiftlint:disable:next discouraged_optional_collection
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let peopleListViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        peopleListViewController.viewModel = PeopleListViewModel(pageService: PeopleServiceNetwork())
        
        let navigationController = UINavigationController(rootViewController: peopleListViewController)
        window?.rootViewController = navigationController
        return true
    }
}
