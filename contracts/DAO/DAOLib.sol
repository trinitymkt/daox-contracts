pragma solidity ^0.4.0;

import "../Token/TokenInterface.sol";
import "../Votings/VotingFactoryInterface.sol";

library DAOLib {
    event VotingCreated(address voting);

    function countTokens(TokenInterface token, uint weiAmount, uint[] bonusPeriods, uint[] bonusRates, uint rate, address _sender) constant returns (uint) {
        uint tokenRate = rate;
        for(uint i = 0; i < bonusPeriods.length; i++) {
            if(now < bonusPeriods[i]) tokenRate = bonusRates[i];
        }
        uint tokensAmount = weiAmount * tokenRate;
        token.mint(_sender, tokensAmount);

        return tokensAmount;
    }

    function countRefundSum(TokenInterface token, uint rate, uint newRate) constant returns (uint) {
        uint multiplier = 1000;
        uint newRateToOld = newRate*multiplier / rate;
        uint weiSpent = token.balanceOf(msg.sender) / rate;
        return weiSpent*multiplier / newRateToOld;
    }

    function handleFinishedCrowdsale(TokenInterface token, uint commissionRaised, address serviceContract, uint[] teamBonuses, address[] team, uint tokenHoldTime) {
        uint commission = (commissionRaised/100)*4;
        assert(!serviceContract.call.value(commission*1 wei)());
        for(uint i = 0; i < team.length; i++) {
            token.mint(team[i], (token.totalSupply()/100)*teamBonuses[i]);
            token.hold(team[i], tokenHoldTime);
        }
    }

    function delegateIsParticipant(address _parentAddress, address _participantAddress) constant returns (bool) {
        require(_parentAddress.delegatecall(bytes4(keccak256("isParticipant(address)")), _participantAddress));
    }

    function delegateAddParticipant(address _parentAddress, address _participantAddress) {
        require(_parentAddress.delegatecall(bytes4(keccak256("addParticipant(address)")), _participantAddress));
    }

    function delegateRemove(address _parentAddress, address _participantAddress) {
        require(_parentAddress.delegatecall(bytes4(keccak256("remove(address)")), _participantAddress));
    }

    //ToDo: finish proposal creating functions
    function delegatedCreateProposal(address _votingFactory, bytes32 _description, uint _duration, bytes32[] _options) returns (address) {
        address _votingAddress = VotingFactoryInterface(_votingFactory).createProposal(msg.sender, _description, _duration, _options);
        VotingCreated(_votingAddress);
        return _votingAddress;
    }

    function delegatedCreateWithdrawal(address _votingFactory, bytes32 _description, uint _duration, uint _sum) returns (address) {
        address _votingAddress = VotingFactoryInterface(_votingFactory).createWithdrawal(msg.sender, _description, _duration, _sum, 51);
        VotingCreated(_votingAddress);
        return _votingAddress;
    }

    function delegatedCreateRefund(address _votingFactory, bytes32 _description, uint _duration) returns (address) {
        address _votingAddress = VotingFactoryInterface(_votingFactory).createRefund(msg.sender, _description, _duration, 51);
        VotingCreated(_votingAddress);
        return _votingAddress;
    }

    function delegatedCreateWhiteList(address _votingFactory, bytes32 _description, uint _duration, address _addr, uint action) returns (address) {
        address _votingAddress = VotingFactoryInterface(_votingFactory).createWhiteList(msg.sender, _description, _duration, 51, _addr, action);
        VotingCreated(_votingAddress);
        return _votingAddress;
    }

    function delegatedInitCrowdsaleParameters(address _p, uint softCap, uint hardCap, uint rate, uint startBlock, uint endBlock) {
        require(_p.delegatecall(bytes4(keccak256("initCrowdsaleParameters(uint256,uint256,uint256,uint256,uint256)")), softCap, hardCap, rate, startBlock, endBlock));
    }

    function delegatedCreate(address _p, address _usersAddress, uint8 _minVote, address _tokenAddress,
    address _votingFactory, address _serviceContract, address _ownerAddress, address _parentAddress) {
        require(_p.delegatecall(bytes4(keccak256("create(address,uint8,address,address,address,address,address)")),
        _usersAddress, _minVote, _tokenAddress, _votingFactory, _serviceContract, _ownerAddress, _parentAddress));
    }

    function delegatedHandlePayment(address _p, address sender, bool commission) {
        require(_p.delegatecall(bytes4(keccak256("handlePayment(address,bool)")), sender, commission));
    }

    function delegatedFinish(address _p) {
        require(_p.delegatecall(bytes4(keccak256("finish()"))));
    }
}
