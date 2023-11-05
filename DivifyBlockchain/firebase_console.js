var admin = require("firebase-admin");
var fs = require('fs');

var serviceAccount = require("./service-account/divify-37c8e-firebase-adminsdk-wskkr-3c40a8c178.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

var db = admin.firestore();
var groupsCollection = db.collection('groups');

groupsCollection.onSnapshot(snapshot => {
    snapshot.docChanges().forEach(change => {
        if (change.type === 'added') {
            console.log('New Group: ', change.doc.data());
        }
        if (change.type === 'modified') {
            console.log('Modified Group: ', change.doc.data());
        }
        if (change.type === 'removed') {
            console.log('Removed Group: ', change.doc.data());
        }

        // Accessing the 'members' collection of the current group
        let membersCollection = change.doc.ref.collection('members');
        membersCollection.onSnapshot(memberSnapshot => {
            console.log("\nMembers\n");
            memberSnapshot.docChanges().forEach(memberChange => {
                console.log(memberChange.doc.id, '=>', memberChange.doc.data());
            });
        });

        // Accessing the 'payments' collection of the current group
        let paymentsCollection = change.doc.ref.collection('payments');
        let filteredPayments = {}; 
        
        paymentsCollection.onSnapshot(paymentSnapshot => {
            console.log("\nPayments\n");
            paymentSnapshot.docChanges().forEach(paymentChange => {
                const paymentData = paymentChange.doc.data();
                console.log(paymentChange.doc.id, '=>', paymentData);
        
                if (paymentChange.type === 'modified' && paymentData.triggered && paymentData.lastPayment !== '') {
                    console.log('Triggered field has changed and lastPayment is not empty for: ', paymentChange.doc.id);
                    filteredPayments[paymentChange.doc.id] = paymentData;
                }
            });
        
            fs.writeFile('filteredPayments.json', JSON.stringify(filteredPayments, null, 2), (err) => {
                if (err) throw err;
                console.log('Data written to file');
            });
        });
    });
}, error => {
    console.error("Error fetching groups: ", error);
});