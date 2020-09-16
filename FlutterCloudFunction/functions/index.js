const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().functions);
var newData;
exports.messageTrigger = functions.firestore.document('ChatRoom/{roomId}').onCreate(async (snapshot, context) =>
{
    if (snapshot.empty)
    {
        console.log('No device');
        return;
    }
    var tokens = ['];
    newData = snapshot.data;
    var payload =
    {
        notification:
        {
            title: { 'push title', body: 'push body', sound: 'default' },
            data: {click_action: 'FLUTTER_NOTIFICATION_CLICK'  ,message: 'push message' }

        }
    };
    try
    {
        const response = await admin.messaging().sendToDevice(tokens, payload);
        console.log('Notification sent');
    } catch (e)
    {
        console.log('Error in Sending');
    }
});
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
