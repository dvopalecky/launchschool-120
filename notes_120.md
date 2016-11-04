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

## Questions:
- is it ok to define `attr_accessor` and then overwrite the getter or setter?
- when there is and error raised for an object, ruby shows the instance
  variables. How can we avoid that if needed?