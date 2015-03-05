//
//  Created by Martin Nash on 2/26/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

#import "SubclassableCoreDataStack.h"

@interface SubclassableCoreDataStack ()
@property (strong, nonatomic) NSString *storeType;
@end

@implementation SubclassableCoreDataStack

+(SubclassableCoreDataStack*)sqliteStack
{
    return [[self alloc] initWithStoreType:NSSQLiteStoreType];
}

+(SubclassableCoreDataStack*)inMemoryStack
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




#pragma mark - Configuration

/// must match the name of your xcdatamodel file
-(NSString*)dataModelName
{
    return @"JustANote";
}

/// the reverse domain for your app
-(NSString*)appReverseDomainIdentifier
{
    return @"com.martinjnash.example.JustANote";
}

/// name of data file on disk
-(NSString*)dataFileNameWithExtension
{
    return @"MyStore.sqlite";
}

/// directory to create your app subdirectory in
-(NSSearchPathDirectory)searchPathDirectory
{
    return NSApplicationSupportDirectory;
}




#pragma mark - internal

/// returns url to file `~/<your serach path directory>/<your reverse told app identifier>`
-(NSURL *)applicationDocumentsDirectory
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *possible = [fm URLsForDirectory:[self searchPathDirectory] inDomains:NSUserDomainMask];
    NSURL *appSupportURL = [possible lastObject];
    return [appSupportURL URLByAppendingPathComponent:[self appReverseDomainIdentifier]];
}

/// returns url to file `~/<your serach path directory>/<your reverse told app identifier>/<your data file name with extension>`
-(NSURL*)dataFileURL
{
    return [[self applicationDocumentsDirectory] URLByAppendingPathComponent:[self dataFileNameWithExtension]];
}

-(void)setupStack
{
    // ENSURE APP FILES DIRECTORY EXSITS
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *appPath = [[self applicationDocumentsDirectory] path];
    [fm createDirectoryAtPath:appPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    
    // MODEL
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:[self dataModelName] withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    
    // STORE & COORDINATOR
    NSURL *storeURL = [self dataFileURL];
    
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
