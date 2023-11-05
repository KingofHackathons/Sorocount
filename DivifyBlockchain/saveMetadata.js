const StellarSdk = require('stellar-sdk');
const { exec } = require('child_process');
const server = new StellarSdk.Server('https://horizon-futurenet.stellar.org');
const fs = require('fs');

// Load JSON data
var data = require('./documents/transactionData.json');

const command = `soroban contract invoke --id $(cat .soroban/contract.txt) --source alice --network futurenet -- user_modify --uid ${data.uid} --send_address_1 ${data.send_address_1} --send_address_2 ${data.send_address_2} --send_seed_1 ${data.send_seed_1} --send_seed_2 ${data.send_seed_2} --rec_address_1 ${data.rec_address_1} --rec_address_2 ${data.rec_address_2} --amount ${data.amount} --paid false`;

exec(command, (error, stdout, stderr) => {
    if (error) {
        console.error(`exec error: ${error}`);
        return;
    }
    console.log(`stdout: ${stdout}`);
});