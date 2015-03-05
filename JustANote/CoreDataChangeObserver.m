//
//  CoreDataChangeObserver.m
//  Inventory
//
//  Created by Martin Nash on 3/2/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

#import "CoreDataChangeObserver.h"

@interface CoreDataChangeObserver ()
@property (strong, nonatomic) NSFetchRequest *fr;
@property (strong, nonatomic) NSManagedObjectContext *moc;
@property (strong, nonatomic) NSArray *fetchedObjects;
@end

@implementation CoreDataChangeObserver

-(void)performFetch
{
     self.fetchedObjects = [self.moc executeFetchRequest:self.fr error:nil];
}

-(instancetype)initWithFetchRequest:(NSFetchRequest*)fr andMoc:(NSManagedObjectContext*)moc
{
    self = [super init];
    if (self) {
        _moc = moc;
        _fr = fr;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMocDidSave:) name:NSManagedObjectContextDidSaveNotification object:self.moc];
        
    }
    return self;
}

-(instancetype)init
{
    @throw @"use -initWithFetchRequest:andMoc:";
}

-(void)handleMocDidSave:(NSNotification*)notification
{
    if (self.beginChangesHandler) {
        self.beginChangesHandler();
    }
    
    NSSet *inserted = notification.userInfo[NSInsertedObjectsKey];
    NSSet *deleted = notification.userInfo[NSDeletedObjectsKey];
    NSSet *changed = notification.userInfo[NSUpdatedObjectsKey];
    NSArray *oldVersion = self.fetchedObjects;
    
    [self performFetch];

    if (self.insertionHandler) {
        for (NSManagedObject *insertedObject in inserted) {
            if ([insertedObject.entity isEqualTo:self.fr.entity]) {
                NSUInteger index = [self.fetchedObjects indexOfObject:insertedObject];
                self.insertionHandler(insertedObject, index);
            }
        }
    }

    if (self.movementHandler) {
        for (NSManagedObject *obj in changed) {
            if ([obj.entity isEqualTo:self.fr.entity]) {
                NSUInteger originalIndex = [oldVersion indexOfObject:obj];
                NSUInteger newIndex = [self.fetchedObjects indexOfObject:obj];
                self.movementHandler(obj, originalIndex, newIndex);
            }
        }
    }
    
    if (self.deletionHandler) {
        NSArray *sorted = [deleted.allObjects sortedArrayUsingDescriptors:self.fr.sortDescriptors].reverseObjectEnumerator.allObjects;
        for (NSManagedObject *obj in sorted) {
            if ([obj.entity isEqualTo:self.fr.entity]) {
                NSUInteger oldIndex = [oldVersion indexOfObject:obj];
                self.deletionHandler(obj, oldIndex);
            }
        }
    }
    
    if (self.multipleDeletionHandler) {
        NSIndexSet *indexes = [oldVersion indexesOfObjectsPassingTest:^BOOL(NSManagedObject *obj, NSUInteger idx, BOOL *stop) {
            return [deleted containsObject:obj];
        }];
        self.multipleDeletionHandler(deleted.allObjects, indexes);
    }
    
    if (self.endChangesHandler) {
        self.endChangesHandler();
    }
}

@end
