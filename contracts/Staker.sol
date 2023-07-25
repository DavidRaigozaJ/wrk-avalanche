// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

error StakeCollateral__IncreaseAmount();

/**
 * @title WorkForce
 * @author WorkBros
 * @notice 
 */

contract StakingContract {

    IERC20 public stakingToken;

    // Struct to store job data
    struct Job {
        address contractor;
        address worker;
        uint256 amount;
        uint256 deadline;
        bool isCompleted;
        bool isDisputed;
    }

    // Struct to store user's staking data
    struct StakerData {
        uint256 totalStaked;
        uint256 lastStakedTimestamp;
    }

    mapping(address => StakerData) public stakers;
    mapping(uint256 => Job) public jobs;
    uint256 public nextJobId = 1;

    constructor(address _stakingToken) {
        stakingToken = IERC20(_stakingToken);
    }

    function hireForJob(address worker, uint256 amount) public {
        if (amount < 0) {
            revert StakeCollateral__IncreaseAmount();
        }

        stakingToken.approve(address(this), amount);

        // Update staker's data
        StakerData storage staker = stakers[msg.sender];
        staker.totalStaked += amount;
        staker.lastStakedTimestamp = block.timestamp;

        // Set the deadline 1 day from the current timestamp (you can modify this duration as needed)
        uint256 deadline = block.timestamp + 1 days;

        // Create a new job
        jobs[nextJobId] = Job({
            contractor: msg.sender,
            worker: worker,
            amount: amount,
            deadline: deadline,
            isCompleted: false,
            isDisputed: false
        });
        nextJobId++;
    }

    function markJobCompleted(uint256 jobId) public {
        Job storage job = jobs[jobId];
        require(msg.sender == job.worker, "Only the worker can mark the job as completed");
        require(!job.isCompleted, "Job is already marked as completed");
        require(block.timestamp <= job.deadline, "Deadline has passed");

        // Update job status
        job.isCompleted = true;
    }

    function withdrawStake() public {
        StakerData storage staker = stakers[msg.sender];
        uint256 amount = staker.totalStaked;
        require(amount > 0, "Nothing to withdraw, stake first");

        staker.totalStaked = 0;
        staker.lastStakedTimestamp = block.timestamp;

        stakingToken.transfer(msg.sender, amount);
    }

    // Function to stake tokens into the contract
    function stakeTokens(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");

        // Transfer the tokens from the sender to the contract
        stakingToken.transferFrom(msg.sender, address(this), amount);

        // Update staker's data
        StakerData storage staker = stakers[msg.sender];
        staker.totalStaked += amount;
        staker.lastStakedTimestamp = block.timestamp;
    }

    // Function to raise a dispute for a job completion
    function disputeJob(uint256 jobId) public {
        Job storage job = jobs[jobId];
        require(msg.sender == job.contractor || msg.sender == job.worker, "Only the contractor or worker can raise a dispute");
        require(!job.isCompleted, "Job is already marked as completed");
        require(!job.isDisputed, "Job is already disputed");

        job.isDisputed = true;
    }

    receive() external payable {
        // You can add any additional logic here if required when receiving Ether
    }
}
