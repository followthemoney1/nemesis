"use strict";
exports.__esModule = true;
exports.TotalBets = void 0;
var TotalBets = /** @class */ (function () {
    function TotalBets(placed_totals, procent_totals) {
        this.placed_totals = placed_totals;
        this.procent_totals = procent_totals;
        this.placedTotals = placed_totals;
        this.procentTotals = procent_totals;
    }
    TotalBets.prototype.toString = function () {
        return this.placedTotals + ", by " + this.procentTotals;
    };
    return TotalBets;
}());
exports.TotalBets = TotalBets;
