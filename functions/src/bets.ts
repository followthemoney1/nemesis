
// import * as functions from "firebase-functions";
// import * as admin from "firebase-admin";
import { firestore } from "firebase-admin";
import { converter } from './helpers';

import { Placed, Total } from "./data/placed";
// import { TotalBets } from "./data/total_bets_data";


export const placeABet = async function place(userId: string,
    place: number,
    matchId: string,
    onTeamId: string) : Promise<any>{
    try {
        console.log(`place userId: ${userId}, place: ${place}, onTeamId:${onTeamId}`);

        const currentRef = firestore().collection("all_matches").doc(matchId);
        const p = await currentRef.get();
        const { placed } = p.data() || [];
        const placedObject = placed as Placed[] || [];

        console.log(`placed : ${JSON.stringify(placedObject)}`)
        console.log(`1placed objects data: ${JSON.stringify(p.data())}`);

        const newPlace = {
            "userId": userId,
            "place": place,
            "onTeamId": onTeamId
        };
        placedObject?.push(newPlace);
        const finalPlaced = converter<Placed[]>().toFirestore(placedObject!);
        console.log(`final placed : ${JSON.stringify(finalPlaced)}`);

        const resPlaced = await currentRef.set({
            "placed": finalPlaced
        }, { merge: true });
        console.log(`placed bet successful ${resPlaced}`);

        /// //placed totals // ///

        const t = await currentRef.get();
        const { totals } = t.data() || [];
        const totalsData = totals as Total[];

        console.log(`totals :${totals}`);
        totalsData?.forEach((e) => {
            if (e.on_team_id === onTeamId) {
                console.log(`totals on team before: ${e.placed_total_sum}`);
                e.placed_total_sum = e.placed_total_sum + place;
                console.log(`totals on team before: ${e.placed_total_sum}`);
            }
        });


        //procent totals
        //(number_one / number_two) * 100
        //7/(7+8) * 100
        const team1 = totalsData[0];
        const team2 = totalsData[1];

        const tt = (team1.placed_total_sum + team2.placed_total_sum);
        team1.placed_total_cof = +(team1.placed_total_sum/tt * 100).toFixed(2);
        team2.placed_total_cof = +(team2.placed_total_sum/tt * 100).toFixed(2);

        if(team1.placed_total_cof>100){
            team1.placed_total_cof = 100;
        }
        if(team1.placed_total_cof<=-1){
            team1.placed_total_cof=0;
        }

        if(team2.placed_total_cof>100){
            team2.placed_total_cof = 100;
        }
        if(team2.placed_total_cof<=-1){
            team2.placed_total_cof=0;
        }

        totalsData[0] = team1;
        totalsData[1] = team2;
        const finalTotals = converter<Total[]>().toFirestore(totalsData!);
        console.log(`final finalTotals : ${JSON.stringify(finalTotals)}`);

        const resTotals = await currentRef.set({
            "totals": finalTotals
        }, { merge: true });
        console.log(`totals changes to: ${resTotals}`);
        return { "success": true, "placed": place, "for_user_id": userId };
    } catch (e) {
        console.log(e);
        return { "success": false, "placed": place, "for_user_id": userId, "error": e };
    }
}

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

