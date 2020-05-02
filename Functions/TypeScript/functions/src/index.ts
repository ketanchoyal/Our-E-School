import * as functions from 'firebase-functions';
import * as express from 'express';
import * as admin from 'firebase-admin';
import * as HttpStatus from 'http-status-codes';
import * as Firestoree from '@google-cloud/firestore';
import { UserType } from './UserType';
import * as atomicFunction from './Functions';

interface IUserRequest extends express.Request {
    user: any
}

admin.initializeApp(functions.config().firebase);

const app = express();
// const loginCredentialsCheck = express();

export const db = admin.firestore();

export const autoStudentParentEntry = functions.firestore.document('Schools/{country}/{schoolCode}/Profile/Student/{studentId}').onWrite(async (eventSnapshot, context) => {
    return atomicFunction.studentParentAutoEntry(eventSnapshot, context);
});

export const autoTeacherEntry = functions.firestore.document('Schools/{country}/{schoolCode}/Profile/Parent-Teacher/{teacherId}').onWrite(async (eventSnapshot, context) => {
    return atomicFunction.teacherAutoEntry(eventSnapshot, context);
});

export const autoMessageIdEntry = functions.firestore.document('/Schools/{country}/{schoolCode}/Chats/{standard}/Chat/{chatId}/{messageId}').onCreate(async (eventSnapshot, context) => {
    return atomicFunction.messageIdAutoEntry(eventSnapshot, context);
});

exports.webApi = functions.https.onRequest(app);
// exports.loginApi = functions.https.onRequest(loginCredentialsCheck);

//To Check if user is authenticated or not
// @ts-ignore
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

//To add Profile data
app.post('/profileupdate', async (req: express.Request, res: express.Response) => {
    try {
        // console.log("code" + req.body.schoolCode);
        console.log('In Try');
        const {
            schoolCode,
            profileData,
            userType,
            country } = req.body;

        const data = {
            schoolCode,
            profileData,
            userType,
            country
        }
        // console.log('Here');

        // console.log(data.country);
        // console.log(data.userType);
        // console.log(data.country);

        const profileDataMap = data.profileData as Map<String, any>;
        const id = data.profileData.id;
        // console.log(id);

        const ref = await getProfileRef(data.schoolCode, data.country, data.userType, id);
        await ref.set(profileDataMap, { merge: true }).then((success) => {
            res.status(HttpStatus.OK).send(profileData);
        }, (failure) => {
            res.status(HttpStatus.BAD_REQUEST).send('Failure : ' + HttpStatus.getStatusText(HttpStatus.BAD_REQUEST));
        });

        // res.status(HttpStatus.OK).send("Profile Updated " + HttpStatus.getStatusText(HttpStatus.OK));

    } catch (e) {
        res.status(HttpStatus.INTERNAL_SERVER_ERROR).send(HttpStatus.getStatusText(HttpStatus.INTERNAL_SERVER_ERROR));
    }
});

//Method to get User Data
//get methid not working so post is used
app.post('/userdata', async (req: express.Request, res: express.Response) => {
    try {
        // console.log("In User data code :" + req.body.schoolCode);
        // console.log('In Try');
        const {
            schoolCode,
            id,
            userType,
            country } = req.body;

        const data = {
            schoolCode,
            id,
            userType,
            country
        }
        // console.log('Here');

        // console.log(id);

        const ref = await getProfileRef(data.schoolCode, data.country, data.userType, data.id);
        await ref.get().then((documentSnapshot) => {
            // console.log('JSON Data : ');
            var inJsonFormat = Object.assign(documentSnapshot.data(), { id: documentSnapshot.id });
            // console.log(inJsonFormat);
            // console.log('Data : '+ documentSnapshot);
            // console.log('Data2 : '+ documentSnapshot.data);
            res.status(HttpStatus.OK).send(inJsonFormat);
        }, (onFailure) => {
            res.status(HttpStatus.NOT_FOUND).send(HttpStatus.getStatusText(HttpStatus.NOT_FOUND));
        });

        // res.status(HttpStatus.OK).send("User Data Received " + HttpStatus.getStatusText(HttpStatus.OK));

    } catch (e) {
        res.status(HttpStatus.INTERNAL_SERVER_ERROR).send(HttpStatus.getStatusText(HttpStatus.INTERNAL_SERVER_ERROR));
    }
});

export function _getSchoolRef(schoolCode: string, country: string): Firestoree.CollectionReference {
    return db.collection('Schools').doc(country).collection(schoolCode);
}

