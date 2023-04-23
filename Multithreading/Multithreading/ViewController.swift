//
//  ViewController.swift
//  Multithreading
//
//  Created by 123 周 on 2023/4/23.
//

import UIKit

class ViewController: UIViewController {
    var workItems: [DispatchWorkItem] = []
    let group = DispatchGroup()
    override func viewDidLoad() {
        super.viewDidLoad()
//        dispatchGroup()
        let button = UIButton(type: .system)
        button.setTitle("取消任务", for: .normal)
        button.addTarget(self, action: #selector(cancelTasks), for: .touchUpInside)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        self.view.addSubview(button)
        
//        startGroupTasks()
        testOperation()
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
    
    
    func dispatchGroup() {
        //        创建 Dispatch Group
        //        可以使用 dispatch_group_create 函数创建一个 Dispatch Group，例如：
        let group = DispatchGroup()
        
        
        //        可以使用异步队列（例如全局队列）或自定义队列来提交任务，并使用 dispatch_group_enter 和 dispatch_group_leave 来标记任务的开始和结束。例如
        group.enter()
        DispatchQueue.global().async {
            print("执行任务 1")
            group.leave()
        }
        
        group.enter()
        DispatchQueue.global().async {
            print("执行任务 2")
            group.leave()
        }
        
        //        在上述代码中，创建了一个全局队列，并使用 enter 和 leave 标记了两个异步任务的开始和结束。
        
        
        //        指定回调函数
        //        可以使用 dispatch_group_notify 函数指定一个在所有任务执行完成后需要执行的回调函数。例如：
        group.notify(queue: .main) {
            // 所有任务执行完成后执行的回调函数
        }
        
        //        在上述代码中，使用 notify 方法指定了一个在所有任务执行完成后需要执行的回调函数，该回调函数将在主队列中执行。
        
        
        //        等待任务执行完成
        //        可以使用 dispatch_group_wait 函数等待所有任务执行完成。例如：
        
        let result = group.wait(timeout: .now() + 10)
        
        if result == .success {
            // 所有任务执行完成
        } else {
            // 等待超时
        }
        
        //        在上述代码中，使用 wait 方法等待所有任务执行完成，等待时间为 10 秒。
        //
        //        需要注意的是，使用 Dispatch Group 时，必须确保在每个任务执行完成后调用 leave 方法，否则会导致 Dispatch Group 一直处于等待状态，从而无法执行回调函数。同时，也可以在任务执行失败时调用 leave 方法，以便更好地处理错误情况。
        //
        //        Dispatch Group 可以很方便地实现多个任务的并行执行和执行状态的管理，特别适用于需要并行执行多个任务，并在所有任务都执行完成后进行进一步处理的场景。
        
        
        
        
        
        let queue = DispatchQueue.global(qos: .default)
        
        let workItem = DispatchWorkItem {
            if !Thread.current.isCancelled {
                // 执行任务逻辑
                print("执行任务逻辑")
            }
        }
        
        queue.async(execute: workItem)
        
        // 取消任务
        workItem.cancel()
        
        //        在上述代码中，使用 DispatchWorkItem 创建了一个任务，并通过 DispatchQueue 异步执行。在任务的 Block 中，通过检查 Thread.current.isCancelled 属性来判断任务是否已被取消。在取消任务时，调用了 DispatchWorkItem 的 cancel() 方法，将任务标记为已取消。
        //
        //        需要注意的是，取消任务并不会立即停止任务的执行，而是在下次任务执行之前检查任务是否已被取消。因此，在 Block 中需要定期检查任务是否已被取消，并在任务被取消时尽早退出任务的执行。
    }
    
    
    func startGroupTasks() {
        let tasks = [task1, task2, task3]
        
        tasks.forEach { task in
            let workItem = DispatchWorkItem(block: task)
            workItems.append(workItem)
            DispatchQueue.global(qos: .userInitiated).async(group: group, execute: workItem)
        }
        
        group.notify(queue: .main) {
            print("所有任务已完成")
        }
    }
    
    @objc func cancelTasks() {
        workItems.forEach { $0.cancel() }
    }
    
    func task1() {
        simulateTask(taskName: "任务1", duration: 3)
    }
    
    func task2() {
        simulateTask(taskName: "任务2", duration: 2)
    }
    
    func task3() {
        simulateTask(taskName: "任务3", duration: 1)
    }
    
    func simulateTask(taskName: String, duration: UInt32) {
        print("\(taskName) 开始执行")
        sleep(duration)
        print("\(taskName) 执行完毕")
    }
    
    func testOperation() {
        // 创建操作队列
        let operationQueue = OperationQueue()
        
        // 创建任务
        let operation1 = MyOperation(inputData: "Data 1")
        let operation2 = MyOperation(inputData: "Data 2")
        let operation3 = MyOperation(inputData: "Data 3")
        
        // 添加依赖关系，控制任务执行顺序
        operation2.addDependency(operation1)
        operation3.addDependency(operation2)
        
        // 当任务完成后，处理结果数据
        operation1.completionBlock = {
            print("Operation 1 result: \(operation1.outputData ?? "No output")")
        }
        operation2.completionBlock = {
            print("Operation 2 result: \(operation2.outputData ?? "No output")")
        }
        operation3.completionBlock = {
            print("Operation 3 result: \(operation3.outputData ?? "No output")")
        }
        
        // 添加任务到队列并开始执行
        operationQueue.addOperations([operation1, operation2, operation3], waitUntilFinished: false)
        
        // 取消任务（如果需要）
        // operation1.cancel()
    }
}

