//
//  ViewController.h
//  sampleBmi
//
//  Created by Yokoe on 10/16/15.
//  Copyright © 2015 HANAUTA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UITextField *heightTextField ;
    IBOutlet UITextField *weightTextField ;
    IBOutlet UIButton    *startComputeButton ;
    IBOutlet UILabel *bmiTextLabel ;
    IBOutlet UILabel *resultValueLabel ;
    IBOutlet UILabel *resultTextLabel ;
}
@end
