 const main = async () => 
{
    const[deployer] = await hre.ethers.getSigners();
    console.log("deploying contracts with account: ", deployer.address);

    const AlToken = await ethers.getContractFactory("AlToken");
    const alToken = await AlToken.deploy();

    console.log("AlToken deployed to:", alToken.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
