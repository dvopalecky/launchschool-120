# Danny's notes for 120 Course

## States vs Behaviors
- states:
  - instance variables: information about given instance
- behaviour:
  - instance methods: available for object from given class

## Constructors
- `initialize` method is the constructor method

## Getter and Setter methods
- shortcut `attr_accessor`
- when referencing instance variable in an instance method, it's generally
  better to use the accessor method rather than directly the instance variable

## Classes vs Modules
### Classes
- have `@instance` and `@@class_variables`
- can have exactly 1 superclass
- can mixin many modules

### Modules
- serve as namespaces


## Questions:
- is it ok to define `attr_accessor` and then overwrite the getter or setter?
- when there is and error raised for an object, ruby shows the instance
  variables. How can we avoid that if needed?

## Design:
- tradeoff between
  - more classes = more flexible code but also more indirection
  - less classes = less flexible code but less indirection

## Coding tips:
- Explore the problem before design. Make a spike
- Repetitive nouns in method names is a sign that you're missing a class
- When naming methods, don't include the class names
- Avoid long method invocation chains => long chains are fragile and hard to debug
- Avoid design patterns for now
