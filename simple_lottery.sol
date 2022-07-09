pragma solidity >=0.7.0 <0.9.0;

contract SimpleLottery {
    uint ticketingCloses;
    address[] public tickets;
    address public winner;

    constructor(uint duration) public {
        ticketingCloses = block.timestamp + duration * 1 minutes;
    }

    function buy() public payable {
        require(msg.value >= 0.0001 ether);
        require(block.timestamp < ticketingCloses);

        tickets.push(msg.sender);
    }

    fallback () payable external {
        buy();
    }

    function drawWinner() public {
        require(block.timestamp > ticketingCloses + 1 minutes);
        require(winner == address(0));

        bytes32 hash = blockhash(block.number -1);
        bytes32 rand = keccak256(abi.encode(hash));

        winner = tickets[uint(rand) % tickets.length];
    }

    function withdraw() public {
        require(msg.sender == winner);
        payable(msg.sender).transfer(address(this).balance);
    }
}
