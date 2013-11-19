//
//  ViewController.h
//  dbTest
//
//  Created by Lsr on 11/19/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "DBUtil.h"

@interface ViewController : UIViewController{
    
    sqlite3* db;
    
}


@end
