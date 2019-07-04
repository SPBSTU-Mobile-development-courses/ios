import UIKit

class DetailViewController: UIViewController {
    @IBOutlet private var labelPersonName: UILabel!
    @IBOutlet private var labelPersonGender: UILabel!
    @IBOutlet private var labelPersonHeight: UILabel!
    @IBOutlet private var labelPersonMass: UILabel!
    @IBOutlet private var labelPersonBirthYear: UILabel!
    @IBOutlet private var labelPersonHairColor: UILabel!
    @IBOutlet private var labelPersonSkinColor: UILabel!

    var person: Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        labelPersonName.text = person?.name
        labelPersonGender.text = person?.gender
        labelPersonHeight.text = person?.height
        labelPersonMass.text = person?.mass
        labelPersonBirthYear.text = person?.birthYear
        labelPersonHairColor.text = person?.hairColor
        labelPersonSkinColor.text = person?.skinColor
    }
}
