

let address;
async function main() {


  address = "0x15DE5d9EAFad20EbC3A572954459d7085A000e4d";

 


  
  const a = await ethers.provider.getStorageAt(address, 1);
  console.log(a);

  
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


