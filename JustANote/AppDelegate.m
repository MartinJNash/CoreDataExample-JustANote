//
//  AppDelegate.m
//  JustANote
//
//  Created by Martin Nash on 3/4/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

#import "AppDelegate.h"
#import "ConfigurableCoreDataStack.h"
#import "SubclassableCoreDataStack.h"
#import "ConfigurationCreator.h"
#import "CoreDataStackConfiguration.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

-(void)applicationDidFinishLaunching:(NSNotification *)notification
{
    
}

-(void)setupStackWithSubclassable
{
    NSManagedObjectContext *memoryMoc = [[SubclassableCoreDataStack inMemoryStack] managedObjectContext];
    NSManagedObjectContext *sqliteMoc = [[SubclassableCoreDataStack sqliteStack] managedObjectContext];
    [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:memoryMoc];
    [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:sqliteMoc];
}

-(void)setupStackWithConfiguration
{
    // create new configuration
    CoreDataStackConfiguration *config = [CoreDataStackConfiguration new];
    config.dataFileNameWithExtension = @"MyDataFile.sqlite";
    config.storeType = NSInMemoryStoreType;
    config.modelName = @"JustANote";
    config.appIdentifier = @"com.martinjnash.example.CoreDataNotes";
    config.searchPathDirectory = NSApplicationSupportDirectory;
    
    // create a stack with that configuration
    ConfigurableCoreDataStack *stack = [[ConfigurableCoreDataStack alloc] initWithConfiguration:config];
    NSManagedObjectContext *context = stack.managedObjectContext;
    
    [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:context];
}

-(void)setupStackWithConfigurationUsingEncapsulation
{
    // much less code than above. And all of our configurations are in one file. Beautiful!
    CoreDataStackConfiguration *config = [ConfigurationCreator inMemoryStackConfiguration];
    ConfigurableCoreDataStack *stack = [[ConfigurableCoreDataStack alloc] initWithConfiguration:config];
    NSManagedObjectContext *moc = stack.managedObjectContext;
    
    [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:moc];
    
    
    
    // convenience constructor for stack
    ConfigurableCoreDataStack *anotherStack = [ConfigurableCoreDataStack stackWithConfiguration:config];
    anotherStack = nil;
    
}


@end
