import UIKit

class ViewController: UIViewController {
    private var diff: CGFloat = 0
    private var previousOffset: CGFloat = 0
    private var maxOffset: CGFloat = 0
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollDirectionLabel: UILabel!
    @IBOutlet weak var offsetValueLabel: UILabel!
    @IBOutlet weak var maxOffsetValueLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.bounces = false

        scrollView.delegate = self
        scrollDirectionLabel.text = "start"
        offsetValueLabel.text = ""
        maxOffsetValueLabel.text = ""

        // scrollViewのcontentSizeはすぐにとれない
        DispatchQueue.main.async {
            self.maxOffset = self.scrollView.contentSize.height - self.scrollView.bounds.height + self.scrollView.contentInset.bottom
            self.maxOffsetValueLabel.text = "\(self.maxOffset)"
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if previousOffset != scrollView.contentOffset.y {
            offsetValueLabel.text = "\(scrollView.contentOffset.y)"
            let currentDiff = scrollView.contentOffset.y - previousOffset
            if currentDiff + diff > 0 {
                scrollDirectionLabel.text = "up"
            } else {
                scrollDirectionLabel.text = "down"
            }
            if scrollView.contentOffset.y == 0 {
                scrollDirectionLabel.text = "start"
            }
            if scrollView.contentOffset.y == maxOffset {
                scrollDirectionLabel.text = "finish"
            }
            previousOffset = scrollView.contentOffset.y
            diff = currentDiff
        }
    }
}

