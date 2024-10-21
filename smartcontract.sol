// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FitnessRewardToken is ERC20 {
    address public owner;
    uint256 public totalMembers;

    struct Member {
        bool exists;
        uint256 rewards;
    }

    mapping(address => Member) public members;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() ERC20("FitnessRewardToken", "FRT") {
        owner = msg.sender;
        _mint(owner, 1000000 * 10 ** decimals()); // Initial supply to owner
        totalMembers = 0;
    }

    // Add new member
    function addMember(address user) public onlyOwner {
        require(!members[user].exists, "User is already a member");
        members[user] = Member(true, 0); // New member with 0 initial rewards
        totalMembers++;
    }

    // Reward member
    function rewardUser(address user, uint256 amount) public onlyOwner {
        require(members[user].exists, "User is not a member");
        _transfer(owner, user, amount); // Transfer tokens from owner to user
        members[user].rewards += amount; // Update user's reward balance
    }

    // View member rewards
    function getMemberRewards(address user) public view returns (uint256) {
        require(members[user].exists, "User is not a member");
        return members[user].rewards;
    }

    // View total number of members
    function getTotalMembers() public view returns (uint256) {
        return totalMembers;
    }
}
