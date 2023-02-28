// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

// JointSavings contract
contract JointSavings {
    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    function withdraw(uint amount, address payable recipient) public {

        // checks to see if recipient is one of two acceptable addresses
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

        // checks to make sure there's enough ether to withdraw
        require(contractBalance >= amount, "Insufficent Funds!");

        // checks to see if the last to withdraw was the recipient trying to withdraw
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // transfers the amount requested
        recipient.transfer(amount);

        // sets last withdrawal amount to amount being withdrawn
        lastWithdrawAmount = amount;

        // updates the contract balance
        contractBalance = address(this).balance;
    }

    // deposit function
    function deposit() public payable {

        // updates contract balance
        contractBalance = address(this).balance;
    }

    /*
    Define a `public` function named `setAccounts` that receive two `address payable` arguments named `account1` and `account2`.
    */
    function setAccounts(address payable account1, address payable account2) public{

        // Set the values of `accountOne` and `accountTwo` to `account1` and `account2` respectively.
        accountOne = account1;
        accountTwo = account2;
    }

    /*
    Finally, add the **default fallback function** so that your contract can store Ether sent from outside the deposit function.
    */
    // receive function for receiving ether
    receive() external payable {}

    // fallback function for receiving ether
    fallback() external payable {}
}
