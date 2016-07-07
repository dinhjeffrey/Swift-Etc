//: Playground - noun: a place where people can play
import UIKit
import Foundation


// Multithreading

// Queues can be Serial (single) vs Concurrent(multiple)

// The main queue
let mainQ: dispatch_queue_t = dispatch_get_main_queue()
/* 
 all UI stuff must be done on this queue!
 and all time-consuming(or, worse, potentially blocking) stuff must be done off this queue!
 common code to write...
 */
dispatch_async(not the main queue) {
    // do a non-UI that might block or otherwise take a while
    dispatch_async(dispatch_get_main_queue()) {
        // call UI functions with the results above
    }
}

// so how do we get a "not the main queue" queue?

// Other (concurrent) queues (i.e. not the main queue)
// most non-main-queue work will happen on a concurrent queue with a certain Quality of Service
QOS_CLASS_USER_INTERACTIVE // quick and high priority. lower than main_queue though
QOS_CLASS_USER_INITIATED // hight priortiy, might take time
QOS_CLASS_UTILITY // long running
QOS_CLASS_BACKGROUND // user not concerned with this (prefetching, etc.)
let queue = dispatch_get_global_queue(<one of the above>, 0) // 0 is a "reserved for the future"
// You will probably use these queues to do any work that you don't want to block the main queue


// You can create your own serial queue if you need serialization
let serialQ = dispatch_queue_create("name", DISPATCH_QUEUE_SERIAL)
// maybe you are downloading a bunch of thing form a certain website but you don't want to deluge that website, so you queue the requests up serially or maybe the things you are doing depend on each other in a serial fashion

// This is only the tip of the icebergy
// There is a lot more to GCD
// You can do locking, protect critical sections, readers and writers, synchronous dispatch, etc.


// There is also an object-oriented API to all of this
NSOperationQueue /* and */ NSOperation
// Surprisingly, we use the non-object-oriented API a lot of the time
// This is because the "nesting" of dispatching reads very well in the code


// example How to do UI stuff safely
// simply dispatch back to the main queue
let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
if let url = NSURL(string: "http://url") {
    let request = NSURLRequest(URL: url)
    let task = session.downloadTaskWithRequest(request) { (localURL, response, error) in
        dispatch_async(dispatch_get_main_queue()) {
            /* I want to do something in the UI here */
        }
    }
    task.resume()
}



































