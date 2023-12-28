// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import"./Usdt.sol";
import "./AdminRole.sol";
import "./SignMessage.sol";

contract ETHPool is AdminRoleUpgrade {
    uint256 public teamsLength;
    uint256 public usersLength;

    USDT usdt;
    SignMessage signMessage;

    struct User {
        address user;
        uint256 deposit;
        uint256 depositTime;
        bool isGet;
    }

    struct Team {
        address team;
        uint256 reward;
        uint256 rewardTime;
        uint256 remain;
    }

    enum Kind {
        user,
        team
    }

    mapping(uint256 => User) public users;
    mapping(uint256 => Team) public teams;

    event Deposit(address indexed user, uint256 amount, Kind kind);
    event Withdrawal(address indexed user, uint256 amount);

    function setUsdt(address token) public onlyAdmin {
        usdt = USDT(token);
    }

    function setSignMessage(address sign) public onlyAdmin {
        signMessage = SignMessage(sign);
    }

    function userDeposit(uint256 value) public payable {
        usersLength ++;
        users[usersLength].user = msg.sender;
        users[usersLength].deposit = value;
        users[usersLength].depositTime = block.timestamp;
        users[usersLength].isGet = false;
        usdt.transferFrom(msg.sender, address(this), value);
        emit Deposit(msg.sender, value, Kind.user);
    }

    function teamDeposit(uint256 value, bytes calldata signature) public payable {
        //验证签名
        require(
            signMessage.verifySig(msg.sender, signature),
            "Signature verification failed"
        );
        teamsLength ++;
        teams[teamsLength].team = msg.sender;
        teams[teamsLength].reward = value;
        teams[teamsLength].rewardTime = block.timestamp;
        teams[teamsLength].remain = value;
        usdt.transferFrom(msg.sender, address(this), value);
        emit Deposit(msg.sender, value, Kind.team);
    }

    function withdraw(uint256 index) public {
       require(users[index].user == msg.sender, "not the owner");
       require(users[index].isGet == false, "getted");
       uint256 to = users[index].deposit;
       users[index].isGet = true;
       uint256 reward = calculatePendingRewards(index);
       usdt.transfer(msg.sender, to + reward);
       users[index].deposit = 0;
       emit Withdrawal(msg.sender, users[index].deposit);
    }

    function calculatePendingRewards(uint256 index) public returns (uint256) {
        uint256 i;
        uint256 j;
        uint256 k;
        uint256 m;
        uint256 reward;
        uint256 totalReward;
        uint256 totalDeposits;
        for(i = teamsLength; i >= 0; i--) {
            if(users[index].depositTime <= teams[i].rewardTime) {
                break;
            }
        }

        for(j = 0; j <= i; j++) {
            totalReward += teams[i].reward;
        }

        for(k = 0; k <= index; k++) {
            totalDeposits += users[k].deposit;
        }
        reward = (((users[index].deposit) * 100/ totalDeposits)*totalReward) / 100;
        for(m = 0; m <= i; m++) {
            teams[m].reward -= ((teams[m].reward)*((users[index].deposit) * 100/ totalDeposits))/100;
        }
        return reward;
    }
}