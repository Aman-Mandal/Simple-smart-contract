// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./PriceConverter.sol";

error NotOwner();

contract FundMe{
    // attaching our Library to uint256
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 10 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable{
        // Want to able to set a minimum fund in the USD
        // 1. How do we send ETH to the contract?

        // 'msg' is a global variable; msg.value gives is the amount send with the contract
        // 'require' is like response-error 

        // before : require(getConversionRate(msg.value))
        // after using library we can use the library functions as the methods like js
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough !!"); // 1e18 == 1 * 10 ** 18 === 10000000000000000
        funders.push(msg.sender);    // msg.sender will give the address of the user that calls the fund function

        // this will create a map of 'key' of addressess and value of 'amount'
        addressToAmountFunded[msg.sender] = msg.value;
    }


    function withdraw() public onlyOwner {

        // for loop for making the map empty
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;

        }

        // resetting the funders array
        funders = new address[](0);

        // actually withdrawing funds

        // Note : msg.sender will give address but for working with transaction we need 'payable address'

        // 3 types to withdraw : 

        // // 1. transfer
        // payable(msg.sender).transfer(address(this).balance);

        // // 2. send
        // bool sendSucess = payable(msg.sender).send(address(this).balance); // returns a boolean
        // require(sendSucess, "Send Failed"); // we can use the boolean to revert the transaction

        // 3. call - USE THIS ONE 
        (bool callSucess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSucess, "Call Failed");

    }


    // Its like a keyword we can use with function.
    modifier onlyOwner {
        // require(msg.sender == owner, "You can't use this, as you are not an owner");
        if(msg.sender != i_owner){revert NotOwner();}
        _;
    }
    
    receive() external payable {
        fund();
    }

    fallback() external payable{
        fund();
    }
    
}