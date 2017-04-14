//
//  SlidePuzzleVC.h
//  Survivalist
//
//  Created by Dylan Jamison on 6/9/16.
//  Copyright © 2016 Dylan Jamison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlidePuzzleVC : UIViewController
{
    NSTimer *timer;
}

-(void)updateCounter:(NSTimer *)theTimer;
-(void)trackerTimer;

@end
