import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";


const AvenPOAModule = buildModule("AvenPOAModule", (m) => {
  
  const avenPOA = m.contract("AvenPOA");

  return { avenPOA };
});

export default AvenPOAModule;
