// /* eslint-disable promise/always-return */
/* eslint-disable no-eq-null */
/* eslint-disable eqeqeq */
const functions = require('firebase-functions');
const express = require('express');
// const bodyparser = require('body-parser');
const admin = require('firebase-admin');
const HttpStatus = require('http-status-codes');
const cors = require('cors');

admin.initializeApp(functions.config().firebase);

const app = express();
const loginCredentialsCheck = express();

const db = admin.firestore();

exports.webApi = functions.https.onRequest(app);
exports.loginApi = functions.https.onRequest(loginCredentialsCheck);

//To Check if user is authenticated or not
const validateFirebaseIdToken = async (req, res, next) => {
    console.log('Check if request is authorized with Firebase ID token');

    if ((!req.headers.authorization || !req.headers.authorization.startsWith('Bearer ')) &&
        !(req.cookies && req.cookies.__session)) {
        console.error('No Firebase ID token was passed as a Bearer token in the Authorization header.',
            'Make sure you authorize your request by providing the following HTTP header:',
            'Authorization: Bearer <Firebase ID Token>',
            'or by passing a "__session" cookie.');
        res.status(HttpStatus.UNAUTHORIZED).send('Unauthorized');
        return;
    }

    let idToken;
    if (req.headers.authorization && req.headers.authorization.startsWith('Bearer ')) {
        console.log('Found "Authorization" header');
        // Read the ID Token from the Authorization header.
        idToken = req.headers.authorization.split('Bearer ')[1];
    } else if (req.cookies) {
        console.log('Found "__session" cookie');
        // Read the ID Token from cookie.
        idToken = req.cookies.__session;
    } else {
        // No cookie
        res.status(HttpStatus.UNAUTHORIZED).send('Unauthorized');
        return;
    }

    try {
        const decodedIdToken = await admin.auth().verifyIdToken(idToken);
        console.log('ID Token correctly decoded', decodedIdToken);
        console.log('ID Token correctly decoded: Email', decodedIdToken.email);
        req.user = decodedIdToken;
        next();
        return;
    } catch (error) {
        console.error('Error while verifying Firebase ID token:', error);
        res.status(HttpStatus.UNAUTHORIZED).send('Unauthorized');
        return;
    }
};


// app.use(validateFirebaseIdToken);

// This HTTPS endpoint can only be accessed by your Firebase Users.
// Requests need to be authorized by providing an `Authorization` HTTP header
// with value `Bearer <Firebase ID Token>`.
// exports.app = functions.https.onRequest(app);

loginCredentialsCheck.post("/", async (req, res) => {
    try {
        // let schoolId = req.params.id;

        const { schoolId, user_email_or_mobile, loginType } = req.body;
        const data = {
            schoolId,
            user_email_or_mobile,
            loginType
        };

        var country = "India";

        // var loginUserType;

        // if (data.loginType == "S") {
        //     loginUserType = "Student";
        // } else {
        //     loginUserType = "Parent-Teacher";
        // }
        console.log("Data : " + data.loginType + " " + data.schoolId + " " + data.user_email_or_mobile);
        const schoolRef = db.collection("Schools").doc(country).collection(data.schoolId);
        const userRef = schoolRef.doc("Login").collection("Parent-Teacher");

        var schoolExists = checkIfSchoolExists(country, data);

        if (schoolExists) {
            var querySnapshot = checkIfUserExists(country, data);
            if (querySnapshot != null) {
                // var docs = querySnapshot.docs.map(doc => doc.data());
                res.status(HttpStatus.OK).send("School " + HttpStatus.getStatusText(HttpStatus.OK));
            } else {
                res.status(HttpStatus.NOT_FOUND).send("Student " + HttpStatus.getStatusText(HttpStatus.NOT_FOUND));
            }
        } else {
            res.status(HttpStatus.NOT_FOUND).send("School " + HttpStatus.getStatusText(HttpStatus.NOT_FOUND));
        }


    } catch (e) {
        res.status(HttpStatus.INTERNAL_SERVER_ERROR).send(HttpStatus.getStatusText(HttpStatus.INTERNAL_SERVER_ERROR));
    }
});

function checkIfSchoolExists(country, data) {
    // const schoolRef = db.collection("Schools").doc(schoolId);
    var ret = false;
    try {
        db.collection("Schools").doc(country).collection(data.schoolId).get()
            .then(docSnapshot => {
                console.log("Data : " + data.loginType + " " + data.schoolId + " " + data.user_email_or_mobile);
                console.log("In School Check Function " + docSnapshot.docs.length);
                if (docSnapshot.docs.length > 0) {
                    ret = true;
                    return ret;
                } else {
                    ret = false;
                    return ret;
                }
            }).catch(error => {
                console.log("error", error);
            });
        // return ret;

    } catch (e) {
        res.status(HttpStatus.INTERNAL_SERVER_ERROR).send(HttpStatus.getStatusText(HttpStatus.INTERNAL_SERVER_ERROR));
    }

    return ret;
}

function checkIfUserExists(country, data) {
    db.collection("Schools").doc(country).collection(data.schoolId).doc("Login").collection("Parent-Teacher")
        .where("email", "==", data.user_email_or_mobile).get()
        .then(docSnapshot => {
            console.log("In User Check Function " + docSnapshot.data);
            console.log("Data : " + data.loginType + " " + data.schoolId + " " + data.user_email_or_mobile);
            if (docSnapshot.exists) {
                // var doc = docSnapshot
                return docSnapshot;
            } else {
                return null;
            }
        }).catch(error => {
            console.log("error", error);
        });
    return null
}



// schoolRef.then(docSnapshot => {
//     console.log("Data : " + data.loginType + " " + data.schoolId + " " + data.user_email_or_mobile);
//     console.log("In School Check Function " + docSnapshot.size);
//     if (docSnapshot.size > 0) {
//         userRef.where("email", "==", data.user_email_or_mobile).get()
//             .then((querySnapshot) => {
//                 console.log("In User Check Function " + docSnapshot.data);
//                 console.log("Data : " + data.loginType + " " + data.schoolId + " " + data.user_email_or_mobile);
//                 if (querySnapshot.exists) {
//                     var docs = querySnapshot.docs.map(doc => doc.data());
//                     res.status(HttpStatus.OK).send("School " + HttpStatus.getStatusText(HttpStatus.OK)).end(JSON.stringify({
//                         data: docs
//                     }));
//                 } else {
//                     res.status(HttpStatus.NOT_FOUND).send("Student " + HttpStatus.getStatusText(HttpStatus.NOT_FOUND));
//                 }
//             }).catch(error => {
//                 console.log("error", error);
//             });
//     } else {
//         res.status(HttpStatus.NOT_FOUND).send("School " + HttpStatus.getStatusText(HttpStatus.NOT_FOUND));
//     }
// }).catch(error => {
//     console.log("error", error);
// })
