use fixed_point_math::FixedPoint;
use soroban_sdk::{contract, contractimpl, token, Address, Env, Vec};

use crate::storage::{DataKey, ShareDataKey};

pub trait SplitterTrait {
    fn init(env: Env, shares: Vec<ShareDataKey>);

    fn distribute(env: Env, token_address: Address);
}

#[contract]
pub struct Splitter;

#[contractimpl]
impl SplitterTrait for Splitter {
    fn init(env: Env, shares: Vec<ShareDataKey>) {
        let mut members: Vec<Address> = Vec::new(&env);
        
        for share in shares.iter() {
            members.push_back(share.shareholder.clone());

            env.storage()
                .persistent()
                .set(&DataKey::Share(share.members), &share.share);
        }

        env.storage()
            .persistent()
            .set(&DataKey::Members, &members);
    }

    fn distribute(env: Env, token_address: Address) {
                for shareholder in members.iter() {
            let share = env
                .storage()
                .persistent()
                .get::<DataKey, i128>(&DataKey::Share(shareholder.clone()))
                .unwrap_or(0);

            let amount = balance.fixed_mul_floor(share, 10000).unwrap_or(0);

            token.transfer(&env.current_contract_address(), &shareholder, &amount);
        }

        let token = token::Client::new(&env, &token_address);

        let balance = token.balance(&env.current_contract_address());

        let members = env
            .storage()
            .persistent()
            .get::<DataKey, Vec<Address>>(&DataKey::Members)
            .unwrap_or(Vec::new(&env));
    }
}