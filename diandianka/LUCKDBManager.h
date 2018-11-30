//
//  LUCKDBManager.h
//  yezjk
//
//  Created by luck on 2018/6/24.
//  Copyright © 2018年 luck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LUCKDBManager : NSObject
+ (instancetype) sharedInstance;
/**
 插入图片

 @param model
 @return 是否成功
 */
- (BOOL)insertPicModel:(PicModel *)model;

/**
 更新数据 收藏、

 @param model model
 @return 是否成功
 */
- (BOOL)updatePicModel:(PicModel *)model;

/**
 查找图片

 @param Id 图片id
 @return 是否成功
 */
- (PicModel *)lookupPicModel:(NSInteger)number;

/**
 查找图片

 @param type 图片类型
 @return 是否成功
 */
- (NSArray <PicModel *>*)lookupAllPicModelWithType:(NSNumber *)type;

/**
 收藏的图片

 @return   
 */
- (NSArray <PicModel *>*)lookupAllStorePicModel;


@end
