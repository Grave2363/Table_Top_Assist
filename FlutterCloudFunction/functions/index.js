const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().functions);


exports.PersonalMessaging = functions.firestore.document('ChatRoom/{roomId}/Chat/{docId}').onCreate(async (snapshot, context) => {
    var newData;

    if (snapshot.empty) {
        console.log('No Devices');
        return;
    }

    newData = snapshot.data();

    const deviceIdTokens = await admin
        .firestore()
        .collection('ChatRoom/{roomId}/Chat')
        .get();

    var tokens = [];

    for (var token of deviceIdTokens.docs) {
        tokens.push(token.data().sender_Id);
    }
    var payload = {
        notification: {
            title: newData.sender,
            body: newData.message,
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



exports.General = functions.firestore.document('Notification/{notificationId}').onCreate(async (snapshot, context) => {
    var newData;

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
            title: newData.Title,
            body: newData.Notification,
            sound: 'default',
        },
        data: {
            push_key: 'Push Key Value',
            key1: newData.Notification,
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
