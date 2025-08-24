import SwiftUI
import QuestionBankCore

struct CalculatorView: View {
    @State private var presentValue = ""
    @State private var rate = ""
    @State private var periods = ""
    @State private var futureValue = ""

    var body: some View {
        Form {
            TextField("Present Value", text: $presentValue)
                .keyboardType(.decimalPad)
            TextField("Rate (e.g., 0.05)", text: $rate)
                .keyboardType(.decimalPad)
            TextField("Periods", text: $periods)
                .keyboardType(.numberPad)

            Button("Compute FV") {
                compute()
            }

            if !futureValue.isEmpty {
                Text("Future Value: \(futureValue)")
            }
        }
        .navigationTitle("Calculator")
    }

    func compute() {
        guard
            let pv = Double(presentValue),
            let r = Double(rate),
            let n = Double(periods)
        else { return }

        let fv = TVMCalculator.futureValue(presentValue: pv, rate: r, periods: n)
        futureValue = String(format: "%.2f", fv)
    }
}
