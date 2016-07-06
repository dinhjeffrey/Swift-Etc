//: DELEGATION

A very important use of protocols
    It's a way to implement "blind communication" between a View and its Controller

How it plays out ...
    1. A View declares a delegation protocol(i.e. what the View wants the Controller to do for it)
    2. The View's API has a weak delegate property whose type is that delegation protocol
    3. The View uses the delegate property to get/do things it can't own or control on its own
    4. The Controller declares that it implements the protocol
    5. The Controller sets self as the delegate of the View by setting the property in #2  above
    6. The Controller implements the protocol (probably it has lots of optional methods in it)

Now the View is hooked up to the Controller
    But the View still has no idea what the Controller is, so the View remains generic/reusable

This mechanism is found throughout iOS
    However, it was designed pre-closures in Swift. Closures are often a better option

// sometimes iOS uses protocols and sometimes closures, not exact substitutes for each other. Protocol makes it clear what is being delegated and closures are good for error callbacks and multithreading