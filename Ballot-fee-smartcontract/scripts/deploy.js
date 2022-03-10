
const hre = require("hardhat");

async function main() {

  const [owner] = await hre.ethers.getSigners();
  const BallotContractFactory = await hre.ethers.getContractFactory("BallotFee");
  const BallotContract = await BallotContractFactory.deploy("0x1E294987A5c25A59d35c14C8f6bbF8e81a0CF6C1");//let ballot contract know what coin to remember
  await BallotContract.deployed();

  console.log("BallotContract deployed to:", BallotContract.address);
  console.log("BallotContract owner address:", owner.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
