// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract lotteryself{

    address public manager;
    uint public deadline;
    uint public noofplayers;
    constructor(){
        manager=msg.sender;
        deadline = block.timestamp + 300;
    }
    modifier owner(){
        require(msg.sender == manager,"You are not the owner");
    _;
    }
    modifier notowner(){
        require(msg.sender != manager,"Owner not allowed");
    _;
    }
    struct  playerinfo{
        address payable playeradd;
        uint age;
        
    }
    playerinfo[] private  numberofplayers; 

    function newinfo() public view owner returns(playerinfo[] memory){
        return numberofplayers;
    }
    function buylottery(uint _playage) payable public notowner{  
               
        require(msg.value == 2000000000000000000,"Minimum ticket size is 2 Ether");
        require(_playage >= 18,"You are not allowed to play");
        require(block.timestamp < deadline,"Winner has been declared");
        numberofplayers.push(playerinfo(payable(msg.sender),_playage));
        noofplayers++;      
    }

    function Checkbal() public view owner returns(uint) {
        return address(this).balance;
    }

    function random() public view returns(uint){
        return uint(sha256(abi.encodePacked(block.timestamp,block.difficulty)));
    }

    function winner() public  payable  owner   {
        uint index = random() % numberofplayers.length;
        playerinfo memory  Winner = numberofplayers[index];
        Winner.playeradd.transfer(Checkbal());
    
    }
    
}

  
