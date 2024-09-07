import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const AvenModule = buildModule("AvenModule", (m) => {
  // Use a valid Ethereum address here
  const AvenPOAAddress = "0x1234567890abcdef1234567890abcdef12345678";
  
  // Pass the valid address to the Aven contract
  const aven = m.contract("Aven", AvenPOAAddress);

  return { aven };
});

export default AvenModule;
