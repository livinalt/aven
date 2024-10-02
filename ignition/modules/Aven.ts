import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const AvenModule = buildModule("AvenModule", (m) => {

  const AvenPOAAddress = "0x894801D9fB0Dafb92a36951592Eb4720b535D816";
  
  const aven = m.contract("Aven", [AvenPOAAddress]);

  return { aven };
});

export default AvenModule;
