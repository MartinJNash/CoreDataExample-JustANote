## CoreData Example Note app

### Configurable Stack

[ConfigurableCoreDataStack.m](ConfigurableCoreDataStack.m) is a flexible class that allows you to create a core data stack based on a `CoreDataStackConfiguration` object. This allows you to easily create core data stacks to suit your needs.

```objc
// create configuration object
CoreDataStackConfiguration *config = [CoreDataStackConfiguration new];
config.dataFileNameWithExtension = @"MyDataFile.sqlite";
config.storeType = NSInMemoryStoreType;
config.modelName = @"JustANote";
config.appIdentifier = @"com.martinjnash.example.CoreDataNotes";
config.searchPathDirectory = NSApplicationSupportDirectory;

// init stack with configuration object
ConfigurableCoreDataStack *stack = [[ConfigurableCoreDataStack alloc] initWithConfiguration:config];
NSManagedObjectContext *context = stack.managedObjectContext;
```


### Standard Stack (change or subclass)

See [CoreDataStack.m](CoreDataStack.m) for an example of how to setup your core data stack. This can be configured by changing the return values directly or by overriding them in a subclass to support your app's unique configuration.

There are two default store types. SQLite and in-memory. The in-memory store type can be used for unit tests, since state is not saved between launches.

This is not as flexible as the configurable stack. But can be enough for a simple app that doesn't require flexibility.

There's not much to it once you've customized the return values. Just create a stack with one of the following methods:

```objc
// sqlite
NSManagedObjectContext *moc = [[CoreDataStack sqliteStack] managedObjectContext];

// memory
NSManagedObjectContext *moc = [[CoreDataStack inMemoryStack] managedObjectContext];
```

Note: the class methods sqliteStack and inMemory stack do not return singletons. A new stack instance is created every time.



