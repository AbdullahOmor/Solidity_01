// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Election {

    struct Candidate {
        string name;
        string symbol;
        uint256 voteCount;
    }

    mapping (uint256 => Candidate) public candidates;
    mapping (address => bool) public hasVote;
    uint256 public candidateCount;

    constructor(){
        candidateCount = 0;
    }

    function addCandidate(string memory _name, string memory _symbol) public {
        candidateCount++;
        candidates[candidateCount] = Candidate ({
            name: _name,
            symbol: _symbol,
            voteCount: 0
        });
    }

    function vote(uint256 _candidateID) public {
        require(!hasVote[msg.sender], "Koiber Vote Dibi Vai");
        require(_candidateID > 0 && _candidateID <= candidateCount, "Leader nai");
        candidates[_candidateID].voteCount++;
        hasVote[msg.sender] = true;
    }

    function getWinner() public view returns (string memory winnerName, uint256 totalVotes) {
        require(candidateCount > 0, "Kew Darai nai");

        uint256 highestVote;
        uint256 winnerID;

        for (uint256 i = 1; i <= candidateCount; i++) {
            if(candidates[i].voteCount > highestVote) {
                highestVote = candidates[i].voteCount;
                winnerID = i;
            }
        }

        winnerName = candidates[winnerID].name;
        totalVotes = candidates[winnerID].voteCount;
    }
}