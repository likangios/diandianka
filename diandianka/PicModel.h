//
//  PicModel.h
//  diandianka
//
//  Created by perfay on 2018/11/28.
//  Copyright © 2018年 luck. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PicModel : NSObject

@property(nonatomic,strong) NSArray *pointsArray;

@property(nonatomic,strong) NSNumber *number;

@end

@interface PointModel : NSObject

@property(nonatomic,strong) NSNumber *number;

@property(nonatomic,strong) NSString *pointString;


@end


