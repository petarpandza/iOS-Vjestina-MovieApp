import Foundation
import UIKit

class MovieDetailsDataSource: NSObject, UICollectionViewDataSource {
    
    private var crew: [MovieCrewMember]
    
    init(crew: [MovieCrewMember]) {
        self.crew = crew
    }
    
    func updateData(crew: [MovieCrewMember]) {
        self.crew = crew
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crewCell", for: indexPath) as? MovieDetailsCrewViewCell else {
            fatalError("Unable to dequeue crew cell")
        }

        guard !crew.isEmpty else {
            return cell
        }
        
        let crewMember = crew[indexPath.row]
        
        cell.setCrew(crewMember: crewMember)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return crew.count
    }
}
