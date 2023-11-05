

# SoroCount - Splitting Expenses Simplified and Decentralized

## Summary 
SoroCount  is an iOS app that manages expense splitting and expense settlement with the power of Soroban. A user can interface with the clean and simple UI to register and create expense groups, add new members, and, obviously, add expenses. When a member is added to an expense group, a Soroban smart contract to log their current Stellar wallet and how much they owe is created and trigger a payment to a destination address. This provides a unique way of managing your real-world payments, while settling them using DeFi.


## Goal & Solution 
SoroCount was created with the following problems in mind: 
* Existing expense splitting apps are symbolic, as in they just list the amount each person owes to each other, but don't provide an easy way to settle said payments in the app
* Such apps also incentivise transactions through centralized means such as legacy banks/PayPal/CashApp
* State/event management as to whether a person has paid off their outstanding share, etc. is not being kept track of, and there's no way to know that a person actually paid the specified amount.

SoroCount  comes in to solve all of these problems, as it aims to become an App that 1. keeps track of expenses accurately 2. stores the states/events of expenses in Soroban smart contracts and 3. executes the payments necessary to settle the expenses.

## Workflow
### User Experience
When a user downloads the app, they're prompted to either sign up or log in. Thereafter, they are able to customize their profile, add their Stellar wallet, and create groups to manage their expenses. They can also be added to groups by other members based on their internal user IDs that are retrievable from the settings. Once the necessary data is set up, groups can add new expenses, and then settle them with the tap of a button via SoroCount , which then interacts with the respective Google Firestore Database and the Rust/JS backend.

### System Design
The workflow of SoroCount  entails 3 parts: iOS Frontend, Firebase, Rust/JS Backend. Firebase acts as the funnel between the other remaining parts of SoroCount , as the iOS frontend provides a clean interface to login/sign up, create groups, add group members, add expenses, set your internal Stellar addresses, etc. in order to be able to settle payments between other group members. On the other side of the tech stack, when a user gets added to a group, a smart contract governing their expenses with respect to that group is created, this ensures that when said user wishes to settle a payment, no time is wasted on the backend in order set up a smart contract, handle contract IDs, etc. 

Once a user wishes to settle a payment, a series of Soroban CLI commands are then implemented in order to manage the event/state and execute the necessary payment if all necessary conditions, such as the existance of a valid address, sufficient balance, etc. are met.

## Limitations
In it's current state, SoroCount  is not able to execute payments in the same ledger as the state management, as with the Soroban SDK `20.0.0-rc1` update, the contract ID for the native XLM token has expired, rendering me unable to execute any token transfers through the Soroban CLI, instead, the Soroban CLI and the smart contract handles the state management and event handling for every member that is part of an "expense group" (one of the members of a group with shared expenses).

Another limitation is yet the lack of transparency within the app. Although in future development, the app is an MVP (minimum viable product) that ensures that all functionalities of the app work as intended, however, it's only a matter of time until missing funcionalities are added.

## Tech Stack
Frontend: iOS (SwiftUI, Google Firebase) for the clean UI that interacts with Firebase and the Soroban smart contract
Backend: Rust (Soroban SDK), JavaScript (Google Firebase) for the event handler smart contract and Firebase backend management

Frontend and backend were connected via Google Firebase, as real-time changes in the database were picked up and resulted in respective function calls.

### MIT License
Copyright (c) 2023 Artemiy Malyshau

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so.

See the LICENSE file for details.
