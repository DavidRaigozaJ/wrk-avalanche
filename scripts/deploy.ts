import { 
  Contract, 
  ContractFactory 
} from "ethers"
import { ethers } from "hardhat"

const main = async(): Promise<any> => {
  const Coin: ContractFactory = await ethers.getContractFactory("ExampleERC20")
  const coin: Contract = await Coin.deploy()

  await coin.deployed()
  console.log(`Coin deployed to: ${coin.address}`)
}

async function Token() {
  const stakingTokenAddress = '0x5FbDB2315678afecb367f032d93F642f64180aa3'; // Put the address of the ERC20 token you want to use for staking

  // Deploy StakingContract
  const StakingContract = await ethers.getContractFactory('StakingContract');
  const stakingContract = await StakingContract.deploy(stakingTokenAddress);
  await stakingContract.deployed();

  console.log('StakingContract deployed to:', stakingContract.address);
}

main()
.then(() => process.exit(0))
.catch(error => {
  console.error(error)
  process.exit(1)
})
