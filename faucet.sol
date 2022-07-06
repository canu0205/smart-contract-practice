pragma solidity ^0.8.5;

contract Owned {
    address owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
}

contract Mortal is Owned {
    function destroy() public onlyOwner {
        selfdestruct(owner);
    }
}

contract Faucet is Mortal {
    function withdraw(uint withdraw_amount) public {
        require(withdraw_amount <= 0.1 ether);
        msg.sender.transfer(withdraw_amount);
    }

    fallback () public payable {}
}
