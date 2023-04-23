//
//  ViewController.swift
//  Multithreading
//
//  Created by 123 周 on 2023/4/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        semaphore()
    }
    /*
     
     全局队列（Global Dispatch Queue）是GCD提供的一种全局共享的并发队列，可以用于执行异步任务，他是系统提供的几个预定义队列之一，同时也是使用最为广泛的队列之一
     全局队列是由操作系统内核管理的，内置了多个线程，可以同时执行多个任务，并发利用CPU资源，全局队列分为四个优先级（Qos）: userInteractive、userInitiated、default 和 utility，其中 userInteractive 优先级最高，utility 优先级最低。系统会根据当前任务的优先级和系统负载情况来动态调整队列中各个任务的执行顺序和时间片分配。
     */
    func GCD() {
        
        //        在全局队列中异步执行一个任务
        DispatchQueue.global().async {
            print("is run herer 1")
        }
        
        DispatchQueue.global().async {
            print("is run herer 2")
        }
        
        DispatchQueue.global().async {
            print("is run herer 3")
        }
        DispatchQueue.global().async {
            print("is run herer 4")
        }
        //输出结果是随机的
        //获取全局队列
        let queue = DispatchQueue.global()
        //        如果需要指定一个特定的全局队列优先级，可以使用以下代码：
        let queue1 = DispatchQueue.global(qos: .userInitiated)
        
        /*
         使用全局队列可以避免手动创建队列的复杂性，同时也可以充分利用系统资源来实现高效的并发执行。在大多数情况下，建议使用全局队列来执行异步任务，以提高应用程序的性能和响应速度。
         */
    }
    
    /*
     全局队列（Global Dispatch Queue）和手动创建队列的区别在于它们的创建方式和使用方式。
     
     全局队列是由系统自动创建和管理的队列，可以用于并发执行异步任务。全局队列分为四个优先级（QoS）：`userInteractive`、`userInitiated`、`default` 和 `utility`，并且内置了多个线程，可以同时执行多个任务。全局队列的优点在于使用方便，不需要手动创建队列，可以直接使用系统提供的全局队列来执行异步任务，而且系统会根据当前任务的优先级和系统负载情况来动态调整队列中各个任务的执行顺序和时间片分配。
     
     手动创建队列则需要开发者手动创建队列对象，可以指定队列的名称和队列的属性，如并发数和队列的 QoS。手动创建队列的优点在于，可以更加灵活地控制队列的行为和属性，可以根据具体的需求来创建不同的队列，从而实现更加高效和优化的多线程编程。
     
     总的来说，全局队列适用于大多数的异步任务场景，对于一些特殊的需求，如需要控制队列的并发数和优先级等情况，可以选择手动创建队列来实现。
     */
    func manualQueue() {
        let queue1 = DispatchQueue(label: "com.example.myQueue", attributes: .concurrent)
        queue1.setTarget(queue: DispatchQueue(label: "com.example.targetQueue", attributes: .concurrent))
        let queue = DispatchQueue(label: "com.example.myQueue", qos: .userInitiated, attributes: .concurrent)
//        queue.qos = .userInteractive
    }
    
    //在主队列中异步执行一个任务
    func GCDMain() {
        //主队列只能执行异步操作，执行同步操作会卡死
        let queue = DispatchQueue.main
        //禁止执行这种操作
//        queue.sync {
//            print("main 1")
//        }
     
        //打印顺序是按顺序执行
        queue.async {
            print("main 11")
        }
        queue.async {
            print("main 22")
        }
        queue.async {
            print("main 33")
        }
        queue.async {
            print("main 44")
        }
    }
    
    func GCDAfter() {
        //主线程延迟一秒执行
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            print("GCDAfter1")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            print("GCDAfter2")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            print("GCDAfter3")
        }
    }
    
    func semaphore() {
        //随机执行
        let semaphore = DispatchSemaphore(value: 5)
        DispatchQueue.global().async {
            semaphore.wait()
            print("semaphore1")
            semaphore.signal()
        }
        DispatchQueue.global().async {
            semaphore.wait()
            print("semaphore2")
            semaphore.signal()
        }
        
        DispatchQueue.global().async {
            semaphore.wait()
            print("semaphore3")
            semaphore.signal()
        }
        
        DispatchQueue.global().async {
            semaphore.wait()
            print("semaphore4")
            semaphore.signal()
        }
        DispatchQueue.global().async {
            semaphore.wait()
            print("semaphore5")
            semaphore.signal()
        }
    }
    
}

