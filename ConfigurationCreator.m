//
//  ConfigurationCreator.m
//  JustANote
//
//  Created by Martin Nash on 3/5/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

#import "ConfigurationCreator.h"
#import "ConfigurableCoreDataStack.h"

@implementation ConfigurationCreator

+(CoreDataStackConfiguration*)inMemoryStackConfiguration
{
    // create new configuration
    CoreDataStackConfiguration *config = [CoreDataStackConfiguration new];
    config.dataFileNameWithExtension = nil;
    config.storeType = NSInMemoryStoreType;
    config.modelName = @"JustANote";
    config.appIdentifier = @"com.martinjnash.example.CoreDataNotes";
    config.searchPathDirectory = NSApplicationSupportDirectory;
    return config;
}

+(CoreDataStackConfiguration*)sqliteStackConfiguration
{
    // create new configuration
    CoreDataStackConfiguration *config = [CoreDataStackConfiguration new];
    config.dataFileNameWithExtension = @"MyDataFile.sqlite";
    config.storeType = NSSQLiteStoreType;
    config.modelName = @"JustANote";
    config.appIdentifier = @"com.martinjnash.example.CoreDataNotes";
    config.searchPathDirectory = NSApplicationSupportDirectory;
    return config;
}

+(CoreDataStackConfiguration*)alternativeSqliteStackConfiguration
{
    // create new configuration
    CoreDataStackConfiguration *config = [CoreDataStackConfiguration new];
    config.dataFileNameWithExtension = @"SomeOtherCoreDataFile.sqlite";
    config.storeType = NSSQLiteStoreType;
    config.modelName = @"JustANote";
    config.appIdentifier = @"com.martinjnash.example.CoreDataNotes";
    config.searchPathDirectory = NSApplicationSupportDirectory;
    return config;
}


@end
