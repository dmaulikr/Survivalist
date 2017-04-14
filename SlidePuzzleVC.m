//
//  SlidePuzzleVC.m
//  Survivalist
//
//  Created by Dylan Jamison on 6/9/16.
//  Copyright © 2016 Dylan Jamison. All rights reserved.
//

#import "SlidePuzzleVC.h"
#import "SlidePiece.h"
#import "ViewController.h"

@interface SlidePuzzleVC ()

@property (strong, nonatomic) IBOutlet UIImageView *s0_0;
@property (strong, nonatomic) IBOutlet UIImageView *s0_1;
@property (strong, nonatomic) IBOutlet UIImageView *s0_2;
@property (strong, nonatomic) IBOutlet UIImageView *s0_3;
@property (strong, nonatomic) IBOutlet UIImageView *s1_0;
@property (strong, nonatomic) IBOutlet UIImageView *s1_1;
@property (strong, nonatomic) IBOutlet UIImageView *s1_2;
@property (strong, nonatomic) IBOutlet UIImageView *s1_3;
@property (strong, nonatomic) IBOutlet UIImageView *s2_0;
@property (strong, nonatomic) IBOutlet UIImageView *s2_1;
@property (strong, nonatomic) IBOutlet UIImageView *s2_2;
@property (strong, nonatomic) IBOutlet UIImageView *s2_3;
@property (strong, nonatomic) IBOutlet UIImageView *s3_0;
@property (strong, nonatomic) IBOutlet UIImageView *s3_1;
@property (strong, nonatomic) IBOutlet UIImageView *s3_2;
@property (strong, nonatomic) IBOutlet UIImageView *s3_3;
@property (strong, nonatomic) IBOutlet UIImageView *second1;
@property (strong, nonatomic) IBOutlet UIImageView *second2;
@property (strong, nonatomic) IBOutlet UIImageView *minute1;
@property (strong, nonatomic) IBOutlet UIImageView *minute2;



@end

@implementation SlidePuzzleVC

