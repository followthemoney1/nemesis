import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

import * as bets from "./bets";


const serviceAccount = require('../service-key.json');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://nemesis-b1957.firebaseio.com"
});

export const placeABet = functions.https.onRequest(async (req, res) => {
    console.log(req.body);
    const { userId, place, matchId,onTeamId } = req.body;
    const r = await bets.placeABet(userId, +place, matchId,onTeamId);
    res.send(r);
});

