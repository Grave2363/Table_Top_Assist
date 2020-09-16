const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().functions);

var newData;

exports.myTrigger = functions.firestore.document('ChatRoom/{roomId}').onCreate(async (snapshot, context) => {
    //

    if (snapshot.empty) {
        console.log('No Devices');
        return;
    }

    newData = snapshot.data();

    const deviceIdTokens = await admin
        .firestore()
        .collection('Users')
        .get();

    var tokens = [];

    for (var token of deviceIdTokens.docs) {
        tokens.push(token.data().DeviceId);
    }
    var payload = {
        notification: {
            title: 'Push Title',
            body: 'Push Body',
            sound: 'default',
        },
        data: {
            push_key: 'Push Key Value',
            key1: newData.data,
        },
    };

    try {
        const response = await admin.messaging().sendToDevice(tokens, payload);
        console.log('Notification sent successfully');
    } catch (err) {
        console.log(err);
    }
});
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
