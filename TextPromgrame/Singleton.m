//
//  Singleton.m
//  TextPromgrame
//
//  Created by 贺赟生 on 15/12/2.
//  Copyright © 2015年 贺赟生. All rights reserved.
//

#import "Singleton.h"
static Singleton* shareSingle;
@implementation Singleton

+(Singleton*)shareSingle{
    
    static dispatch_once_t one_token;
        
        dispatch_once(&one_token, ^{
            
            shareSingle = [[Singleton alloc] init];
            
        });
    
    return shareSingle;
}
@end
