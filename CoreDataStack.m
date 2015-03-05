//
//  CoreDataStack.m
//  DataBoom
//
//  Created by Martin Nash on 2/26/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

#import "CoreDataStack.h"

@interface CoreDataStack ()
@property (strong, nonatomic) NSString *storeType;
@end

@implementation CoreDataStack

+(CoreDataStack*)sqliteStack
{
    return [[self alloc] initWithStoreType:NSSQLiteStoreType];
}

+(CoreDataStack*)inMemoryStack
{
    return [[self alloc] initWithStoreType:NSInMemoryStoreType];
}

-(instancetype)initWithStoreType:(NSString*)storeType;
{
    self = [super init];
    if (self) {
        self.storeType = storeType;
        [self setupStack];
    }
    return self;
}

-(instancetype)init
{
    @throw @"Use -initWithStoreType:";
}



#pragma mark - internal

-(NSString*)storeName
{
    return @"Inventory";
}

-(NSURL *)applicationDocumentsDirectory
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *possible = [fm URLsForDirectory:NSApplicationSupportDirectory
                                   inDomains:NSUserDomainMask];
    NSURL *appSupportURL = [possible lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"com.uw.2015.winter.CoreDataApp"];
}

-(NSURL*)defaultDataFileURL
{
    return [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MyData.store"];
}

-(void)setupStack
{
    // ENSURE APP FILES DIRECTORY EXSITS
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *appPath = [[self applicationDocumentsDirectory] path];
    [fm createDirectoryAtPath:appPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    
    // MODEL
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:[self storeName] withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    
    // STORE & COORDINATOR
    NSURL *storeURL = [self defaultDataFileURL];
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    [psc addPersistentStoreWithType:self.storeType
                      configuration:nil
                                URL:storeURL
                            options:nil
                              error:nil];
    
    
    // CONTEXT
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    moc.persistentStoreCoordinator = psc;
    _managedObjectContext = moc;
    
}

@end
