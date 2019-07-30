import { UserType } from './UserType';
import { getProfileRef, db } from './index';

export async function studentParentAutoEntry(eventSnapshot: any, context: any) {

    const schoolCode = context.params.schoolCode;
    const studentId = context.params.studentId;
    const country = context.params.country;

    // console.log(schoolCode);
    // console.log(studentId);

    const newValue = eventSnapshot.after!.data();
    const studentProfileRef = eventSnapshot.after.ref;

    const standard = newValue!.standard;
    const division = newValue!.division;

    // console.log(newValue);

    var inJsonFormat = Object.assign(newValue, { id: newValue!.id });

    // console.log(inJsonFormat);

    const connections = inJsonFormat.connection != null ? inJsonFormat.connection as Map<String, any> : null;

    if (connections != null) {

        let connectionsArray = [];
        for (const connection in connections) {
            connectionsArray.push((connections as any)[connection]);
        }
        // console.log(connectionsArray);
        console.log(connectionsArray.length);

        connectionsArray.forEach(async (value) => {
            var connectionProfileRef = await getProfileRef(schoolCode, country, UserType.PARENT, value);

            const connectionMap = {
                id: connectionProfileRef,
            }
            await db.collection('Schools').doc(country).collection(schoolCode).doc('Parents').collection(standard + division).doc(value).set(connectionMap, { merge: true });
        });
    }

    const map = {
        id: studentProfileRef,
    }

    return await db.collection('Schools').doc(country).collection(schoolCode).doc('Students').collection(standard + division).doc(studentId).set(map, { merge: true });
}

export async function teacherAutoEntry(eventSnapshot: any, context: any) {

    const schoolCode = context.params.schoolCode;
    const teacherId = context.params.teacherId;
    const country = context.params.country;

    // console.log(schoolCode);
    // console.log(studentId);

    const newValue = eventSnapshot.after!.data();
    const teacherProfileRef = eventSnapshot.after.ref;

    const isTeacher = newValue!.isTeacher as boolean;

    if (isTeacher) {
        const standard = newValue!.standard;
        const division = newValue!.division;

        const map = {
            id: teacherProfileRef,
        }

        return await db.collection('Schools').doc(country).collection(schoolCode).doc('Teachers').collection(standard + division).doc(teacherId).set(map, { merge: true });
    } else {
        return;
    }


}