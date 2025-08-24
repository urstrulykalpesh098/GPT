import Foundation

public struct TVMCalculator {
    public static func futureValue(presentValue: Double,
                                   rate: Double,
                                   periods: Double,
                                   payment: Double = 0.0,
                                   paymentsAtBeginning: Bool = false) -> Double {
        let r = rate
        if r == 0 {
            return presentValue + payment * periods
        }

        let when = paymentsAtBeginning ? 1.0 : 0.0
        let fvPayment = payment * (1 + r * when) * (pow(1 + r, periods) - 1) / r
        let fvPrincipal = presentValue * pow(1 + r, periods)
        return fvPrincipal + fvPayment
    }
}
