// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./AvenPOA.sol";

contract Aven2 {

    address owner;
    AvenPOA public avenPOA;  // Reference to the AvenPOA contract

    struct User {
        uint256 id;
        address userAddress;
        bool isRegistered; // checks if the user is registered on the platform
    }

    User[] public allUsers;
    mapping(address => User) hasRegistered;
    mapping(uint256 => User) registeredUserID;

    struct Program {
        uint256 id;
        string title;
        string desc;
        uint256 startDate;
        uint256 startTime;
        uint256 closeDate;
        uint256 duration;
        bool isActive;
        address creator;
    }

    Program[] public allPrograms;
    Program[] public archivePrograms;

    mapping(uint256 => bool) isArchived;
    mapping(uint256 => Program) registeredPrograms;
    mapping(string => Program) programsTitle;
    mapping(uint256 => address[]) programAttendees;
    mapping(uint256 => Program[]) archivedPrograms;
    mapping(uint256 => bool) programCompleted;

    constructor(address _avenPOA) {
        owner = msg.sender;
        avenPOA = AvenPOA(_avenPOA);  // Set AvenPOA contract address on deployment
    }

    function registerUser() external {
        uint256 id = allUsers.length + 1;
        User memory newUser = User(id, msg.sender, false);
        allUsers.push(newUser);
    }

    function createEvent(
        string memory _title, 
        string memory _desc, 
        uint256 _startDate, 
        uint256 _startTime, 
        uint256 _closeDate, 
        uint256 _duration
    ) external {
        uint256 id = allPrograms.length + 1;
        uint256 startDate = block.timestamp + _startDate;
        uint256 startTime = block.timestamp + _startTime;
        uint256 closeDate = block.timestamp + _closeDate;

        Program memory newProgram = Program(id, _title, _desc, startDate, startTime, closeDate, _duration, true, msg.sender);
        allPrograms.push(newProgram);
    }

    // User signup for event
    function eventSignup(uint256 id) external {
        programAttendees[id].push(msg.sender);
    }

    function archiveEvent(uint256 id) external {
        Program memory selectedProgram = allPrograms[id];
        archivePrograms.push(selectedProgram);
    }

    function removeEvent(uint256 id) external {
        delete allPrograms[id];
    }

    function searchEvent(uint256 id, string memory _title) external view returns (Program memory) {
        if (id > 0 && id < allPrograms.length) {
            return allPrograms[id];
        } else if (bytes(_title).length > 0) {
            return programsTitle[_title];
        }
    }

    function getUser(uint256 id) external view returns (User memory) {
        return registeredUserID[id];
    }

    // Mint proof of attendance on event completion
    function proofOfAttendance(uint256 id) external {
        require(id > 0 && id < allPrograms.length, "Invalid event ID");
        require(programCompleted[id] == true, "Event is still ongoing");

        bool isAttendee = false;
        for (uint256 i = 0; i < programAttendees[id].length; i++) {
            if (programAttendees[id][i] == msg.sender) {
                isAttendee = true;
                break;
            }
        }

        require(isAttendee, "You did not attend this event");

        // Mint Proof of Attendance (POA) to the user
        avenPOA.mint(msg.sender, id, 1, "");
    }
}
