//
//  Created by Martin Nash on 3/4/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

#import "ConfigurableCoreDataStack.h"
#import "CoreDataStackConfiguration.h"


@interface ConfigurableCoreDataStack ()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) CoreDataStackConfiguration *configuration;
@end

@implementation ConfigurableCoreDataStack

+(instancetype)stackWithConfiguration:(CoreDataStackConfiguration *)configuration
{
    return [[self alloc] initWithConfiguration:configuration];
}

+(instancetype)stackWithConfigurator:(id<StackConfigurator>)configurator
{
    return [[self alloc] initWithConfigurator:configurator];
}

-(instancetype)initWithConfigurator:(id<StackConfigurator>)configurator
{
    CoreDataStackConfiguration *cf = [[CoreDataStackConfiguration alloc] initWithConfigurator:configurator];
    return [self initWithConfiguration:cf];
}

-(instancetype)initWithConfiguration:(CoreDataStackConfiguration*)configuration;
{
    self = [super init];
    if (self) {
        _configuration = configuration;
        [self setupStack];
    }
    return self;
}

-(instancetype)init
{
    @throw @"Use -initWithStoreType:";
}




#pragma mark - internal

/// returns url to file `~/<your serach path directory>/<your reverse told app identifier>`
-(NSURL *)applicationDocumentsDirectory
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *possible = [fm URLsForDirectory:self.configuration.searchPathDirectory inDomains:NSUserDomainMask];
    NSURL *appSupportURL = [possible lastObject];
    return [appSupportURL URLByAppendingPathComponent:self.configuration.appIdentifier];
}

/// returns url to file `~/<your serach path directory>/<your reverse told app identifier>/<your data file name with extension>`
-(NSURL*)dataFileURL
{
    return [[self applicationDocumentsDirectory] URLByAppendingPathComponent:self.configuration.dataFileNameWithExtension];
}

-(void)setupStack
{
    // ENSURE APP FILES DIRECTORY EXSITS
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *appPath = self.dataFileURL.URLByDeletingLastPathComponent.path;
    [fm createDirectoryAtPath:appPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    
    // MODEL
    NSURL *modelURL = [[NSBundle bundleForClass:self.class] URLForResource:self.configuration.modelName withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    
    // STORE & COORDINATOR
    NSURL *storeURL = [self dataFileURL];
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    [psc addPersistentStoreWithType:self.configuration.storeType
                      configuration:nil
                                URL:storeURL
                            options:nil
                              error:nil];
    
    
    // CONTEXT
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    moc.persistentStoreCoordinator = psc;
    _managedObjectContext = moc;
}

-(void)removeCoreDataFilesFromDisk
{
    NSError *ee = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *contents = [fm contentsOfDirectoryAtURL:self.dataFileURL.URLByDeletingLastPathComponent includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:&ee];
    
    for (NSURL *oneURL in contents) {
        if ([oneURL.lastPathComponent hasPrefix:self.configuration.dataFileNameWithExtension]) {
            [fm removeItemAtURL:oneURL error:&ee];
        }
    }

    _managedObjectContext = nil;
}

-(NSManagedObjectContext *)managedObjectContext
{
    if (!_managedObjectContext) {
        [self setupStack];
    }
    
    return _managedObjectContext;
}


@end