NSArray * imageArray;
NSMutableDictionary * pieces;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"Background.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    _s0_0.restorationIdentifier = @"0_0";
    _s0_1.restorationIdentifier = @"0_1";
    _s0_2.restorationIdentifier = @"0_2";
    _s0_3.restorationIdentifier = @"0_3";
    _s1_0.restorationIdentifier = @"1_0";
    _s1_1.restorationIdentifier = @"1_1";
    _s1_2.restorationIdentifier = @"1_2";
    _s1_3.restorationIdentifier = @"1_3";
    _s2_0.restorationIdentifier = @"2_0";
    _s2_1.restorationIdentifier = @"2_1";
    _s2_2.restorationIdentifier = @"2_2";
    _s2_3.restorationIdentifier = @"2_3";
    _s3_0.restorationIdentifier = @"3_0";
    _s3_1.restorationIdentifier = @"3_1";
    _s3_2.restorationIdentifier = @"3_2";
    _s3_3.restorationIdentifier = @"3_3";
    
    imageArray = @[
                   @[_s0_0,_s0_1,_s0_2,_s0_3],
                   @[_s1_0,_s1_1,_s1_2,_s1_3],
                   @[_s2_0,_s2_1,_s2_2,_s2_3],
                   @[_s3_0,_s3_1,_s3_2,_s3_3]
                   ];
    
    UIImage *solution = [UIImage imageNamed:@"SurvivorBali.png"];
    [self setImages:solution];
    
    pieces = [[NSMutableDictionary alloc]initWithCapacity:16];
    
    for(int i = 0; i < 4; i++)
    {
        for(int j = 0; j < 4; j++)
        {
            pieces[[NSString stringWithFormat:@"%ld_%ld",(long)i,(long)j]] = [[SlidePiece new] init];
            SlidePiece * temppiece = pieces[[NSString stringWithFormat:@"%ld_%ld",(long)i,(long)j]];
            temppiece.cx = i;
            temppiece.cy = j;
            temppiece.fx = i;
            temppiece.fy = j;
            UIImageView *tempimage = imageArray[i][j];
            temppiece.img = tempimage.image;
        }
    }
    
    for(int i = 0; i < 1000; i++)
    {
        int direction = arc4random_uniform(4);
        SlidePiece * emptyPiece = pieces[@"3_3"];
        int x = emptyPiece.cx;
        int y = emptyPiece.cy;
        if(direction == 0 && x != 0)
        {
            x--;
        }
        else if(direction == 1 && x != 3)
        {
            x++;
        }
        else if(direction == 2 && y != 0)
        {
            y--;
        }
        else if(direction == 3 && y != 3)
        {
            y++;
        }
        SlidePiece * tappedPiece;
        for(int k = 0; k < 4; k++)
        {
            for(int j = 0; j < 4; j++)
            {
                tappedPiece = pieces[[NSString stringWithFormat:@"%d_%d",k,j]];
                if(tappedPiece.cx == x && tappedPiece.cy == y)
                {
                    k = 4;
                    j = 4;
                }
            }
        }
        
        tappedPiece.cx = emptyPiece.cx;
        tappedPiece.cy = emptyPiece.cy;
        emptyPiece.cx = x;
        emptyPiece.cy = y;
        
        UIImageView * tempImageView = imageArray[tappedPiece.cx][tappedPiece.cy];
        tempImageView.image = tappedPiece.img;
        tempImageView = imageArray[emptyPiece.cx][emptyPiece.cy];
        tempImageView.image = emptyPiece.img;
    }
        [self trackerTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)PieceTapped:(id)sender {
    UITapGestureRecognizer *tapper = (UITapGestureRecognizer *)sender;
    UIImageView *tempImageView = (UIImageView *)tapper.view;
    int tappedx = [[tempImageView.restorationIdentifier substringWithRange:NSMakeRange(0, 1)] intValue];
    int tappedy = [[tempImageView.restorationIdentifier substringWithRange:NSMakeRange(2, 1)] intValue];
    
    SlidePiece * tappedPiece;
    for(int i = 0; i < 4; i++)
    {
        for(int j = 0; j < 4; j++)
        {
            tappedPiece = pieces[[NSString stringWithFormat:@"%d_%d",i,j]];
            if(tappedPiece.cx == tappedx && tappedPiece.cy == tappedy)
            {
                i = 4;
                j = 4;
            }
        }
    }
    SlidePiece * emptyPiece = pieces[@"3_3"];
    
    if(((emptyPiece.cx == tappedPiece.cx) && ((emptyPiece.cy == tappedPiece.cy + 1) || (emptyPiece.cy == tappedPiece.cy - 1))) || ((emptyPiece.cy == tappedPiece.cy) && ((emptyPiece.cx == tappedPiece.cx + 1) || (emptyPiece.cx == tappedPiece.cx - 1))))
    {
        int tempIntx = emptyPiece.cx;
        int tempInty = emptyPiece.cy;
        emptyPiece.cx = tappedPiece.cx;
        emptyPiece.cy = tappedPiece.cy;
        tappedPiece.cx = tempIntx;
        tappedPiece.cy = tempInty;
        
        UIImageView * tempImageView = imageArray[tappedPiece.cx][tappedPiece.cy];
        tempImageView.image = tappedPiece.img;
        tempImageView = imageArray[emptyPiece.cx][emptyPiece.cy];
        tempImageView.image = emptyPiece.img;
    }
    else{
        return;
    }
    
    // Check for puzzle complete at the end
    for(int i = 3; i >= 0; i--)
    {
        for(int j = 3; j >= 0; j--)
        {
            tappedPiece = pieces[[NSString stringWithFormat:@"%d_%d",i,j]];
            if(tappedPiece.cx != tappedPiece.fx || tappedPiece.cy != tappedPiece.fy)
            {
                return;
            }
        }
    }
    NSLog(@"victory!!");
    if(timer)
    {
        [timer invalidate];
        timer = nil;
    }
}

int minutes, seconds, color;


