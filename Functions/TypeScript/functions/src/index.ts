import * as functions from 'firebase-functions';
import * as express from 'express';
import * as admin from 'firebase-admin';
import * as HttpStatus from 'http-status-codes';
// import { QuerySnapshot } from '@google-cloud/firestore';
// import * as bodyparser from 'body-parser';

interface IUserRequest extends express.Request {
    user: any
}

admin.initializeApp(functions.config().firebase);

const app = express();
const loginCredentialsCheck = express();

const db = admin.firestore();

exports.webApi = functions.https.onRequest(app);
exports.loginApi = functions.https.onRequest(loginCredentialsCheck);

//To Check if user is authenticated or not
const validateFirebaseIdToken = async (req: express.Request, res: express.Response, next: express.NextFunction) => {
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

    var idToken;
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
        var requestWrapper: IUserRequest = <IUserRequest>req;
        requestWrapper.user = decodedIdToken;
        next();
        return;
    } catch (error) {
        console.error('Error while verifying Firebase ID token:', error);
        res.status(HttpStatus.UNAUTHORIZED).send('Unauthorized');
        return;
    }
};

app.use(validateFirebaseIdToken);
// This HTTPS endpoint can only be accessed by your Firebase Users.
// Requests need to be authorized by providing an `Authorization` HTTP header
// with value `Bearer <Firebase ID Token>`.
// exports.app = functions.https.onRequest(app);

loginCredentialsCheck.post('/', async (req: express.Request, res: express.Response) => {
    try {
        // let schoolId = req.params.id;

        const { schoolId, user_email_or_mobile, loginType } = req.body;
        const data = {
            schoolId,
            user_email_or_mobile,
            loginType
        };

        const country = "India";

        // let loginUserType;

        // if (data.loginType == "S") {
        //     loginUserType = "Student";
        // } else {
        //     loginUserType = "Parent-Teacher";
        // }
        console.log("Data : " + data.loginType + " " + data.schoolId + " " + data.user_email_or_mobile);
        // const schoolRef = db.collection("Schools").doc(country).collection(data.schoolId);
        // const userRef = schoolRef.doc("Login").collection("Parent-Teacher");

        const schoolExists = checkIfSchoolExists(country, data);

        if (schoolExists !== null) {
            const querySnapshot = await checkIfUserExists(country, data);
            if (querySnapshot !== null) {
                // let docs = querySnapshot.docs.map(doc => doc.data());
                res.status(HttpStatus.OK).send("User Found " + HttpStatus.getStatusText(HttpStatus.OK));
            } else {
                res.status(HttpStatus.NOT_FOUND).send("User " + HttpStatus.getStatusText(HttpStatus.NOT_FOUND));
            }
        } else {
            res.status(HttpStatus.NOT_FOUND).send("School " + HttpStatus.getStatusText(HttpStatus.NOT_FOUND));
        }


    } catch (e) {
        res.status(HttpStatus.INTERNAL_SERVER_ERROR).send(HttpStatus.getStatusText(HttpStatus.INTERNAL_SERVER_ERROR));
    }
});

function checkIfSchoolExists(country: string, data: any): any {
    // const schoolRef = db.collection("Schools").doc(schoolId);
    let ret : any = null;
    try {
        db.collection("Schools").doc(country).collection(data.schoolId).get()
            .then(docSnapshot => {
                console.log("Data : " + data.loginType + " " + data.schoolId + " " + data.user_email_or_mobile);
                console.log("In School Check Function " + docSnapshot.docs.toString);
                if (docSnapshot.docs.length > 0) {
                    ret = docSnapshot;
                } else {
                    ret = null;
                }
            }).catch(error => {
                console.log("error", error);
            });
        // return ret;

    } catch (e) {
        console.log("error", e);
    }

    return ret;
}

function checkIfUserExists(country: string, data: any): any {
    let ret: any = null;
    db.collection("Schools").doc(country).collection(data.schoolId).doc("Login").collection("Parent-Teacher")
        .where("email", "==", data.user_email_or_mobile).get()
        .then(docSnapshot => {
            console.log("In User Check Function " + docSnapshot.docs.toString);
            console.log("Data : " + data.loginType + " " + data.schoolId + " " + data.user_email_or_mobile);
            if (!docSnapshot.empty) {
                // let doc = docSnapshot
                ret = docSnapshot;
            } else {
                ret = null;
            }
        }).catch(error => {
            console.log("error", error);
        });
    return ret
}