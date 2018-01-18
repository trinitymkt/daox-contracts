pragma solidity ^0.4.0;

import "./VotingLib.sol";
import "./VotingFields.sol";
import "../Common.sol";

contract Refund is VotingFields {
    address baseVoting;

    function Refund(address _baseVoting, address _dao, bytes32 _description, uint _duration, uint _quorum){
        baseVoting = _baseVoting;
        votingType = "Refund";
        VotingLib.delegatecallCreate(baseVoting, _dao, _description, _duration, _quorum);
        createOptions();
    }

    function addVote(uint optionID) {
        VotingLib.delegatecallAddVote(baseVoting, optionID);
    }

    function finish() {
        VotingLib.delegatecallFinish(baseVoting);
        if(result.description == "yes") dao.makeRefundableByVotingDecision();
    }

    function createOptions() private {
        options[1] = VotingLib.Option(0, "yes");
        options[2] = VotingLib.Option(0, "no");
    }

    function getOptions() external constant returns(uint[2] result) {
        for (uint i = 1; i < 3; i++) {
            result[i] = options[i].votes;
        }
    }
}