- (void)updateCounter:(NSTimer *)theTimer {
        seconds ++;
        if (seconds % 60 == 0)
        {
            minutes ++;
            seconds = 0;
            _minute2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_%d.png", minutes / 10, color]];
            _minute1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_%d.png", minutes % 10, color]];
        }
    _second2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_%d.png", seconds / 10, color]];
    _second1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_%d.png", seconds % 10, color]];
    NSLog(@"Second.");
}

-(void)trackerTimer {
    color = 1;
    seconds = 0;
    self->timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
}

-(void)setImages:(UIImage *)solution {
    CGRect cropRegion = CGRectMake(0, 0, 249, 249);
    CGImageRef subImage = CGImageCreateWithImageInRect(solution.CGImage, cropRegion);
    _s0_0.image = [UIImage imageWithCGImage:subImage];
    
    cropRegion = CGRectMake(250, 0, 249, 249);
    subImage = CGImageCreateWithImageInRect(solution.CGImage, cropRegion);
    _s0_1.image = [UIImage imageWithCGImage:subImage];
    
    cropRegion = CGRectMake(500, 0, 249, 249);
    subImage = CGImageCreateWithImageInRect(solution.CGImage, cropRegion);
    _s0_2.image = [UIImage imageWithCGImage:subImage];
    
    cropRegion = CGRectMake(750, 0, 249, 249);
    subImage = CGImageCreateWithImageInRect(solution.CGImage, cropRegion);
    _s0_3.image = [UIImage imageWithCGImage:subImage];
    
    cropRegion = CGRectMake(0, 250, 249, 249);
    subImage = CGImageCreateWithImageInRect(solution.CGImage, cropRegion);
    _s1_0.image = [UIImage imageWithCGImage:subImage];
    
    cropRegion = CGRectMake(250, 250, 249, 249);
    subImage = CGImageCreateWithImageInRect(solution.CGImage, cropRegion);
    _s1_1.image = [UIImage imageWithCGImage:subImage];
    
    cropRegion = CGRectMake(500, 250, 249, 249);
    subImage = CGImageCreateWithImageInRect(solution.CGImage, cropRegion);
    _s1_2.image = [UIImage imageWithCGImage:subImage];
    
    cropRegion = CGRectMake(750, 250, 249, 249);
    subImage = CGImageCreateWithImageInRect(solution.CGImage, cropRegion);
    _s1_3.image = [UIImage imageWithCGImage:subImage];
    
    cropRegion = CGRectMake(0, 500, 249, 249);
    subImage = CGImageCreateWithImageInRect(solution.CGImage, cropRegion);
    _s2_0.image = [UIImage imageWithCGImage:subImage];
    
    cropRegion = CGRectMake(250, 500, 249, 249);
    subImage = CGImageCreateWithImageInRect(solution.CGImage, cropRegion);
    _s2_1.image = [UIImage imageWithCGImage:subImage];
    
    cropRegion = CGRectMake(500, 500, 249, 249);
    subImage = CGImageCreateWithImageInRect(solution.CGImage, cropRegion);
    _s2_2.image = [UIImage imageWithCGImage:subImage];
    
    cropRegion = CGRectMake(750, 500, 249, 249);
    subImage = CGImageCreateWithImageInRect(solution.CGImage, cropRegion);
    _s2_3.image = [UIImage imageWithCGImage:subImage];
    
    cropRegion = CGRectMake(0, 750, 249, 249);
    subImage = CGImageCreateWithImageInRect(solution.CGImage, cropRegion);
    _s3_0.image = [UIImage imageWithCGImage:subImage];
    
    cropRegion = CGRectMake(250, 750, 249, 249);
    subImage = CGImageCreateWithImageInRect(solution.CGImage, cropRegion);
    _s3_1.image = [UIImage imageWithCGImage:subImage];
    
    cropRegion = CGRectMake(500, 750, 249, 249);
    subImage = CGImageCreateWithImageInRect(solution.CGImage, cropRegion);
    _s3_2.image = [UIImage imageWithCGImage:subImage];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [timer invalidate];
    timer = nil;
}


@end
