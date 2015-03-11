---

title: OFA

layout: default

---

OFA Populator offers an easy to implement yet powerful and non-limiting way to populate table and collection views with one goal in mind: Keep view controllers clean and MVC smart.

What is wrong with the standard Datasource/Delegate approach?
-------------------------------------------------------------

Nothing is wrong with delegates and datasources, it is one of the most useful patterns in application programming.  
But nearly all codes you find only to demonstrate how to implement them are inherently broken. Yes, even those provided by Apple.

In nearly every code you will find view controllers implementing just — anything.

They deal with

-	Core Data
-	network handling
-	creating complex view hierarchies
-	calculations of any kind
-	…

But what is wrong with View Controllers implementing these kind of stuff?
-------------------------------------------------------------------------

In Computer Science we know some principles that regardless of your coding paradigm and philosophies should be valued.  
one the most importend is the «Single Responsible Principle», aka «SRP» and means that there should be only one task a code entity fulfills.

> «A functional unit on a given level of abstraction should only be responsible for a single aspect of a system’s requirements. An aspect of requirements is a trait or property of requirements, which can change independently of other aspects.» – Ralf Westphal[^1]

Sometimes it is hard to break down an idea into atomic entities or aspects.  
But actually the original definition is very helpful in OOD:

> «There should never be more than one reason for a class to change.» – Robert C. Martin[^2]

So

-	if our Core Data model changes, our view model shouldn't  
-	If we switch from one Network framework to another: our view controller shouldn't be aware of it  
-	views should create its subviews.
-	Should a view controller render images? Seriously — no …

But if we don't wrap datasource & delegate in objects but implement them in the view controllers, it is just too easy to break SRP.

But how to fix that?
--------------------

There is a wide variations of patters that might come in handy.  
In OFA we use Farçade to encapsulate the (not too heavy) lifting and make it easily adaptable for future developments (such as cubic collection views once Apple shows Google how to build data glasses).  
Also we use the Façade to break up the data source and delegate handling on Section level, making it easy to populate the sections of a table or collection view with different data and cells.  
These section populators use data fetcher objects that will provide them with objects they fetch. Let it be from network, file system or some heavy computation. A data fetcher can be any object that conforms a certain protocol. There-for it is easy to adapt and integrate it in any project.

Sample usage
------------

Let's build a simple app that downloads pictures from Flicker and displays it in a table view.

First we need to create  a data fetcher that gets the images from Flickr and can offer them to the populator.  
The protocol it needs to implement is OFDataFetcher


[^1]: Ralf Westphal: [Taking the Single Responsibility Principle Seriously](http://www.developerfusion.com/article/137636/taking-the-single-responsibility-principle-seriously/). In: developerFusion. 2012-02-06

[^2]: Robert C. Martin: [SRP: The Single Responsibility Principle](http://www.objectmentor.com/resources/articles/srp.pdf) (PDF). 1997
