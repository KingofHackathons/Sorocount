const StellarSdk = require('stellar-sdk');
const { exec } = require('child_process');
const server = new StellarSdk.Server('https://horizon-futurenet.stellar.org');

exec('soroban contract invoke --id $(cat .soroban/contract.txt) --source alice --network futurenet -- get_tx', async (error, stdout, stderr) => {
    if (error) {
        console.error(`exec error: ${error}`);
        return;
    }

    // Parse JSON
    console.log(`stdout: ${stdout}`)
    const data = JSON.parse(stdout);

    // Concatenate the split inputs
    const send_address = data.send_address_1 + data.send_address_2;
    const send_seed = data.send_seed_1 + data.send_seed_2;
    const rec_address = data.rec_address_1 + data.rec_address_2;
    const amount = data.amount.toString();

    const account = await server.loadAccount(send_address);
    const fee = await server.fetchBaseFee();

    // Use data in transaction
    const transaction = new StellarSdk.TransactionBuilder(account, { fee, networkPassphrase: "Test SDF Future Network ; October 2022" })
        .addOperation(
            StellarSdk.Operation.payment({
                destination: rec_address,
                asset: StellarSdk.Asset.native(),
                amount: amount
            })
        )
        .setTimeout(30)
        .build();

    // sign transaction
    transaction.sign(StellarSdk.Keypair.fromSecret(send_seed));

    try {
        const transactionResult = await server.submitTransaction(transaction);
        console.log(transactionResult);

        const command = `soroban contract invoke --id $(cat .soroban/contract.txt) --source alice --network futurenet -- user_modify --uid ${data.uid} --send_address_1 ${data.send_address_1} --send_address_2 ${data.send_address_2} --send_seed_1 ${data.send_seed_1} --send_seed_2 ${data.send_seed_2} --rec_address_1 ${data.rec_address_1} --rec_address_2 ${data.rec_address_2} --amount ${amount} --paid true`;
        exec(command, (error, stdout, stderr) => {
            if (error) {
                console.error(`exec error: ${error}`);
                return;
            }
            console.log(`stdout: ${stdout}`);
        });
    } catch (err) {
        console.error(err);
    }
});