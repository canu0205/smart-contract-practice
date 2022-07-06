pragma solidity >=0.7.0 <0.9.0;

contract SimplePonzi {
    address payable public currentInvestor;
    uint public currentInvestment = 0;

    fallback () external payable {
        uint minimumInvestment = currentInvestment * 11/10;
        require(msg.value > minimumInvestment);

        address payable previousInvestor = currentInvestor;
        currentInvestor = payable(msg.sender);
        currentInvestment = msg.value;

        previousInvestor.send(msg.value);
    }
}
