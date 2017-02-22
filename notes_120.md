# Danny's notes for 120 Course

## Pros and Cons of OPP
### Pros
- encapsulation - hiding some functionality and make in unavailable to rest of
  the code
  - if there's a bug in one class, it doesn't ruin the whole program.
  - knowledge of implementation of class is not needed to use it.
- allow more abstraction and complexity
- code reuse: classes can be easily reused in other programs
- polymorphism - data can be represented by many different types
- code can be read more naturally
- objects in code represent real life objects and structures
- easier testing and code maintenance - you can focus on a given class and don't
  worry about rest of the program
- inheritance, therefore code which is more DRY
- faster development, improved productivity
### Cons
- slightly slower, not suitable in some cases when performance is critical
- usually more lines of code than procedural programs
- not suitable for all problems

## Class
- class is a blueprint for object
- class encapsulates attributes (states) and behaviours for similar objects
- object is an instance of a given class

## States vs Behaviors
- attributes / states:
  - instance variables: information about given instance, prefixed with `@`
  - class variables: variable for a given class, prefixed with `@@`
- behaviours:
  - instance methods: available for object from given class
  - class methods: called on class itself
    - used when we don't to deal with specific instance of class

## Constructors
- We call `Dog.new` to instantiate a new instance of `Dog` class
- `initialize` method is the constructor method inside class which is called
  automatically when instantiating a new object. Also all parameters passed to
  `Class.new` are passed on to `initialize`

## Getter and Setter methods
- shortcuts:
  - `attr_accessor`: getter & setter
  - `attr_reader`: getter
  - `attr_writer`: setter
  - example: `attr_accessor :data, :wheels`
- when referencing instance variable in an instance method, it's generally
  better to use the accessor method rather than directly the instance variable
  - referencing: `@data`
  - setting: `@data =`
  - using getter `data`
  - using setter inside a class `self.data =`

## Instance vs. Class Methods
### Instance Methods
- can be called on an instance object

### Class Methods
- can be called on class itself, no instance is needed

## Inheritance
- class can inherit behaviours from another class, called superclass
- using inheritance we can model hierarchical relationships between objects
- example: `class Dog < Animal`
- methods in subclasses can be overriden
- `super` calls method with the same name as current instance method
  - looks for this method in the method lookup chain
  - forwards automatically all arguments of current instance method

## Multiple Inheritance
- Ruby supports multilevel inheritance (C < B < A),
- but not multiple inheritance (C < A, B)
- this a downside that makes it difficult to accurately model the problem domain
- we can mix-in as many modules as we like

## Classes vs Modules
### Classes
- have `@instance` and `@@class_variables`
- can have exactly 1 superclass
- can mixin many modules
- use with 'is-a' relationship

### Modules
- collection of behaviours which
- can be mixed in into classes
- can't create object with module
- use with 'has-a' relationship
- serve as namespaces
  - e.g. you can define `Dog` class inside `Pet` module
  - reference namespace with `::`, e.g. `Pet::Dog.new`
- you can define 'Module methods', the module serves as container
  - then call it as e.g. `Mammal.some_out_of_place_method`

## Method lookup path
- order in which methods are searched in class and module hierarchy
- call `ancestors` on a class to obtain method lookup chain
- last modules included are first in the lookup chain

## Self
- inside instance method, `self` represents instance of class
- inside class and outside of instance method `self` represents class itself

## Public, Private, Protected
- keywords don't apply to class methods
- `public` methods: accessible outside of class. aka interface methods
- `private` methods:
  - accessible inside of class only
  - can't be referenced with `self` (except for setters, ending with `=`)
- `protected` methods:
  - not accessible outside of given class
  - can be referenced with `self` inside the class

## Colaborator objects
- instance or class variables whose type is another custom defined class.
- working with collaborator objects is the same as with 'built-in' objects like
  Hashes, Arrays, ...
- example class Person has variable @pet of class Pet

## OOP Design
- Designing how to convert real life problems into OOP code. Questions which
  arise in OOP design:
  - which classes should represent the problem?
  - which behaviours and states should be in which classes?
  - what should be the collaborator objects for a given class?
  - do we use inheritance (superclass) or mixin some modules?
  - how to trade off between
    - more classes = more flexible code but also more indirection
    - less classes = less flexible code but less indirection
- Usually there is no one single correct answer to these questions, and it takes
  years to master this subject, however for big projects its important that the
  design is good from the beginning, because its costly to change the design
  later on. One tool to help in OO design are CRC cards.

## Coding tips:
- Explore the problem before design. Make a spike
- Repetitive nouns in method names is a sign that you're missing a class
- When naming methods, don't include the class names
- Avoid long method invocation chains => long chains are fragile and hard to debug
- Avoid design patterns for now

## CRC cards
- Class Responsibility Colabolator
- write down only public methods
- 1) describe problem, extract major nouns and verbs
- 2) first guess of organizing the nouns into classes and verbs into methods
- 3) with better idea model with CRC cards

## Truthiness
- in conditionals, truthy is everything which is not false or nil
- `&&` and `||` are short-circuiting and evaluating

## Equality
- `==` is a method and usually compares by value
- `equal?` method compares if objects have equal reference
- `===` used in case statements

## Variable scope
- `@instance_variables`
  - accessible at object level for all instance methods
  - referencing uninitialized instance variable returns nil
- `@@class_variables`
  - all objects share one copy
  - class methods can access class variable wherever they were initialized
  - referencing uninitialized class variable returns NameError
  - avoid using with inheritance
- `CONSTANTS`
  - lexical scope, then inheritance hierarchy

## Fake operators
- normal methods, but also they have additional special syntax
- `[]`, `[]=`, `**`, `!`, `~`, `+@`, `-@`
- `* / %`, `+ -`, `<< >>`, `&`, `^ |`
- `< <= >= >`, `<=> == === != =~ !~`
- pure operators
  - `&&`, `||`, `..`, `...`, `? :`
  - `=` and shortcuts `%=, /=, -=, +=, |=, &=, >>=, <<=, *=, &&=, ||=, **=`
    and `{`
- guidelines for overriding fake operators
  - use functionality that makes sense with special operator-like syntax

## Important methods related to OOP
- `object.class` returns class name
- `object.instance_of?(class)` true if object is instance of class
- `object.is_a?(class)` true if class or module is in objects method lookup path
- `Class.ancestors` method lookup path

## Questions:
- when there is and error raised for an object, ruby shows the instance
  variables. How can we avoid that if needed?
