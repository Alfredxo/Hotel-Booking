const main = async () => {
  const[deployer] = await hre.ethers.getSigners();
  console.log("deploying contracts with account: ", deployer.address);
  
  const ERC20PaymentContractFactory = await hre.ethers.getContractFactory("ERC20Payment");
  const ERC20PaymentContract = await ERC20PaymentContractFactory.deploy();

  console.log("ERC20Payment Address", ERC20PaymentContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });