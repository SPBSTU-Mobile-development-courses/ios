import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else {
            return
        }
        let window = UIWindow(windowScene: scene)
        guard let controller = UIStoryboard(name: "NewsHeadersViewController", bundle: nil)
            .instantiateViewController(identifier: "NewsHeadersViewController") as? NewsHeadersViewController else {
                return
        }
        controller.newsHeaderPresenter = NewsHeaderPresenter(NewsHeaderFacade(NewsHeaderService(), NewsHeaderRepository()))
        window.rootViewController = UINavigationController(rootViewController: controller)
        window.makeKeyAndVisible()
        self.window = window
    }

}
