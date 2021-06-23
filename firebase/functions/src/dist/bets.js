"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
exports.__esModule = true;
exports.placeABet = void 0;
// import * as functions from "firebase-functions";
// import * as admin from "firebase-admin";
var firebase_admin_1 = require("firebase-admin");
var helpers_1 = require("./helpers");
// import { TotalBets } from "./data/total_bets_data";
exports.placeABet = function place(userId, place, matchId, onTeamId) {
    return __awaiter(this, void 0, void 0, function () {
        var currentRef, p, placed, placedObject, newPlace, finalPlaced, resPlaced, t, totals, totalsData, team1, team2, finalTotals, resTotals, e_1;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    _a.trys.push([0, 5, , 6]);
                    console.log("place userId: " + userId + ", place: " + place + ", onTeamId:" + onTeamId);
                    currentRef = firebase_admin_1.firestore().collection("all_matches").doc(matchId);
                    return [4 /*yield*/, currentRef.get()];
                case 1:
                    p = _a.sent();
                    placed = (p.data() || []).placed;
                    placedObject = placed || [];
                    console.log("placed : " + JSON.stringify(placedObject));
                    console.log("1placed objects data: " + JSON.stringify(p.data()));
                    newPlace = {
                        "userId": userId,
                        "place": place,
                        "onTeamId": onTeamId
                    };
                    placedObject === null || placedObject === void 0 ? void 0 : placedObject.push(newPlace);
                    finalPlaced = helpers_1.converter().toFirestore(placedObject);
                    console.log("final placed : " + JSON.stringify(finalPlaced));
                    return [4 /*yield*/, currentRef.set({
                            "placed": finalPlaced
                        }, { merge: true })];
                case 2:
                    resPlaced = _a.sent();
                    console.log("placed bet successful " + resPlaced);
                    return [4 /*yield*/, currentRef.get()];
                case 3:
                    t = _a.sent();
                    totals = (t.data() || []).totals;
                    totalsData = totals;
                    console.log("totals :" + totals);
                    totalsData === null || totalsData === void 0 ? void 0 : totalsData.forEach(function (e) {
                        if (e.on_team_id === onTeamId) {
                            console.log("totals on team before: " + e.placed_total_sum);
                            e.placed_total_sum = e.placed_total_sum + place;
                            console.log("totals on team before: " + e.placed_total_sum);
                        }
                    });
                    team1 = totalsData[0];
                    team2 = totalsData[1];
                    team1.placed_total_cof = +(team1.placed_total_sum / (team1.placed_total_sum + team2.placed_total_sum) * 100).toFixed(2);
                    team2.placed_total_cof = +(team2.placed_total_sum / (team1.placed_total_sum + team2.placed_total_sum) * 100).toFixed(2);
                    totalsData[0] = team1;
                    totalsData[1] = team2;
                    finalTotals = helpers_1.converter().toFirestore(totalsData);
                    console.log("final finalTotals : " + JSON.stringify(finalTotals));
                    return [4 /*yield*/, currentRef.set({
                            "totals": finalTotals
                        }, { merge: true })];
                case 4:
                    resTotals = _a.sent();
                    console.log("totals changes to: " + resTotals);
                    return [2 /*return*/, { "success": true, "placed": place, "for_user_id": userId }];
                case 5:
                    e_1 = _a.sent();
                    console.log(e_1);
                    return [2 /*return*/, { "success": false, "placed": place, "for_user_id": userId, "error": e_1 }];
                case 6: return [2 /*return*/];
            }
        });
    });
};
// const ttt = {
//     "totals": [
//         {
//             "on_team_id": "12",
//             "placed_total_sum": 30,
//             "placed_total_cof": 30
//         },
//         {
//             "on_team_id": "12",
//             "placed_total_sum": 30,
//             "placed_total_cof": 30
//         }
//     ]
// }
// const placed = {
//     "placed": [
//       {
//         "userId": "userId",
//         "place": 1,
//         "onTeamId": "onTeamId"
//       },
//       {
//         "userId": "userId",
//         "place": 1,
//         "onTeamId": "onTeamId"
//       }
//     ]
//   }
