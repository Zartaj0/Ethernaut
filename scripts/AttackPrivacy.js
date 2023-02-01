

let address;
async function main() {

    // const Privacy = await ethers.getContractFactory("Privacy");
    // const privacy = await Privacy.deploy;
    // await privacy.deployed;
    //   address = privacy.address;

    address = "0x5CAF066eA9fA4ab8DF6AbCa13d67F06298AE01d4";

    

    const a = await ethers.provider.getStorageAt(address, 0);
    const b = await ethers.provider.getStorageAt(address, 1);
    const c = await ethers.provider.getStorageAt(address, 2);
    const d= await ethers.provider.getStorageAt(address, 3);
    const e = await ethers.provider.getStorageAt(address, 4);
    const f = await ethers.provider.getStorageAt(address, 5);

    console.log(a);
    console.log(b);
    console.log(c);
    console.log(d);
    console.log(e);
    console.log(f);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});



