//
//  Singleton.h
//  TextPromgrame
//
//  Created by 贺赟生 on 15/12/2.
//  Copyright © 2015年 贺赟生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject
@property(nonatomic,strong)NSString* textStr;
+(Singleton*)shareSingle;
@end
