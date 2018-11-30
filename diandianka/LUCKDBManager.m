//
//  LUCKDBManager.m
//  yezjk
//
//  Created by luck on 2018/6/24.
//  Copyright © 2018年 luck. All rights reserved.
//

#import "LUCKDBManager.h"

@interface LUCKDBManager()

@property(nonatomic,strong) JQFMDB *fmdb;

@end

static LUCKDBManager *sharedInstance = nil;

//图片
#define picTableName @"picTable"
//故事
#define storyTableName @"storyTable"

@implementation LUCKDBManager

+ (instancetype) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LUCKDBManager alloc]init];
    });
    return sharedInstance;
}
- (instancetype)init
{
    if (self = [super init]) {
        
        self.fmdb = [JQFMDB shareDatabase];
        [self.fmdb open];
        //图片
        if (![self.fmdb jq_isExistTable:picTableName]) {
            [self.fmdb jq_inDatabase:^{
                [self.fmdb jq_createTable:picTableName dicOrModel:[PicModel class] excludeName:@[@"pointsArray"]];
            }];
        }
        /*
        //故事
        if (![self.fmdb jq_isExistTable:storyTableName]) {
            [self.fmdb jq_inDatabase:^{
                [self.fmdb jq_createTable:storyTableName dicOrModel:[LUCKStoryModel class] excludeName:nil];
            }];
        }
        //收藏表
        if (![self.fmdb jq_isExistTable:storeTableName]) {
            [self.fmdb jq_inDatabase:^{
                [self.fmdb jq_createTable:storeTableName dicOrModel:[JKDSQuestionModel class] excludeName:ignorKeys];
            }];
        }
        //浏览记录
        if (![self.fmdb jq_isExistTable:scanRecordTableName]) {
            [self.fmdb jq_inDatabase:^{
                [self.fmdb jq_createTable:scanRecordTableName dicOrModel:[JKDSCircleModel class] excludeName:nil];
            }];
        }
        */
    }
    return self;
}
- (BOOL)insertPicModel:(PicModel *)model
{
    __block BOOL success = NO;
    
    PicModel *data = [self lookupPicModel:model.number.integerValue];
    if (data) {
        [self.fmdb jq_inDatabase:^{
            success = [self.fmdb jq_updateTable:picTableName dicOrModel:model whereFormat:[NSString stringWithFormat:@"where number = '%d'",model.number.integerValue]];
        }];
    }else{
        [self.fmdb jq_inDatabase:^{
            success = [self.fmdb jq_insertTable:picTableName dicOrModel:model];
        }];
    }
    if (!success) {
        NSLog(@"保存图片失败");
    }
    return success;
}
- (BOOL)updatePicModel:(PicModel *)model{
    
    __block BOOL success = NO;
    [self.fmdb jq_inDatabase:^{
        success = [self.fmdb jq_updateTable:picTableName dicOrModel:model whereFormat:[NSString stringWithFormat:@"where number = '%d'",model.number.intValue]];
    }];
    return success;
}
- (NSArray <PicModel *>*)lookupAllPicModelWithType:(NSNumber *)type
{
    __block NSArray *resultArray = [NSArray array];
    [self.fmdb jq_inDatabase:^{
        NSString *splString = [NSString stringWithFormat:@"where type = '%d'",type.intValue];
        resultArray = [self.fmdb jq_lookupTable:picTableName dicOrModel:[PicModel class] whereFormat:splString];
    }];
    if (resultArray.count) {
        return resultArray;
    }
    return @[];
}

- (PicModel *)lookupPicModel:(NSInteger)number
{
    __block NSArray *resultArray = [NSArray array];
    [self.fmdb jq_inDatabase:^{
        NSString *splString = [NSString stringWithFormat:@"where number = '%d'",number];
        resultArray = [self.fmdb jq_lookupTable:picTableName dicOrModel:[PicModel class] whereFormat:splString];
    }];
    PicModel *message = nil;
    if (resultArray.count > 0) {
        message = resultArray[0];
    }
    return message;
}

@end
