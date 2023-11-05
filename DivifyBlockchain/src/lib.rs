#![no_std]
use soroban_sdk::{contract, contractimpl, contracttype, symbol_short, Env, Symbol};

#[contracttype]
#[derive(Clone, Debug, Eq, PartialEq)]
pub struct Transaction {
    pub uid: Symbol,
    pub send_address_1: Symbol,
    pub send_address_2: Symbol,
    pub send_seed_1: Symbol,
    pub send_seed_2: Symbol,
    pub rec_address_1: Symbol,
    pub rec_address_2: Symbol,
    pub amount: u32,
    pub paid: bool,
}

const TX: Symbol = symbol_short!("TX");

#[contract]
pub struct DivifyContract;

#[contractimpl]
impl DivifyContract {

    pub fn user_modify(env: Env, uid: Symbol, send_address_1: Symbol, 
        send_address_2: Symbol, send_seed_1: Symbol, send_seed_2: Symbol, 
        rec_address_1: Symbol, rec_address_2: Symbol, amount: u32, paid: bool) -> Symbol {

        let mut tx = Self::get_tx(env.clone());
        tx.uid = uid;
        tx.send_address_1 = send_address_1;
        tx.send_address_2 = send_address_2;
        tx.send_seed_1 = send_seed_1;
        tx.send_seed_2 = send_seed_2;
        tx.rec_address_1 = rec_address_1;
        tx.rec_address_2 = rec_address_2;
        tx.amount = amount;
        tx.paid = paid;

        env.storage().instance().set(&TX, &tx);

        tx.uid
    }

    pub fn get_tx(env: Env) -> Transaction {
        let tx = Transaction {
            uid: symbol_short!("123"),
            send_address_1: symbol_short!("123"),
            send_address_2: symbol_short!("123"),
            send_seed_1: symbol_short!("123"),
            send_seed_2: symbol_short!("123"),
            rec_address_1: symbol_short!("123"),
            rec_address_2: symbol_short!("123"),
            amount: 123,
            paid: false,
        };
        env.storage().instance().get(&TX).unwrap_or(tx) 
    }

}

#[cfg(test)]
mod test;