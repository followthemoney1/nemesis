
export class TotalBets {
    placedTotals: Map<string, number>;
    procentTotals:
        Map<string, number>;
    constructor(readonly placed_totals: Map<string, number>, readonly procent_totals:
        Map<string, number>,
    ) {
        this.placedTotals = placed_totals;
        this.procentTotals = procent_totals;
    }

    toString(): string {
        return this.placedTotals + ", by " + this.procentTotals;
    }
}
