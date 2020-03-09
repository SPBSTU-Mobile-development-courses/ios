/*:
 * implicitly unwrapping !
 * optional binding guard let =
 * optional binding if let =
 * optional chaining ?
 * nil coalescing ??
*/
//enum Optional<Wrapped>


let shortForm1 = Int("42sdfdsf")
let shortForm2 = Int("42")

//print(shortForm1 ?? "s")
//print(shortForm2 ?? "s")

//if let unwrappedForm = shortForm1 {
//    print(unwrappedForm)
//} else {
//    print("shortForm1 is nil")
//}

func aaa() {
    let shortForm1 = Int("42sdfdsf")
    
    guard let unwrappedForm = shortForm1 else {
        print("shortForm1 is nil")
        return
    }
    
    print(unwrappedForm)
}

aaa()

//
//
//
//
//
////
////let number: Int? = Optional.some(42)
////let noNumber: Int?
////print(noNumber == nil)
////// Prints "true"
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//let imagePaths: Dictionary<String, String> = [
//    "star": "/glyphs/star.png",
//    "portrait": "/images/content/portrait.jpg",
//    "spacer": "/images/shared/spacer.gif"
//]
//
//
//func print(string: String?) {
////    if let string = string {
////        print("The star image is at '\(string)'")
////    } else {
////       print("Couldn't find the star image")
////    }
//
//    guard let string = string else {
//        print("Couldn't find the star image")
//        return
//    }
//    print("The star image is at '\(string)'")
//}
//
//
//
//
//
//
//
//
//if imagePaths["star"]?.hasSuffix(".png") == true {
//    print("The star image is in PNG format")
//}
//
//
//
//
//
//
//
//
//
//
//
//
//let defaultImagePath = "/images/default.png"
//let heartPath = imagePaths["heart"] ?? defaultImagePath
//print(heartPath)
//
//
//
//
//
//
//
//
//
//
//
//let isPNG = imagePaths["star"]!.hasSuffix(".png")
//print(isPNG)
