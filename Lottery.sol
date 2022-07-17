pragma solidity >=0.7.0 <0.9.0;

contract Lottery {
    address public manager;
    address[] public players;
    address payable public winner;

    constructor() {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value >= 0.1 ether);
        players.push(msg.sender);
    }

    function pickWinner() public {
        require(msg.sender == manager);
        
        winner = payable(players[random() % players.length]);
        winner.transfer(address(this).balance);
        players = new address[](0);
    }

    function random() private view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
    }
}
