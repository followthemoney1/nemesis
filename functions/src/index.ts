import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

import * as bets from "./bets";


// const serviceAccount = require('../service-key.json');

// admin.initializeApp({
//     credential: admin.credential.cert(serviceAccount),
//     databaseURL: "https://nemesis-b1957.firebaseio.com"
// });
admin.initializeApp();

export const placeABet = functions.https.onRequest(async (req, res) => {
    res.set('Access-Control-Allow-Origin', '*');
    res.set("Access-Control-Allow-Headers", "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale");
    res.set("Access-Control-Allow-Methods", "POST, OPTIONS,GET");

    console.log(req.body);
    const { userId, place, matchId, onTeamId } = req.body;
    const r = await bets.placeABet(userId, +place, matchId, onTeamId);
    console.log(`return response: ${r}`);


    res.send(r);

});

