var admin = require("firebase-admin");
var fs = require('fs');

var serviceAccount = require("./service-account/divify-37c8e-firebase-adminsdk-wskkr-3c40a8c178.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

var db = admin.firestore();
var usersCollection = db.collection('users');

var data = require('./documents/filteredPayments.json');

usersCollection.doc(data.lastPayment).get().then((doc) => {
  if (doc.exists) {
    var publicKey = doc.data().publicKey;
    console.log('publicKey:', publicKey);
    var splitPublicKey = splitAddress(publicKey);
    updateTransactionData('rec', splitPublicKey); 
  } else {
    console.log('No such document!');
  }
}).catch((error) => {
  console.log('Error getting document:', error);
});

usersCollection.doc(data.uid).get().then((doc) => {
  if (doc.exists) {
    var publicKey = doc.data().publicKey;
    var secretSeed = doc.data().secretSeed;
    console.log('publicKey:', publicKey);
    console.log('secretSeed:', secretSeed);
    var splitPublicKey = splitAddress(publicKey);
    var splitSecretSeed = splitAddress(secretSeed);
    updateTransactionData('send', splitPublicKey, splitSecretSeed);
  } else {
    console.log('No such document!');
  }
}).catch((error) => {
  console.log('Error getting document:', error);
});

console.log('hasPaid:', data.hasPaid);

function splitAddress(address) {
  return address.length > 32 ? [address.substring(0, 32), address.substring(32)] : [address, ''];
}

function updateTransactionData(prefix, publicKey, secretSeed) {
  var transactionData = require('./documents/transactionData.json');
  transactionData[prefix + '_address_1'] = publicKey[0];
  transactionData[prefix + '_address_2'] = publicKey[1];
  if (secretSeed) {
    transactionData[prefix + '_seed_1'] = secretSeed[0];
    transactionData[prefix + '_seed_2'] = secretSeed[1];
  }
  fs.writeFileSync('./documents/transactionData.json', JSON.stringify(transactionData, null, 2));
}