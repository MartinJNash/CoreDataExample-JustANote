## CoreData Example Note app

### Stack

See [CoreDataStack.m](CoreDataStack.m) for an example of how to setup your core data stack. This can be configured by changing the return values directly or by overriding them in a subclass to support your app's unique configuration.

There are two default store types. SQLite and in-memory. The in-memory store type can be used for unit tests, since state is not saved between launches.

### Use

There's not much to it once you've customized the return values. Just create a stack with one of the following methods:

```objc
// sqlite
NSManagedObjectContext *moc = [[CoreDataStack sqliteStack] managedObjectContext];

// memory
NSManagedObjectContext *moc = [[CoreDataStack inMemoryStack] managedObjectContext];
```

Note: the class methods sqliteStack and inMemory stack do not return singletons. A new stack instance is created every time.



