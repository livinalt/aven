# Aven Smart Contract

This repository contains two Solidity smart contracts that work together to manage events, register users, and issue proof of attendance using NFTs. The contracts are:

1. **Aven.sol**: Manages user registration, event creation, attendance tracking, and proof of attendance minting.
2. **AvenPOA.sol**: An ERC-1155 token contract used to mint Proof of Attendance (POA) NFTs for event attendees.

## Contract Addresses

- **AvenPOA**: [0x894801D9fB0Dafb92a36951592Eb4720b535D816](https://sepolia-blockscout.lisk.com/address/0x894801D9fB0Dafb92a36951592Eb4720b535D816#code)
- **Aven**: [0x03dba7Ab94eebD491e446F386BC5f3845faEB595](https://sepolia-blockscout.lisk.com/address/0x03dba7Ab94eebD491e446F386BC5f3845faEB595#code)

---

## Overview

### 1. **Aven Contract**
The Aven contract allows users to register on the platform, create events, and track attendance. It also integrates with the AvenPOA contract to issue Proof of Attendance (POA) tokens to users who attend and complete events.

#### Key Features:
- **User Registration**: Users can register on the platform by calling `registerUser()`.
- **Event Creation**: Event creators can create events using `createEvent()` with details like title, description, start date, and duration.
- **Event Sign-up**: Users can sign up for events using `eventSignup()`.
- **Event Archive**: Events can be archived using `archiveEvent()`.
- **Proof of Attendance (POA)**: Users can receive POA tokens upon successful event completion by calling `proofOfAttendance()`.

#### Events:
- `UserRegistered`: Emitted when a user registers.
- `AttendanceProof`: Emitted when a POA token is minted.

### 2. **AvenPOA Contract**
The AvenPOA contract is an ERC-1155 token that serves as a Proof of Attendance (POA) for events. It allows the minting of NFTs to users who attended events.

#### Key Features:
- **Minting**: The contract owner can mint individual or batch NFTs using `mint()` and `mintBatch()`.
- **URI Management**: The contract owner can set the metadata URI for the NFTs.
- **Upgradeable**: The contract uses the UUPS pattern for upgradeability.

---

## How to Use

1. **Deploy AvenPOA Contract**: 
   Deploy the `AvenPOA` contract, initializing the contract with the owner's address.

2. **Deploy Aven Contract**:
   Deploy the `Aven` contract and pass the deployed `AvenPOA` contract address as a parameter to the constructor.

3. **Register Users**:
   Users can register on the platform by calling `registerUser()`.

4. **Create Events**:
   Authorized users can create events with relevant details.

5. **Attend Events**:
   Users can sign up for events using `eventSignup()`.

6. **Mint POA**:
   After the event is completed, users who attended can receive a POA by calling `proofOfAttendance()`.

---

## Dependencies

- **OpenZeppelin Contracts**: 
  - ERC-1155
  - Ownable
  - UUPSUpgradeable

Make sure to install the required OpenZeppelin contracts by running:

```bash
npm install @openzeppelin/contracts-upgradeable
```

---

## License

This project is licensed under the MIT License.