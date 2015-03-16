OFAPopulator
============

*Once and For All TableView and CollectionView Populator*

Using the Adapter Pattern the goal of OFA is to make the hassle of populating table and collection views go away and get easy to subclass and reusable components. Without harming MVC or limit the delegate/datasource pattern

Populating a tableview with one section:

```objc
OFASectionPopulator *section1Populator = [[OFASectionPopulator alloc] initWithParentView:self.tableView
                                                                             dataFetcher:[[ExampleDataFetcher alloc] init]
                                                                               cellClass:[UITableViewCell class]
                                                                          cellIdentifier:^NSString* (id obj, NSIndexPath *indexPath){ return  indexPath.row % 2  ? @"Section1_1" : @"Section1_2" ; }
                                                                        cellConfigurator:^(id obj, UIView *view, NSIndexPath *indexPath)
{
    UITableViewCell *cell = (UITableViewCell *)view;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", obj];
    cell.textLabel.backgroundColor = [UIColor clearColor];
}];
self.populator = [[OFASectionedPopulator alloc] initWithParentView:self.tableView
                                                 sectionPopulators:@[section1Populator]];

```

Populating a collection view with one section and the same data:

```objc
OFASectionPopulator *section1Populator = [[OFASectionPopulator alloc] initWithParentView:self.collectionView
                                                                             dataFetcher:[[ExampleDataFetcher alloc] init]
                                                                               cellClass:[ExampleCollectionViewCell class]
                                                                          cellIdentifier:^NSString* (id obj, NSIndexPath *indexPath){ return  indexPath.row % 2  ? @"cell" : @"cell2" ; }
                                                                        cellConfigurator:^(id obj, UIView *view, NSIndexPath *indexPath)
{
    ExampleCollectionViewCell *cell = (ExampleCollectionViewCell *)view;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", obj];
}];


self.populator = [[OFASectionedPopulator alloc] initWithParentView:self.collectionView
                                                 sectionPopulators:@[section1Populator]];
```

Except passing in a collection view and a UICollectionViewCell class, the codes are identical.

![tableview](https://github.com/vikingosegundo/ofapopulator/raw/master/tableview.png) ![collectionview](https://github.com/vikingosegundo/ofapopulator/raw/master/collectionview.png)

## Install

* via Cocoapods:

        pod 'OFAPopulator'
