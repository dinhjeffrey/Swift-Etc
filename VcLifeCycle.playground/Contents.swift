//: Playground - noun: a place where people can play

Summary
    Instantiated (from storyboard usually)
    awakeFromNib
    segue preparation happens
    outlets get set
    viewDidLoad
    These pairs will be called each time your Controllers view goes on/off screen ...
        viewWillAppear and viewDidAppear
        viewWillDisappear and viewDidDisappear
    These "geometry changed" methods might be called at any time after viewDidLoad ...
        viewWillLayoutSubviews (... then autolayout happens, then ...) viewDidLayoutSubviews
    If memory gets low, you might get ...
        didReceiveMemoryWarning


// Build iOS apps multi-threaded. UI in one thread - never blocked. Any network in another thread.

awakeFromNib // called upon really early, only if coming from StoryBoard. gets sent to every object in storyboard, not just view Controllers. put code ELSEWHERE not here if possible


viewDidLoad // - when your outlets are set. Good place for a lot of set up code. Be careful because geometry isnt determined yet, so things that use bound won't work here. It doesn't know if it's bounds are iPhone or iPad, etc.


viewWillAppear // fire off another thread for something EXPENSIVE. like fetching data from the network. view might appear and disappear a lot, so code here might be called OVER and OVER.

viewDidAppear // good place to start animation. view gets loaded ONCE.

viewWillDisappear // stop animation and stuff like spinning wheel from viewDidAppear

viewDidDisappear // free up something from the network from viewWillAppear

func viewWillLayoutSubviews() and func viewDidLayoutSubviews() // GETS CALLED ALL THE TIME. good place for geometry changes. auto layout and constraints occurs inbetween viewWillLayoutSubviews and viewDidLayoutSubviews. Geometry changes mostly in rotation from landscape <--> portrait. Doesn't change when bound changes, system is allowed to call it WHENEVER even if bounds didnt change, like when it draws something, but the bounds haven't changed, it could be called.

// AUTOROTATION

func viewWillTransitionToSize // method to animate going from/to portait/landscape

// LOW MEMORY
didReceiveMemoryWarning // gets called. Anything"big" that is not currently in use should be released by setting any pointers to it to nil.



 
 
 
 
 
 

