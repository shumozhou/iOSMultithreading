// 自定义的 NSOperation 子类，用于执行具体的任务
import Foundation
class MyOperation: Operation {
    var inputData: String?
    var outputData: String?

    init(inputData: String?) {
        self.inputData = inputData
    }

    override func main() {
        if isCancelled {
            return
        }

        // 模拟耗时任务
        sleep(1)

        if let inputData = inputData {
            outputData = "Processed: \(inputData)"
        }
    }
}
