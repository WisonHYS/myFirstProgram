//
//  ViewController.m
//  TextPromgrame
//
//  Created by 贺赟生 on 15/11/30.
//  Copyright © 2015年 贺赟生. All rights reserved.
//

#import "ViewController.h"
#import <FMDatabase.h>
#import "Singleton.h"
#import "Masonry.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong) FMDatabase *db ;
@end
static NSString * const kcellIdentifier = @"collectionCell";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self textFMDB];
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    UICollectionView* colletctView= [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    [self.view addSubview:colletctView];
    __weak __typeof(self)weakSelf = self;
    [colletctView mas_updateConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf)stongSelf = weakSelf;
        make.top.left.equalTo(stongSelf.view);
        make.size.equalTo(stongSelf.view);
    }];
    
    
}

#pragma mark CollectionView datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0){
        return 16;
    }else{
        return 6;
    }
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    UILabel* textLabel = [[UILabel alloc]init];
    textLabel.text = [NSString stringWithFormat:@"第%ld个",(long)indexPath.row];
    return  cell;
}
//-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if(kind == UICollectionElementKindSectionHeader){
//        
//    }
//}
-(void)textFMDB
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    self.db = [FMDatabase databaseWithPath:dbPath];
    
    if (![self.db open]) {
        NSLog(@"Could not open db.");
        return ;
    }
    if(![self isTableExixt:@"PersonList"]){
        
        [self.db executeUpdate:@"CREATE TABLE PersonList (Name text, Age integer, Sex integer, Phone text, Address text)"];
        
        [self.db executeUpdate:@"INSERT INTO PersonList (Name, Age, Sex, Phone, Address) VALUES (?,?,?,?,?)",
         @"Jone", [NSNumber numberWithInt:20], [NSNumber numberWithInt:0], @"091234567", @"Taiwan, R.O.C"];
        
    }
    FMResultSet* rs = [self.db executeQuery:@"SELECT Name , Age FROM PersonList"];
    
    while ([rs next]) {
        NSString* name = [rs stringForColumn:@"Name"];
        NSLog(@"name = %@",name);
        NSInteger age = [rs intForColumn:@"Age"];
        NSLog(@"age = %ld",(long)age);
    }
    [Singleton shareSingle].textStr = @"test text";
    
    [self.db close];

}
- (BOOL) isTableExixt:(NSString *)tableName
{
    FMResultSet *rs = [self.db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        NSLog(@"isTableOK %ld", (long)count);
        
        if (0 == count)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    return NO;
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
