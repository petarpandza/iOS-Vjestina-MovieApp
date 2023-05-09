import Foundation
import UIKit
import PureLayout
import MovieAppData

class MovieDetailsCrewViewCell: UICollectionViewCell {
    
    private var nameLabel: UILabel!
    private var roleLabel: UILabel!
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        nameLabel.adjustsFontSizeToFitWidth = true
        
        roleLabel = UILabel()
        roleLabel.textColor = .black
        roleLabel.textAlignment = .left
        roleLabel.adjustsFontSizeToFitWidth = true
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(roleLabel)
        
        nameLabel.autoPinEdge(.top, to: .top, of: contentView)
        nameLabel.autoPinEdge(.leading, to: .leading, of: contentView)
        nameLabel.autoPinEdge(.trailing, to: .trailing, of: contentView)
        
        roleLabel.autoPinEdge(.top, to: .bottom, of: nameLabel)
        roleLabel.autoPinEdge(.leading, to: .leading, of: contentView)
        roleLabel.autoPinEdge(.trailing, to: .trailing, of: contentView)


    }
    
    public func setCrew(crewMember: MovieCrewMemberModel) {
        nameLabel.attributedText = NSMutableAttributedString().bold(crewMember.name, fontSize: 18)
        roleLabel.attributedText = NSMutableAttributedString().normal(crewMember.role, fontSize: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
}
