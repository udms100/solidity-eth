pragma solidity ^0.4.17; 



contract Lottery {
    address public manager;
    address[] public players;

    function Lottery() public {
        manager = msg.sender;
    }

    function enter() public  payable {
        require(msg.value > .01 ether);

        players.push(msg.sender);
        
      //sending the winner or the player some money  
    }
   
    function random() private view returns (uint) {
        return uint(keccak256(block.difficulty, now, players));
     }
     
     //
     // sending ether from the contract
     // this.balance means that we want to send
     // allthe money in the contract to to player that won the Lottery
     
    
    function pickWinner() public restricted  {
       // require(msg.sender == manager);   // requiring from the manager
        
        uint index = random() % players.length;
        players[index].transfer(this.balance);
        players = new address[](0);  
         
     }
     // to cancel the entire entry of
     // of the lottery and return the money 
     // to the players
     // note only the manager can call the returnEntries
     
    //function returnEntries() {
        // require(msg.sender == manager);
     //}
    
    // function modifier to avoid repeat
    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
    function getPlayers() public view returns (address[]) {
        return players;
    }
}