export async function getProfileRef(schoolCode: string, country: string, userType: string, id: string): Promise<Firestoree.DocumentReference> {
    const _profileRef = _getSchoolRef(schoolCode, country).doc('Profile');
    let res: Firestoree.DocumentReference;
    if (userType == UserType.STUDENT) {
        res = await _profileRef.collection('Student').doc(id);
    } else
        if (userType == UserType.TEACHER || userType == UserType.PARENT) {
            res = await _profileRef.collection('Parent-Teacher').doc(id);
        } else {
            res = await _profileRef.collection('Unknown').doc(id);
            res.get;
        }
    return res;
}

app.post('/postAnnouncement', async (req: express.Request, res: express.Response) => {
    try {
        // console.log('in Post Announcement Function');
        const {
            announcement,
            schoolCode,
            country } = req.body;

        const data = {
            announcement,
            schoolCode,
            country
        }

        // console.log('below data');

        let announcementMap = data.announcement;
        announcementMap = Object.assign(announcementMap, { timeStamp: Firestoree.Timestamp.now() });

        const std = data.announcement.forClass == 'Global' ? 'Global' : data.announcement.forClass + data.announcement.forDiv;

        console.log(data.schoolCode + " " + data.announcement.forClass + " " + data.announcement.forDiv + " " + data.country);

        const _announcementRef = db.collection("Schools").doc(data.country).collection(data.schoolCode).doc("Posts").collection(std);

        await _announcementRef.add(announcementMap).then((success) => {
            success.get().then((documentSnapshot) => {
                var inJsonFormat = Object.assign(documentSnapshot.data(), { id: documentSnapshot.id });
                res.status(HttpStatus.OK).json(inJsonFormat);
            }, (failure) => {
                res.status(HttpStatus.BAD_REQUEST).send('Failure : ' + HttpStatus.getStatusText(HttpStatus.BAD_REQUEST));
            });
        }, (failure) => {
            res.status(HttpStatus.BAD_REQUEST).send('Failure : ' + HttpStatus.getStatusText(HttpStatus.BAD_REQUEST));
        });
    }
    catch (e) {
        res.status(HttpStatus.INTERNAL_SERVER_ERROR).send(HttpStatus.getStatusText(HttpStatus.INTERNAL_SERVER_ERROR));
    }
});

app.post('/addAssignment', async (req: express.Request, res: express.Response) => {
    try {
        // console.log('in add Assignment Function');
        const {
            assignment,
            schoolCode,
            country } = req.body;

        const data = {
            assignment,
            schoolCode,
            country
        }

        // console.log('below data');

        let assignmemtMap = data.assignment;
        assignmemtMap = Object.assign(assignmemtMap, { timeStamp: Firestoree.Timestamp.now() });

        const std = data.assignment.standard == 'Global' ? 'Global' : data.assignment.standard + data.assignment.div;

        // console.log(data.schoolCode + " " + data.assignment.standard + " " + data.assignment.div + " " + data.country);

        const _announcementRef = db.collection("Schools").doc(data.country).collection(data.schoolCode).doc("Assignments").collection(std);

        await _announcementRef.add(assignmemtMap).then((success) => {
            success.get().then((documentSnapshot) => {
                var inJsonFormat = Object.assign(documentSnapshot.data(), { id: documentSnapshot.id });
                res.status(HttpStatus.OK).json(inJsonFormat);
            }, (failure) => {
                res.status(HttpStatus.BAD_REQUEST).send('Failure : ' + HttpStatus.getStatusText(HttpStatus.BAD_REQUEST));
            });
        }, (failure) => {
            res.status(HttpStatus.BAD_REQUEST).send('Failure : ' + HttpStatus.getStatusText(HttpStatus.BAD_REQUEST));
        });
    }
    catch (e) {
        res.status(HttpStatus.INTERNAL_SERVER_ERROR).send(HttpStatus.getStatusText(HttpStatus.INTERNAL_SERVER_ERROR));
    }
});

app.get('/jsonModel', async (req: express.Request, res: express.Response) => {
    try {
        db.collection("Schools").doc("India").collection("AMBE001").doc("Login").collection("Student").doc("5YBx4YxiQoVQNsKhtj1P").get().then((success) => {
            var inJson = Object.assign(success.data(), { id: success.id });
            res.status(HttpStatus.OK).json(inJson);
        }, (failure) => {
            res.status(HttpStatus.BAD_REQUEST).send('Failure : ' + HttpStatus.getStatusText(HttpStatus.BAD_REQUEST));
        });
    }
    catch (e) {
        res.status(HttpStatus.INTERNAL_SERVER_ERROR).send(HttpStatus.getStatusText(HttpStatus.INTERNAL_SERVER_ERROR));
    }
});

