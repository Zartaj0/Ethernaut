const abi = require("../artifacts/contracts/Lock.sol/CoinFlip.json")

async function main() {
 
  // const Lock = await hre.ethers.getContractFactory("CoinFlip");
  // const lock = await Lock.deploy();

  // await lock.deployed();

  // console.log(
  //   `${lock.address}`
  // );
  

  const Attack = await hre.ethers.getContractFactory("Attack");
  const attack = await Attack.deploy("0x1EEDA01f6ea923901E51e262F23a00A3d7eAB606");

  await attack.deployed();



  await   attack.attack();

}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
