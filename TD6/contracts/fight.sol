pragma solidity ^0.4.25;

import "./ERC721.sol";

contract arena {
	ERC721 m_contract;
	using Address for address;
    using Counters for Counters.Counter;
	
	uint money; 
	address winner;
	event fightResult(address breeder, uint gain);
	address _breederWhoProposed;	
	uint _readyToFightAnimal;
	bool fightProposed;
	bool fightOpen;
	bool fightFinished;
	
	
	function proposeToFight(uint horseID, uint _money)
	{
		m_contract.isWhitelisted(_breederWhoProposed);
		m_contract.changeReadyToFight(true, horseID);
		_readyToFightAnimal=horseID;
		fightProposed=true;
		money=_money;
	}
	
	function agreeToFight(uint horseID)
	{
		require(fightProposed==true);
		
		m_contract.isWhitelisted(msg.sender);
		require(_breederWhoProposed!=msg.sender);
		m_contract.changeReadyToFight(true, horseID);
		fightOpen=true;
	}
	
	function fight()
	{
		require(fightOpen==true);
		
		uint result=m_contract.random(); //0=celui qui propose perd, 1=victoire
		if(result==0){
		m_contract.changeAlive(false, _readyToFightAnimal);	
		winner=msg.sender;
		}
		else {m_contract.changeAlive(true, _readyToFightAnimal);
		winner=_breederWhoProposed;
		}	
		fightFinished=true;
	}
	
	function closeFight() {
        require(!fightFinished);
		money+=money;
        //fightResult(winner, money);
	}
}
