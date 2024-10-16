// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FitnessClubRewards {

    address public owner;

    struct Member {
        uint256 rewards;
        bool exists;
    }

    mapping(address => Member) public members;

    event RewardsAdded(address indexed member, uint256 amount);
    event RewardsRedeemed(address indexed member, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    modifier onlyMember() {
        require(members[msg.sender].exists, "You are not a member");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addMember(address _member) public onlyOwner {
        require(!members[_member].exists, "Member already exists");
        members[_member] = Member(0, true);
    }

    function addRewards(address _member, uint256 _amount) public onlyOwner {
        require(members[_member].exists, "Member does not exist");
        members[_member].rewards += _amount;
        emit RewardsAdded(_member, _amount);
    }

    function redeemRewards(uint256 _amount) public onlyMember {
        require(members[msg.sender].rewards >= _amount, "Insufficient rewards");
        members[msg.sender].rewards -= _amount;
        emit RewardsRedeemed(msg.sender, _amount);
    }

    function checkRewards() public view onlyMember returns (uint256) {
        return members[msg.sender].rewards;
    }
}
