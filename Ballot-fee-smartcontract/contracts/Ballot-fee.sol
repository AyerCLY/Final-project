// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract BallotFee{
    
    uint256 YesCounter = 0;
    uint256 NoCounter = 0;
    address public DAOOwner;
    address private m_tokenAddress;
    string public proposal;
    event NewProposal(string name);
    event votedYes (address voter); //who voted yes
    event votedNo (address voter);//who voted no

    constructor(address tokenAddress) {
        DAOOwner = msg.sender;
        m_tokenAddress = tokenAddress; //let ballot contract remember coin contract
    }

    function approve(uint256 intAmt) public { // set how much
        IERC20(m_tokenAddress).approve(address(this), intAmt); //1. construct ERC20 token (YER token) 2. call ERC20 contract 'approve' function 3. approve function 'parameter' in this contract address
    }
    function setProposal(string memory _proposal) external {
        require (msg.sender == DAOOwner);
        proposal = _proposal; 
        emit NewProposal(_proposal);
    }

    function voteYes() public {
        IERC20(m_tokenAddress).transferFrom(msg.sender, address(this), 10000000000000000000);
        YesCounter++;
        emit votedYes(msg.sender);
    }
    function getYesCount() public view returns (uint256) {
        return YesCounter;
    }
    function voteNo() public {
        IERC20(m_tokenAddress).transferFrom(msg.sender, address(this), 10000000000000000000);
        NoCounter++;
        emit votedNo(msg.sender);
    }
    function getNoCount() public view returns (uint256) {
        return NoCounter;
    }

    function withdrawMoney() public {
        uint256 contractBal = IERC20(m_tokenAddress).balanceOf(address(this));
        IERC20(m_tokenAddress).transfer(DAOOwner, contractBal);    
    }
    
}