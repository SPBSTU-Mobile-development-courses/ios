import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CharacterViewController") as? CharacterViewController else { return false }
        controller.characterFacade = CharacterFacadeImpl(characterService: CharacterServiceImpl(), characterRepository: CharacterRepositoryImpl(configuration: .defaultConfiguration)
        )
        window.rootViewController = UINavigationController(rootViewController: controller)
        window.makeKeyAndVisible()
        self.window = window
        return true;
    }
}
