//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    let keyboard: [[String]] = [
        ["ㅂ", "ㅈ", "ㄷ", "ㄱ", "ㅅ", "ㅛ", "ㅕ", "ㅑ", "ㅐ", "ㅔ"],
        ["ㅁ", "ㄴ", "ㅇ", "ㄹ", "ㅎ", "ㅗ", "ㅓ", "ㅏ", "ㅣ"],
        ["↑", "ㅋ", "ㅌ", "ㅊ", "ㅍ", "ㅠ", "ㅜ", "ㅡ", "←"],
        ["숫자", "영어", "스페이스", "엔터"]
    ]
    override func viewDidLoad() {
        let myView = UIView()
        myView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view = myView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),            
            collectionView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .green
        collectionView.alwaysBounceVertical = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(KeyboardCollectionViewCell.self, forCellWithReuseIdentifier: KeyboardCollectionViewCell.identifier)
        return collectionView
    }()
}

extension MyViewController: UICollectionViewDataSource {
    //    섹션에 나타나는 셀개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyboard[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyboardCollectionViewCell.identifier, for: indexPath) as? KeyboardCollectionViewCell else {
            return UICollectionViewCell()
        }
        let text = keyboard[indexPath.section][indexPath.row]
        cell.configure(text: text)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return keyboard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let text = keyboard[indexPath.section][indexPath.row]
        print("키보드입력: \(text)")
    }
}

extension MyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = view.frame.width / 10
        let text = keyboard[indexPath.section][indexPath.row]
        // 스페이스바 크기 설정
        if text == "스페이스" {
            return CGSize(width: (width * 10) - (width * 3), height: 40)
        } else if text == "↑" || text == "←" {
            return CGSize(width: ((width * 10) - (width * 7)) / 2 - 1, height: 40)
        }
        return CGSize(width: width - 1, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // 자판이 9개인경우 좌우여백 설정
        let cellSize = view.frame.width / 10
        var padding: CGFloat = .zero
        if section == 1 {
            padding = (cellSize * 10 - cellSize * 9) / 2
        }
        return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

class KeyboardCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
    }
    
    func setUI() {
        contentView.backgroundColor = .blue
        contentView.addSubview(label)
    }
    
    func configure(text: String) {
        label.text = text
    }
}
