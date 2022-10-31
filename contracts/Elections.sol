pragma solidity ^0.5.16;

contract Elections {
	//model a candidate
	struct Candidate {
		uint id;
		string name;
		uint voteCount;
	}
	//store candidate
	mapping(address => bool) public voters;
	//fetch candidate
	mapping(uint => Candidate) public candidates;
	//store candidate count
	uint public candidatescount;

	event votedEvent (uint indexed _candidateId);

 	constructor() public {
 		AddCandidate("Candidate 1");
 		AddCandidate("Candidate 2");
 	}

 	function AddCandidate(string memory _name) private {
 		candidatescount ++;
 		candidates[candidatescount] = Candidate(candidatescount, _name, 0);
 	}

	function vote (uint _candidateId) public {
		// require that they haven't voted before
		require(!voters[msg.sender]);

		// require a valid candidate
		require(_candidateId > 0 && _candidateId <= candidatescount);

		// record that voter has voted
		voters[msg.sender] = true;

		// update candidate vote Count
		candidates[_candidateId].voteCount ++;

		// trigger voted event
		emit votedEvent(_candidateId);
	}
}
