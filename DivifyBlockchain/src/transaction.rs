use soroban_sdk::{contracttype, symbol_short, Symbol};

#[derive(Clone, Debug, Eq, PartialEq)]
#[contracttype]
pub struct Transaction {
    pub uid: Symbol,
    pub send_address: Symbol,
    pub send_seed: Symbol,
    pub rec_address: Symbol,
    pub amount: u32,
    pub paid: bool,
}

impl Transaction {
    /// Creates a new default transaction.
    pub fn default() -> Self {
        Transaction {
            uid: symbol_short!("123"),
            send_address: symbol_short!("123"),
            send_seed: symbol_short!("123"),
            rec_address: symbol_short!("123"),
            amount: 123,
            paid: false,
        }
    }
}
