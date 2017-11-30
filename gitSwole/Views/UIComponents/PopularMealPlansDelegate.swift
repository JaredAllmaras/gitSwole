//
//  PopularMealPlansDelegate.swift
//  gitSwole
//
//  Created by Nicholas Amaya on 11/30/17.
//  Copyright © 2017 gitSwoleLLC. All rights reserved.
//

import Foundation
import UIKit

class PopularMealPlansDelegate: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var popularMealPlanImages = [UIImage(named: "mealPlan2Icon"), UIImage(named: "mealPlan2Icon"), UIImage(named: "mealPlan2Icon"), UIImage(named: "mealPlan2Icon"), UIImage(named: "mealPlan2Icon")]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMealPlanImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMealPlanCell", for: indexPath) as! PopularMealPlanCollectionViewCell
        
        cell.popularMealPlanImageView.image = popularMealPlanImages[indexPath.row]
        
        return cell
    }
}
